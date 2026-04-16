package com.mmu.shuttle.backend.exceptions;

import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.Message;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.socket.messaging.StompSubProtocolErrorHandler;

import java.nio.charset.StandardCharsets;

@Slf4j
public class WebSocketExceptionHandler extends StompSubProtocolErrorHandler {

    @Override
    public Message<byte[]> handleClientMessageProcessingError(Message<byte[]> clientMessage, Throwable ex) {
        log.error(ex.getMessage(), ex);

        Throwable cause = ex;
        while (cause.getCause() != null) {
            cause = cause.getCause();
        }
        String errorMessage = cause.getMessage() != null ? cause.getMessage() : "Unknown STOMP Error";

        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.ERROR);
        accessor.setMessage(errorMessage);
        accessor.setLeaveMutable(true);

        byte[] payload = errorMessage.getBytes(StandardCharsets.UTF_8);
        accessor.setContentType(MimeTypeUtils.TEXT_PLAIN);
        accessor.setContentLength(payload.length);

        return MessageBuilder.createMessage(payload, accessor.getMessageHeaders());
    }
}
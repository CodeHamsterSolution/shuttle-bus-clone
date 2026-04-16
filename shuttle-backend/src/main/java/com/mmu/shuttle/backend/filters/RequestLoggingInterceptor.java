package com.mmu.shuttle.backend.filters;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
@Component
public class RequestLoggingInterceptor implements HandlerInterceptor {

    private static final String START_TIME_ATTR = "startTime";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        long startTime = System.currentTimeMillis();
        request.setAttribute(START_TIME_ATTR, startTime);

        log.info("INCOMING REQUEST: Method=[{}] URI=[{}] ClientIP=[{}]",
                request.getMethod(),
                request.getRequestURI(),
                request.getRemoteAddr());

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        long startTime = (Long) request.getAttribute(START_TIME_ATTR);
        long duration = System.currentTimeMillis() - startTime;
        int status = response.getStatus();

        if (ex != null || status >= 400) {

            String errorMessage = (ex != null) ? ex.getMessage() : "Handled by @ControllerAdvice";

            if (status >= 500 || ex != null) {
                log.error("SERVER ERROR: Method=[{}] URI=[{}] Status=[{}] Duration=[{}ms] Error=[{}]",
                        request.getMethod(),
                        request.getRequestURI(),
                        status,
                        duration,
                        errorMessage);
            } else {
                log.warn("CLIENT ERROR: Method=[{}] URI=[{}] Status=[{}] Duration=[{}ms] Note=[{}]",
                        request.getMethod(),
                        request.getRequestURI(),
                        status,
                        duration,
                        errorMessage);
            }

        } else {
            log.info("REQUEST COMPLETED: Method=[{}] URI=[{}] Status=[{}] Duration=[{}ms]",
                    request.getMethod(),
                    request.getRequestURI(),
                    status,
                    duration);
        }
    }
}
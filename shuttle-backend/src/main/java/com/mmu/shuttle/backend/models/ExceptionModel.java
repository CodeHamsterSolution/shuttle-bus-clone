package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class ExceptionModel {
    private LocalDateTime timestamp;
    private int status;
    private String error;
    private String message;
    private String path;
}
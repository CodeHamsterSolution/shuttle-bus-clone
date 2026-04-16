package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class DriverModel {
    private Long id;
    private String email;
    private String busPlate;
}

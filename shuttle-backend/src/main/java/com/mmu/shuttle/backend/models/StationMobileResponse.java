package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class StationMobileResponse {
    private Long id;
    private String name;
    private LocationModel location;
}

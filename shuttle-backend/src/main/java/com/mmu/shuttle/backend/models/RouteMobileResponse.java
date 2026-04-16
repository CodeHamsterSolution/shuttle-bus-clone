package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class RouteMobileResponse {
    private Long id;
    private String name;
    private int totalStations;
    private List<StationMobileResponse> stations;
    private List<LocationModel> routeLine;
}

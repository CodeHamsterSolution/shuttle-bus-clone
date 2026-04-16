package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class RouteDetailResponse {
    private Long id;
    private String name;
    private int totalStation;
    private List<StationDetailResponse> stationDetailResponse;
    private List<LocationModel> routeLines;
}




package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class RouteWebResponse {
    private Long id;
    private String routeName;
    private int totalStations;
    private boolean isLive;
    private String color;
}

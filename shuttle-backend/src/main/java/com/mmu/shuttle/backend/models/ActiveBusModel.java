package com.mmu.shuttle.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ActiveBusModel {
    private Long id;
    private Long routeId;
    private String busPlate;
    private LocationModel location;
    private Long nextBusStationId;
    private int nextSequence;
    private boolean active = true;
    private String color;
}

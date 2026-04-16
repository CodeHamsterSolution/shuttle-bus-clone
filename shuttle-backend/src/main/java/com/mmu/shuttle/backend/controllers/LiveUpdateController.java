package com.mmu.shuttle.backend.controllers;

import com.mmu.shuttle.backend.models.BusLocationModel;
import com.mmu.shuttle.backend.services.ActiveBusStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/live-update")
public class LiveUpdateController {

    @Autowired
    private ActiveBusStoreService activeBusStoreService;

    @MessageMapping("/updateLocation")
    public void getBusLiveLocation(@Payload BusLocationModel busLocationModel, Authentication authentication){
        activeBusStoreService.updateBusLocation(busLocationModel,authentication);
    }

    @PreAuthorize("hasRole('DRIVER')")
    @PostMapping("/clear")
    public ResponseEntity<Boolean> clearActiveBuses(){
        activeBusStoreService.clearActiveBuses();
        return new ResponseEntity<>(true, HttpStatus.OK);
    }
}

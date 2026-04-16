package com.mmu.shuttle.backend.caches;

import com.mmu.shuttle.backend.exceptions.DuplicateResourceException;
import com.mmu.shuttle.backend.models.ActiveBusModel;
import com.mmu.shuttle.backend.models.LocationModel;
import com.mmu.shuttle.backend.utils.StyleUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;

@Component
public class ActiveBusStore {

    private final ConcurrentHashMap<Long, List<ActiveBusModel>> activeBuses = new ConcurrentHashMap<>();
    private final Map<Long, Integer> routeTicketDispenser = new ConcurrentHashMap<>();
    private final AtomicLong currentActiveBusId = new AtomicLong(1L);

    public ActiveBusModel addActiveBus(Long routeId, String busPlate, double longitude, double latitude, Long nextStationId) {

        boolean busExists = activeBuses.values().stream()
                .flatMap(List::stream)
                .anyMatch(bus ->busPlate.equalsIgnoreCase(bus.getBusPlate()));

        if (busExists) {
            throw new DuplicateResourceException("Bus with plate " + busPlate + " is already in a ride.");
        }

        int myTicket = routeTicketDispenser.compute(routeId, (key, currentValue) ->
                (currentValue == null) ? 1 : currentValue + 1
        );

        ActiveBusModel activeBusModel = new ActiveBusModel();
        Long activeBusId = currentActiveBusId.getAndIncrement();
        activeBusModel.setId(activeBusId);
        activeBusModel.setBusPlate(busPlate);
        activeBusModel.setRouteId(routeId);
        activeBusModel.setNextBusStationId(nextStationId);
        activeBusModel.setNextSequence(1);
        activeBusModel.setColor(StyleUtils.getBusIconColor(myTicket));

        LocationModel locationModel = new LocationModel();
        locationModel.setLatitude(latitude);
        locationModel.setLongitude(longitude);
        activeBusModel.setLocation(locationModel);

        activeBuses.computeIfAbsent(routeId, k -> new CopyOnWriteArrayList<>()).add(activeBusModel);

        return activeBusModel;
    }

    public ActiveBusModel removeActiveBus(Long routeId, String busPlate) {
        List<ActiveBusModel> activeBusModels = activeBuses.get(routeId);

        if (activeBusModels == null) {
            return null;
        }

        ActiveBusModel busToRemove = activeBusModels.stream()
                .filter(bus -> busPlate.equalsIgnoreCase(bus.getBusPlate()))
                .findFirst()
                .orElse(null);

        busToRemove.setActive(false);

        activeBusModels.remove(busToRemove);

        if (activeBusModels.isEmpty()) {
            activeBuses.remove(routeId);
        }

        return busToRemove;
    }

    public List<ActiveBusModel> getActiveBusesByRouteId(Long routeId){
        return activeBuses.getOrDefault(routeId, new ArrayList<>());
    }

    public ActiveBusModel updateBusLocation(Long routeId, String busPlate, LocationModel newLocation) {
        List<ActiveBusModel> activeBusModels = activeBuses.get(routeId);

        if (activeBusModels != null && !activeBusModels.isEmpty()) {
            for (ActiveBusModel bus : activeBusModels) {
                if (bus.getBusPlate().equalsIgnoreCase(busPlate)) {
                    bus.setLocation(newLocation);
                    return bus;
                }
            }
        }

        return null;
    }

    public ActiveBusModel getActiveBusByBusPlate(String busPlate) {
        return activeBuses.values().stream()
                .flatMap(List::stream)
                .filter(bus -> busPlate.equals(bus.getBusPlate()))
                .findFirst()
                .orElse(null);
    }

    public void resetAll() {
        activeBuses.clear();
        routeTicketDispenser.clear();
        currentActiveBusId.set(1L);
    }
}


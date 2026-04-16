package com.mmu.shuttle.backend.caches;

import com.mmu.shuttle.backend.entities.Route;
import com.mmu.shuttle.backend.repositories.RouteRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.stream.Collectors;

@Component
public class RouteCache {

    private Map<Long, Route> routeCache = new ConcurrentHashMap<>();

    @Autowired
    private RouteRepository routeRepository;

    @PostConstruct
    public void initCache() {
        routeCache = routeRepository.findAllWithStations().stream()
                .collect(Collectors.toMap(Route::getId, Function.identity()));
    }

    public Optional<Route> getRoute(Long routeId) {
        return Optional.ofNullable(routeCache.get(routeId));
    }

    public List<Route> getAllRoutes() {
        return new ArrayList<>(routeCache.values());
    }

    public void refreshCache() {
        initCache();
    }
}
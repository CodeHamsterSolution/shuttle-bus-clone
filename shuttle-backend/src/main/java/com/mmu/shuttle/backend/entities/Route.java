package com.mmu.shuttle.backend.entities;

import com.mmu.shuttle.backend.models.LocationModel;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="routes")
@Getter
@Setter
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private int totalStation;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private List<LocationModel> routeLines = new ArrayList<>();

    @OneToMany(mappedBy = "route")
    private List<RouteStation> routeStations = new ArrayList<>();

    @OneToMany(mappedBy = "route")
    private List<Schedule> schedules = new ArrayList<>();

}

package com.mmu.shuttle.backend.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AnnouncementRequest {
    private String title;
    private String description;

    @JsonProperty("isPinned")
    private boolean isPinned;
}

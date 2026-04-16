package com.mmu.shuttle.backend.utils;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class TimeUtils {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("h:mm a");

    public static String findNextSlot(List<String> timeSlots) {
        if (timeSlots == null || timeSlots.isEmpty()) return "";

        List<LocalTime> parsedTimes = timeSlots.stream()
                .map(t -> LocalTime.parse(t.toUpperCase(), FORMATTER))
                .toList();

        LocalTime now = LocalTime.now();
        Optional<LocalTime> targetTime;

        targetTime = parsedTimes.stream()
                .filter(t -> t.isAfter(now))
                .min(Comparator.naturalOrder());

        return targetTime.map(t -> t.format(FORMATTER)).orElse("");
    }
}

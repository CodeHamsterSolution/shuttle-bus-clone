package com.mmu.shuttle.backend.utils;

public class StyleUtils {

    private static String getColorByNumber(int number) {
        int colorSlot = number % 3;

        return switch (colorSlot) {
            case 1 -> "#113A9F"; // Blue
            case 2 -> "#22C55E"; // Green-500 equivalent
            case 0 -> "#0EA5E9"; // Sky-500 equivalent
            default -> "#6B7280"; // Gray-500 equivalent
        };
    }

    public static String getRouteColor(Long id) {
        if (id == null) return "#6B7280";
        return getColorByNumber(id.intValue());
    }

    public static String getBusIconColor(int ticketNumber) {
        return getColorByNumber(ticketNumber);
    }
}
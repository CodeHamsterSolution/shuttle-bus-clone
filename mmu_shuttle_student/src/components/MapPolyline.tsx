/// <reference types="google.maps" />
import { useMap } from "@vis.gl/react-google-maps";
import { useEffect, useRef } from "react";
import type { Location } from "../interfaces/models/Location";

interface MapPolylineProps {
    path?: Location[];
    strokeColor?: string;
    strokeWeight?: number;
}

const MapPolyline = ({ path, strokeColor = "#fbbf24", strokeWeight = 5 }: MapPolylineProps) => {
    const map = useMap();
    const polylineRef = useRef<google.maps.Polyline | null>(null);

    useEffect(() => {
        if (!map || typeof google === "undefined" || !path) return;

        const googlePath = path.map(p => ({ lat: p.lat, lng: p.lng }));

        if (!polylineRef.current) {
            polylineRef.current = new google.maps.Polyline({
                path: googlePath,
                strokeColor,
                strokeWeight,
                strokeOpacity: 1.0,
            });
        } else {
            polylineRef.current.setPath(googlePath);
        }

        polylineRef.current.setMap(map);

        return () => {
            if (polylineRef.current) {
                polylineRef.current.setMap(null);
            }
        };
    }, [map, path, strokeColor, strokeWeight]);

    return null;
};

export default MapPolyline;

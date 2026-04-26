import type { Location } from "./Location";

export interface ActiveBus {
    id: number;
    busPlate: string;
    location: Location;
    nextSequence: number;
    nextStationId: number;
    active: boolean;
    color: string;
    isAtStation: boolean;
    lastVisitedStationId?: number;
}
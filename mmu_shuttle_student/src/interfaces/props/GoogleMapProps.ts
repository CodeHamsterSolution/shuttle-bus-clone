import type { ActiveBus } from "../models/ActiveBus";
import type { Location } from "../models/Location";
import type { Station } from "../models/Station";

export interface GoogleMapProps {
    routeLine: Location[];
    activeBuses?: ActiveBus[];
    stations: Station[];
}
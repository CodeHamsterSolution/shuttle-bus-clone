import type { Station } from "./Station";
import type { Location } from "./Location";

export interface Route {
    id: number;
    routeName: string;
    totalStations: number;
    isLive: boolean;
    stations?: Station[];
    routeLine?: Location[];
    color: string;
}

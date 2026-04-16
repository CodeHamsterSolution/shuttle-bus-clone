import type { Station } from "../models/Station";
import type { ActiveBus } from "../models/ActiveBus";

export interface StationAccordianProps {
    stations: Station[];
    activeBuses?: ActiveBus[];
    isLoading: boolean;
    isError: boolean;
    errorMessage? : string;
}
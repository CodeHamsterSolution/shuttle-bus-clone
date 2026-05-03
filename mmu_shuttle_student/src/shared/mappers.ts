import type { Route } from "../interfaces/models/Route";
import type { Station } from "../interfaces/models/Station";
import type { Location } from "../interfaces/models/Location";
import type { ActiveBus } from "../interfaces/models/ActiveBus";

export const mapRouteResponseToRouteModel = (apiData: any): Route => {
    return {
        id: apiData.id,
        routeName: apiData.name,
        totalStations: apiData.totalStation,
        isLive: apiData.live,
        color: apiData.color,

        stations: apiData.stationDetailResponse?.map((station: any): Station => ({
            id: station?.id,
            name: station?.name,
            sequence: station?.sequence,
            schedule: station?.schedules,
            nextBusArrivalTime: station?.nextBusArrivalTime ?? undefined,
            location: {
                lat: station?.locationModel?.latitude,
                lng: station?.locationModel?.longitude
            }
        })) || [],

        routeLine: apiData.routeLines?.map((line: any): Location => ({
            lat: line?.latitude,
            lng: line?.longitude
        })) || []
    };
};


export const mapActiveBusResponseToActiveBusModel = (apiData: any): ActiveBus => {
    return {
        id: apiData?.id,
        busPlate: apiData?.busPlate,
        location: {
            lat: apiData?.location?.latitude,
            lng: apiData?.location?.longitude
        },
        nextSequence: apiData?.nextSequence,
        nextRouteStationId: apiData?.nextBusRouteStationId,
        active: apiData?.active,
        color: apiData?.color,
        isAtStation: apiData?.atStation,
        lastVisitedRouteStationId: apiData?.lastVisitedRouteStationId 
    };
}
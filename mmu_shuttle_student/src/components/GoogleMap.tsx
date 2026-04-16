import { Map, AdvancedMarker } from "@vis.gl/react-google-maps";
import { GOOGLE_MAPS_ID } from "../shared/constants";
import type { GoogleMapProps } from "../interfaces/props/GoogleMapProps";
import MapPolyline from "./MapPolyline";
import BusIcon from "./BusIcon";
import StationPin from "./StationPin";
import { MMMU_LOCATION } from "../shared/constants";

const GoogleMap = ({ routeLine, activeBuses, stations }: GoogleMapProps) => {
    const startingPoint = routeLine?.[0] || MMMU_LOCATION;
    return <>
        <Map
            defaultZoom={15}
            defaultCenter={startingPoint}
            mapId={GOOGLE_MAPS_ID}
            disableDefaultUI={true}
            gestureHandling="greedy"
        >
            {routeLine && routeLine.length > 0 && <MapPolyline path={routeLine} />}

            {stations && stations.length > 0 && stations.map((station,index) => (
                <AdvancedMarker
                    key={`station-${station.id}`}
                    position={station.location}
                >
                    <StationPin name={station.name} sequence={index} />
                </AdvancedMarker>
            ))}

            {activeBuses && activeBuses.length > 0 && activeBuses.map((bus, index) => (
                <AdvancedMarker
                    key={index}
                    position={bus.location}
                >
                    <div>
                        <BusIcon carPlate={bus.busPlate} color={bus.color}/>
                    </div>
                </AdvancedMarker>
            ))}
        </Map></>
}

export default GoogleMap;
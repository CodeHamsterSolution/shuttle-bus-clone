import { MapPin } from "lucide-react";
import type { RouteCardProps } from "../interfaces/props/RouteCardProps";

const RouteCard = ({
    route,
    indicatorColor,
    onClick
}: RouteCardProps) => {
    return (
        <div className="bg-white rounded-[16px] shadow-[0_2px_12px_rgb(0,0,0,0.03)] border border-gray-100 hover:shadow-md hover:-translate-y-0.5 transition-all cursor-pointer p-6 md:p-8 flex items-center gap-4 md:gap-5 w-full sm:w-[340px] md:w-[380px]" onClick={onClick}>
            <div style={{ backgroundColor: indicatorColor }} className={`w-1.5 md:w-2 h-12 md:h-14 rounded-full flex-shrink-0`}></div>
            <div className="flex flex-col gap-1.5 md:gap-2 flex-grow">
                <div className="flex items-start justify-between gap-2">
                    <h3 className="text-lg md:text-xl font-bold text-slate-800 tracking-tight leading-tight">
                        {route.routeName}
                        {route.isLive}
                    </h3>
                    {route.isLive && (
                        <span className="px-2 py-1 bg-red-50 text-red-600 text-[10px] md:text-xs font-bold rounded flex items-center gap-1.5 border border-red-100 shadow-sm whitespace-nowrap mt-0.5">
                            <span className="w-1.5 h-1.5 bg-red-500 rounded-full animate-pulse"></span>
                            LIVE
                        </span>
                    )}
                </div>
                <div className="flex items-center gap-1.5 md:gap-2 text-slate-500">
                    <MapPin className="w-4 h-4 md:w-5 md:h-5" strokeWidth={2.5} />
                    <span className="text-sm md:text-base font-medium">{route.totalStations} stops</span>
                </div>
            </div>
        </div>
    );
};

export default RouteCard;
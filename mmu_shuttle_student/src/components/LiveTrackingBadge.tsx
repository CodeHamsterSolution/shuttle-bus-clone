import type { LiveTrackingBadgeProps } from "../interfaces/props/LiveTrackingBadgeProps";
import { AlertCircle, Loader2 } from "lucide-react";

const LiveTrackingBadge = ({ isLiveTracking, isLoading, isError, errorMessage }: LiveTrackingBadgeProps) => {
    return (
        <div
            className={`absolute top-4 right-4 md:right-6 lg:top-6 lg:right-6 z-20 flex items-center gap-2 bg-white px-4 py-2 rounded-full shadow-[0_2px_12px_rgb(0,0,0,0.08)] border border-gray-100 w-max`}
        >
            {isError ? (
                <>
                    <AlertCircle className="w-4 h-4 text-red-500" />
                    <span className="text-[14px] font-bold text-red-500 tracking-tight">
                        {errorMessage}
                    </span>
                </>
            ) : isLoading ? (
                <>
                    <Loader2 className="w-4 h-4 text-blue-500 animate-spin" />
                    <span className="text-[14px] font-bold text-blue-500 tracking-tight">
                        Loading...
                    </span>
                </>
            ) : isLiveTracking ? (
                <>
                    <div className="relative flex h-3 w-3 items-center justify-center">
                        <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-red-400 opacity-75"></span>
                        <span className="relative inline-flex h-2.5 w-2.5 rounded-full bg-[#ff8a8a]"></span>
                    </div>
                    <span className="text-[14px] font-bold text-gray-900 tracking-tight">
                        Live Tracking
                    </span>
                </>
            ) : (
                <>
                    <div className="relative flex h-3 w-3 items-center justify-center">
                        <span className="relative inline-flex h-2.5 w-2.5 rounded-full bg-gray-400"></span>
                    </div>
                    <span className="text-[14px] font-bold text-gray-500 tracking-tight">
                        No Active Bus
                    </span>
                </>
            )}
        </div>
    );
};

export default LiveTrackingBadge;
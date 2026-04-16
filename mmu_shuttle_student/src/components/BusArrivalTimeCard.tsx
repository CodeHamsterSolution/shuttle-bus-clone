import type { BusArrivalTimeCardProps } from "../interfaces/props/BusArrivalTimeCardProps";


const BusArrivalTimeCard = ({ time = "06:45 am" }: BusArrivalTimeCardProps) => {
    return (
        <div className="bg-[#fef0cb] rounded-[16px] p-4 md:p-5 w-[94%] max-w-[320px] flex flex-col justify-center mb-6">
            <span className="text-[13px] md:text-[14px] font-medium text-slate-600 mb-0.5">
                Next Bus
            </span>
            <span className="text-[22px] md:text-[24px] font-bold text-slate-900 tracking-tight">
                {time}
            </span>
            <span className="text-[11px] text-amber-700 mt-2 leading-snug">
                ⚠️ Time is clock-based, bus may be delayed or already passed. Check the map for live location.
            </span>
        </div>
    );
};

export default BusArrivalTimeCard;
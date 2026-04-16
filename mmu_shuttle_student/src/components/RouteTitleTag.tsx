import type { RouteTitleTagProps } from "../interfaces/props/RouteTitleProps";
import { Skeleton } from "@mui/material";
import Alert from "./Alert";

const RouteTitleTag = ({ title, indicatorColor = "bg-[#113a9f]", isLoading, isError, errorMessage }: RouteTitleTagProps) => {
    if (isLoading) {
        return (
            <div className="flex items-center gap-4">
                <Skeleton variant="rectangular" className="!w-[4px] md:!w-[4px] !h-7 md:!h-8 !rounded-[1px]" />
                <Skeleton variant="text" className="!w-32 md:!w-48 !h-7 md:!h-9" />
            </div>
        );
    }

    if (isError) {
        return (
            <div className="flex items-center">
                <Alert type="error" title="Error" message={errorMessage!} />
            </div>
        );
    }

    return (
        <div className="flex items-center gap-4">
            <div className={`w-[4px] md:w-[4px] h-7 md:h-8 rounded-[1px] ${indicatorColor}`}></div>
            <h1 className="text-xl md:text-[22px] font-bold text-slate-800 tracking-tight">
                {title}
            </h1>
        </div>
    );
};

export default RouteTitleTag;

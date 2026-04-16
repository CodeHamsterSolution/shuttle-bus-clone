import { AlertCircle, CheckCircle2, Info, AlertTriangle } from "lucide-react";
import type { AlertProps } from "../interfaces/props/AlertProps";

const Alert = ({ type = 'info', title, message }: AlertProps) => {
    const iconMap = {
        error: <AlertCircle className="w-5 h-5 text-red-500" />,
        success: <CheckCircle2 className="w-5 h-5 text-emerald-500" />,
        warning: <AlertTriangle className="w-5 h-5 text-amber-500" />,
        info: <Info className="w-5 h-5 text-blue-500" />
    };

    const bgMap = {
        error: "bg-red-50 border-red-100",
        success: "bg-emerald-50 border-emerald-100",
        warning: "bg-amber-50 border-amber-100",
        info: "bg-blue-50 border-blue-100"
    };

    const titleColorMap = {
        error: "text-red-800",
        success: "text-emerald-800",
        warning: "text-amber-800",
        info: "text-blue-800"
    };

    const textColorMap = {
        error: "text-red-600",
        success: "text-emerald-600",
        warning: "text-amber-600",
        info: "text-blue-600"
    };

    return (
        <div className={`w-full p-4 rounded-xl border flex items-start gap-3 ${bgMap[type]}`}>
            <div className="flex-shrink-0 mt-0.5">
                {iconMap[type]}
            </div>
            <div className="flex flex-col gap-1">
                {title && (
                    <h3 className={`font-semibold ${titleColorMap[type]}`}>
                        {title}
                    </h3>
                )}
                <p className={`text-sm ${textColorMap[type]}`}>
                    {message}
                </p>
            </div>
        </div>
    );
};

export default Alert;

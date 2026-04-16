import { ArrowLeft } from "lucide-react";
import type { BackButtonProps } from "../interfaces/props/BackButtonProps";

const BackButton = ({
    text,
    onClick
}: BackButtonProps) => {
    return (
        <button 
            onClick={onClick} 
            className="flex items-center gap-2.5 text-slate-600 hover:text-slate-900 transition-colors font-semibold text-[15px]"
        >
            <ArrowLeft className="w-[18px] h-[18px]" strokeWidth={3} />
            <span className="hidden sm:inline">{text}</span>
            <span className="sm:hidden">Back</span>
        </button>
    );
}

export default BackButton;
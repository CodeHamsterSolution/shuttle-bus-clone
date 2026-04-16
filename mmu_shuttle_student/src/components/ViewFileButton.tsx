import { FileText, Paperclip } from "lucide-react";
import type { ViewFileButtonProps } from "../interfaces/props/ViewFileButtonProps";

const ViewFileButton = ({ fileName, onView }: ViewFileButtonProps) => {
    return (
        <button
            onClick={onView}
            className="w-full flex items-center px-4 py-3 bg-gray-50 border border-gray-300 rounded-xl hover:bg-gray-100 transition-colors focus:outline-none text-left"
        >
            <FileText className="text-[#003399] flex-shrink-0" size={24} />
            <div className="ml-3 mr-2 flex-grow min-w-0">
                <span className="text-[14px] text-[#1A1A1A] font-medium truncate block">
                    {fileName}
                </span>
            </div>
            <Paperclip className="text-gray-600 flex-shrink-0" size={20} />
        </button>
    );
};

export default ViewFileButton;

import { Snackbar } from "@mui/material";
import type { SnackBarProps } from "../interfaces/props/SnackBarProps";
import { AlertCircle, X } from "lucide-react";

const SnackBar = ({ isOpen, message, onClose }: SnackBarProps) => {
    return <Snackbar
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
        open={isOpen}
        sx={{ top: { xs: 24, sm: 32 } }}
    >
        <div className="bg-red-50 border border-red-100 shadow-[0_8px_30px_rgb(239,68,68,0.12)] rounded-xl px-5 py-3.5 flex items-center gap-3 w-max max-w-[90vw]">
            <div className="flex-shrink-0">
                <AlertCircle className="w-5 h-5 text-red-500" />
            </div>
            <p className="text-[14px] font-semibold text-red-800 tracking-tight">
                {message}
            </p>
            <button
                onClick={onClose}
                className="ml-3 sm:ml-4 p-1.5 rounded-lg hover:bg-red-100 text-red-500 transition-colors flex items-center justify-center shrink-0"
                aria-label="close"
            >
                <X className="w-4 h-4" strokeWidth={2.5} />
            </button>
        </div>

    </Snackbar>
}

export default SnackBar;
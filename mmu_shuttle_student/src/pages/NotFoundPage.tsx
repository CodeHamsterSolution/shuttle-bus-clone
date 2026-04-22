import { Link } from "react-router";
import { AlertCircle, ArrowLeft, Home } from "lucide-react";

const NotFoundPage = () => {
    return (
        <div className="h-[calc(100dvh-5rem)] flex items-center justify-center bg-white px-4">
            <div className="max-w-xs md:max-w-sm w-full text-center space-y-5 md:space-y-7">
                <div className="relative flex justify-center items-center">
                    <div className="absolute inset-0 bg-blue-100 rounded-full blur-2xl md:blur-3xl opacity-40 w-32 md:w-44 h-32 md:h-44 mx-auto animate-pulse"></div>

                    <div className="relative z-10 flex flex-col items-center">
                        <div className="bg-white p-3 md:p-4 rounded-full shadow-md md:shadow-lg mb-4 md:mb-6">
                            <AlertCircle className="w-10 h-10 md:w-14 md:h-14 text-blue-500 animate-bounce" strokeWidth={1.5} />
                        </div>
                        <h1 className="text-6xl md:text-8xl font-black text-gray-900 tracking-tighter drop-shadow-md">
                            404
                        </h1>
                    </div>
                </div>

                <div className="space-y-2 md:space-y-3">
                    <h2 className="text-xl md:text-2xl font-bold text-gray-800">
                        Page Not Found
                    </h2>
                    <p className="text-sm md:text-base text-gray-500 leading-relaxed">
                        Oops! The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
                    </p>
                </div>

                <div className="pt-4 md:pt-6 flex flex-col sm:flex-row items-center justify-center gap-3 md:gap-4">
                    <Link
                        to="/"
                        className="group flex items-center justify-center gap-2 w-full sm:w-auto px-5 md:px-6 py-2.5 md:py-3 bg-blue-600 text-white text-sm md:text-base font-medium rounded-xl hover:bg-blue-700 transition-all duration-300 shadow-md hover:shadow-xl hover:shadow-blue-500/20 active:scale-95"
                    >
                        <Home className="w-4 h-4 md:w-5 md:h-5 transition-transform group-hover:-translate-y-0.5" />
                        <span>Back to Home</span>
                    </Link>

                    <button
                        onClick={() => window.history.back()}
                        className="group flex items-center justify-center gap-2 w-full sm:w-auto px-5 md:px-6 py-2.5 md:py-3 bg-white text-gray-700 text-sm md:text-base font-medium rounded-xl border border-gray-200 hover:bg-gray-50 hover:border-gray-300 transition-all duration-300 shadow-sm hover:shadow-md active:scale-95"
                    >
                        <ArrowLeft className="w-4 h-4 md:w-5 md:h-5 transition-transform group-hover:-translate-x-1" />
                        <span>Go Back</span>
                    </button>
                </div>
            </div>
        </div>
    );
};

export default NotFoundPage;

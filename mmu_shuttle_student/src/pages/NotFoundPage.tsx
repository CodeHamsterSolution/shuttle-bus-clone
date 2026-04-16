import { Link } from "react-router";
import { AlertCircle, ArrowLeft, Home } from "lucide-react";

const NotFoundPage = () => {
    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center bg-white px-4 py-8 transition-colors duration-300">
            <div className="max-w-md w-full text-center space-y-6">
                <div className="relative flex justify-center items-center">
                    <div className="absolute inset-0 bg-blue-100 rounded-full blur-3xl opacity-50 w-48 h-48 mx-auto animate-pulse"></div>
                    
                    <div className="relative z-10 flex flex-col items-center">
                        <div className="bg-white p-4 rounded-full shadow-lg mb-6">
                            <AlertCircle className="w-16 h-16 text-blue-500 animate-bounce" strokeWidth={1.5} />
                        </div>
                        <h1 className="text-8xl font-black text-gray-900 tracking-tighter drop-shadow-md">
                            404
                        </h1>
                    </div>
                </div>
                
                <div className="space-y-3">
                    <h2 className="text-2xl font-bold text-gray-800">
                        Page Not Found
                    </h2>
                    <p className="text-gray-500 max-w-sm mx-auto leading-relaxed">
                        Oops! The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
                    </p>
                </div>

                <div className="pt-6 flex flex-col sm:flex-row items-center justify-center gap-4">
                    <Link 
                        to="/" 
                        className="group relative flex items-center justify-center gap-2 w-full sm:w-auto px-6 py-3 bg-blue-600 text-white font-medium rounded-xl hover:bg-blue-700 transition-all duration-300 shadow-md hover:shadow-xl hover:shadow-blue-500/20 active:scale-95"
                    >
                        <Home className="w-5 h-5 transition-transform group-hover:-translate-y-0.5" />
                        <span>Back to Home</span>
                    </Link>
                    
                    <button 
                        onClick={() => window.history.back()}
                        className="group flex items-center justify-center gap-2 w-full sm:w-auto px-6 py-3 bg-white text-gray-700 font-medium rounded-xl border border-gray-200 hover:bg-gray-50 hover:border-gray-300 transition-all duration-300 shadow-sm hover:shadow-md active:scale-95"
                    >
                        <ArrowLeft className="w-5 h-5 transition-transform group-hover:-translate-x-1" />
                        <span>Go Back</span>
                    </button>
                </div>
            </div>
        </div>
    );
};

export default NotFoundPage;

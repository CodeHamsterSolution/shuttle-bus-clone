const GoogleMapLoading = () => {
    return (
        <div className="h-full min-h-[calc(100dvh-12rem)] md:min-h-full w-full flex items-center justify-center bg-gradient-to-b from-slate-50 to-slate-100">
            <div className="w-[320px] max-w-[80%] rounded-[20px] bg-white px-5 py-6 shadow-[0_12px_30px_rgba(22,35,74,0.12)] text-center flex flex-col items-center gap-3 -translate-y-[15vh] md:translate-y-0">
                <div className="h-12 w-12 rounded-full bg-blue-100/70 flex items-center justify-center">
                    <div
                        className="h-7 w-7 rounded-full border-[3px] border-blue-200 border-t-blue-600 animate-spin"
                        role="status"
                        aria-label="Loading"
                    />
                </div>
                <div className="text-[16px] font-semibold text-slate-800">Preparing route map</div>
                <div className="text-[13px] text-slate-500">Fetching the latest shuttle path and stops.</div>
            </div>
        </div>
    );
};

export default GoogleMapLoading;

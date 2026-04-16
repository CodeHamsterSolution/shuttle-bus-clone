import { useNavigate } from "react-router";
import Header from "../components/Header";
import RouteCard from "../components/RouteCard";
import { useQuery } from "@tanstack/react-query";
import { fetchRoutes } from "../services/routeService";
import { Skeleton } from "@mui/material";
import Alert from "../components/Alert";

const RouteSubPage = () => {
    const navigate = useNavigate();
    const { data, isLoading, isError, error } = useQuery({
        queryKey: ['routes'],
        queryFn: async () => {
            return await fetchRoutes();
        },
    })

    return (
        <div className="w-full">
            <div className="px-6 md:px-12 lg:px-20">
                <Header title="Routes Overview" description="Select a route to view live tracking" />
            </div>

            <main className="w-full px-6 md:px-12 lg:px-20 pb-8 md:pb-10">
                <div className="max-w-7xl mx-auto md:mx-0 flex flex-wrap gap-6 items-start">
                    {isLoading ? (
                        Array.from({ length: 3 }).map((_, i) => (
                            <Skeleton
                                key={i}
                                variant="rounded"
                                animation="wave"
                                sx={{ borderRadius: '16px' }}
                                className="!w-full sm:!w-[340px] md:!w-[380px] !h-[96px] md:!h-[120px]"
                            />
                        ))
                    ) : isError ? (
                        <Alert type="error" title="Failed to load routes" message={error?.message} />
                    ) : !data || data.length === 0 ? (
                        <Alert title="No routes available" message="There are currently no active routes." />
                    ) : (
                        data.map((route) => (
                            <RouteCard
                                key={route.id}
                                route={route}
                                indicatorColor={route.color}
                                onClick={() => {
                                    navigate(`/route/${route.id}`)
                                }}
                            />
                        ))
                    )}
                </div>
            </main>
        </div>
    );
};

export default RouteSubPage;
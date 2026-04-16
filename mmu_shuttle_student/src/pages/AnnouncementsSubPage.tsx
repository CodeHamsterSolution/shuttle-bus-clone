import { useQuery } from "@tanstack/react-query";
import AnnouncementCard from "../components/AnnouncementCard";
import Header from "../components/Header";
import { fetchAnnouncements } from "../services/announcmentService";
import { Skeleton } from "@mui/material";
import Alert from "../components/Alert";

const AnnouncementsSubPage = () => {

    const { data, isLoading, isError, error } = useQuery({
        queryKey: ['announcements'],
        queryFn: async () => {
            return await fetchAnnouncements() ?? [];
        },
        staleTime: 1000 * 60,
    })

    return (
        <div className="w-full">
            <div className="px-6 md:px-12 lg:px-20">
                <Header title="Announcements" description="Important system updates and notices" />
            </div>

            <main className="w-full px-6 md:px-12 lg:px-20 pb-8 md:pb-10">
                <div className="max-w-7xl mx-auto md:mx-0 flex flex-col gap-4 items-start w-full">
                    {isLoading ? (
                        Array.from({ length: 3 }).map((_, i) => (
                            <Skeleton
                                key={i}
                                variant="rounded"
                                animation="wave"
                                sx={{ borderRadius: '12px' }}
                                className="!w-full !h-[140px] md:!h-[160px] !mb-4"
                            />
                        ))
                    ) : isError ? (
                        <Alert type="error" title="Failed to load announcements" message={error?.message} />
                    ) : !data || data.length === 0 ? (
                        <Alert title="No announcements" message="There are currently no announcements available." />
                    ) : (
                        data.map((announcement) => (
                            <div key={announcement.id} className="w-full">
                                <AnnouncementCard announcement={announcement} />
                            </div>
                        ))
                    )}
                </div>
            </main>

        </div>
    );
};

export default AnnouncementsSubPage;
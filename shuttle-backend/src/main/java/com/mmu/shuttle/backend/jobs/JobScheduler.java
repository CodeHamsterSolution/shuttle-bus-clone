package com.mmu.shuttle.backend.jobs;

import com.mmu.shuttle.backend.services.ActiveBusStoreService;
import com.mmu.shuttle.backend.services.AnnouncementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class JobScheduler {

    @Autowired
    private AnnouncementService announcementService;

    @Autowired
    private ActiveBusStoreService activeBusStoreService;

    @Scheduled(cron = "0 0 0 * * *", zone = "Asia/Kuala_Lumpur")
    public void removeAnnouncements() {
        try {
            log.info("Executing Remove Announcements Job");
            int count = announcementService.deleteAnnouncements();
            log.info("Scheduled Task: Successfully deleted {} old announcements.", count);

        } catch (Exception e) {
            log.error("Scheduled Task Failed: Error deleting old announcements - {}", e.getMessage(), e);
        }
    }

    @Scheduled(cron = "0 10 0 * * *", zone = "Asia/Kuala_Lumpur")
    public void clearActiveBusStoreCache() {
        try {
            log.info("Executing Clear ActiveBusStore Job");
            activeBusStoreService.clearActiveBuses();
            log.info("Scheduled Task: Successfully clear active bus store cache.");
        } catch (Exception e) {
            log.error("Scheduled Task Failed: Error clearing all active bus store cache - {}", e.getMessage(), e);
        }
    }

}
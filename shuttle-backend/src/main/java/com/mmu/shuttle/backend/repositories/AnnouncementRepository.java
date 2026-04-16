package com.mmu.shuttle.backend.repositories;

import com.mmu.shuttle.backend.entities.Announcement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {
    List<Announcement> findAllByOrderByIsPinnedDescCreatedAtDesc();
    List<Announcement> findAllByCreatedAtBefore(LocalDateTime oneMonthAgo);

    @Modifying(clearAutomatically = true)
    @Query("DELETE FROM Announcement a WHERE a.createdAt < :cutoffDate")
    int deleteAllByCreatedAtBefore(@Param("cutoffDate") LocalDateTime cutoffDate);

}

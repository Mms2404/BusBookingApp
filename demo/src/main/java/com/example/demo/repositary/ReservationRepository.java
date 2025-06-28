package com.example.demo.repositary;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.model.Reservation;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findByScheduleIdAndScheduleDepartureDate(Long scheduleId, String departureDate);
}

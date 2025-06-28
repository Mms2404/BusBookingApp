package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.Reservation;
import com.example.demo.model.Schedule;
import com.example.demo.repositary.ReservationRepository;
import com.example.demo.repositary.ScheduleRepository;

@RestController
@RequestMapping("/api")
public class BookingController {
    @Autowired private ReservationRepository reservationRepo;
    @Autowired private ScheduleRepository scheduleRepo;

    @PostMapping("/book")
    public ResponseEntity<?> bookSeats(@RequestBody Reservation request) {
        // validate if schedule exists
        Schedule schedule = scheduleRepo.findById(request.getSchedule().getId())
          .orElseThrow(()-> new RuntimeException("No such Bus schedule"));
        request.setSchedule(schedule);
        
        int pricePerSeat = schedule.getFare();
        int totalSeats = request.getTotalSeats();
        request.setTicketPrice(pricePerSeat*totalSeats);
        
        return ResponseEntity.ok(reservationRepo.save(request));
    }

    @GetMapping("/all-reservations")
    public List<Reservation> allReservations() {
        return reservationRepo.findAll();
    }

    @GetMapping("/reservations")
    public List<Reservation> getBookings(
        @RequestParam Long scheduleId,
        @RequestParam String departureDate) {
        return reservationRepo.findByScheduleIdAndScheduleDepartureDate(scheduleId, departureDate);
    }


    @GetMapping("/showSchedules")
    public List<Schedule> showSchedules(){
        return scheduleRepo.findAll();
    }
   

}


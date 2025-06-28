package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.Bus;
import com.example.demo.model.Schedule;
import com.example.demo.repositary.BusRepository;
import com.example.demo.repositary.ScheduleRepository;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Autowired private BusRepository busRepo;
    @Autowired private ScheduleRepository scheduleRepo;

    @PostMapping("/addBus")
    public Bus addBus(@RequestBody Bus bus) {
        return busRepo.save(bus);
    }

    @PostMapping("/addSchedules")
    public Schedule addSchedule(@RequestBody Schedule schedule) {
        return scheduleRepo.save(schedule);
    }

    @GetMapping("/showBuses")
    public List<Bus> showBuses(){
        return busRepo.findAll();
    }

    
}


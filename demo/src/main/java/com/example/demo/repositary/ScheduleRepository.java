package com.example.demo.repositary;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.model.Schedule;

public interface ScheduleRepository extends JpaRepository <Schedule , Long> {}

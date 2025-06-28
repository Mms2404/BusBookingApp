package com.example.demo;

import java.sql.Connection;
import java.sql.DriverManager;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Bookingapplication {
    public static void main(String[] args) {
        SpringApplication.run(Bookingapplication.class, args);
    
    
        // try {
        //     String url = "jdbc:postgresql://db.eopxqdyldqflqvhbzrws.supabase.co:5432/postgres?sslmode=require&sslfactory=org.postgresql.ssl.NonValidatingFactory";
        //     String user = "postgres";
        //     String pass = "supabase@25";

        //     Connection con = DriverManager.getConnection(url, user, pass);
        //     System.out.println("✅ Manual JDBC Connected: " + con);
        // } catch (Exception e) {
        //     System.err.println("❌ Manual JDBC connection failed:");
        //     e.printStackTrace();
        // }
    }
}

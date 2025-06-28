// if credentials are valid , then this calls the JwtUtil.generateToken(username)
package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.security.JwtUtil;

import java.util.Map;

@RestController
public class AuthController {

    @Autowired
    private AuthenticationManager authManager;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public Map<String, String> login(@RequestBody Map<String, String> authRequest) {
        String username = authRequest.get("username");
        String password = authRequest.get("password");

        authManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));

        String token = jwtUtil.generateToken(username);
        return Map.of("token", token);
    }
}



// [User sends credentials to /login]
//    ↓
// AuthController.java → calls JwtUtil to generate token

// [User sends token in future requests]
//    ↓
// JwtRequestFilter.java → checks the token using JwtUtil
//    ↓
// SecurityConfig.java → sees route is protected
//    ↓
// Token is valid → passes request to AdminController


package com.warehouse.controller;

import com.warehouse.model.User;
import com.warehouse.dao.UserDao;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
public class AuthController {

    @Autowired
    private UserDao userDao;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    @GetMapping("/access-denied")
    public String denied() {
        return "access-denied";
    }

  
    @PostMapping("/login")
    public String loginSubmit(@RequestParam String email,
                              @RequestParam String password,
                              Model model,
                              HttpSession session) {

        User user = userDao.login(email, password);

        if (user == null) {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        }

        // session
        session.setAttribute("user", user);
        session.setAttribute("isAdmin", user.isAdmin());

        // 🔥 ROLE BASED REDIRECT
        if (user.isAdmin()) {
            return "redirect:/admin/dashboard";
        } else {
            return "redirect:/home";
        }
    }


    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerSubmit(User user, Model model) {

        int result = userDao.register(user);

        if (result > 0) {
            model.addAttribute("success", "Register Successful! Please login.");
            return "login";
        } else {
            model.addAttribute("error", "Something went wrong!");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}

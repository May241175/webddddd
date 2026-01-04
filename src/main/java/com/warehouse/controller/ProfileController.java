package com.warehouse.controller;

import com.warehouse.dao.UserDao;
import com.warehouse.dao.OrderDao;
import com.warehouse.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class ProfileController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private OrderDao orderDao;

    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        // Profile info
        Map<String, Object> profile = userDao.getUserProfile(user.getUser_id());
        model.addAttribute("profile", profile);

        // Order stats
        Map<String, Object> stats = orderDao.getOrderStats(user.getUser_id());
        model.addAttribute("stats", stats);

        return "profile";
    }


    @PostMapping("/profile/update")
    public String updateProfile(HttpSession session,
                                @RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String phone) {

        User user = (User) session.getAttribute("user");
        userDao.updateProfile(user.getUser_id(), name, email, phone);

        return "redirect:/profile?updated=1";
    }

    @PostMapping("/profile/password")
    public String updatePassword(HttpSession session,
                                @RequestParam String old_password,
                                @RequestParam String new_password,
                                Model model) {

        User user = (User) session.getAttribute("user");
        String current = userDao.getPassword(user.getUser_id());

        if (!current.equals(old_password)) {
            model.addAttribute("error", "Old password incorrect!");
            return "profile";
        }

        userDao.updatePassword(user.getUser_id(), new_password);

        return "redirect:/profile?password_changed=1";
    }

}

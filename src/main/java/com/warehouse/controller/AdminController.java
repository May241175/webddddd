package com.warehouse.controller;

import com.warehouse.model.User;
import com.warehouse.dao.UserDao;
import com.warehouse.dao.DashboardDao;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private DashboardDao dashboardDao; // ✅ FIXED (D အကြီး)

    // =========================
    // ADMIN DASHBOARD
    // =========================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null || !loginUser.isAdmin()) {
            return "redirect:/access-denied";
        }

        int totalOrders = dashboardDao.countOrders();
        int totalCustomers = dashboardDao.countCustomers();
        int totalSuppliers = dashboardDao.countSuppliers();
        int totalStocks = dashboardDao.countStocks();

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalCustomers", totalCustomers);
        model.addAttribute("totalSuppliers", totalSuppliers);
        model.addAttribute("totalStocks", totalStocks);

        return "admin/dashboard";
    }


    // =========================
    // ADMIN PROFILE
    // =========================
    @GetMapping("/profile")
    public String adminProfile(HttpSession session, Model model) {

        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null || !sessionUser.isAdmin()) {
            return "redirect:/access-denied";
        }

        User freshAdmin = userDao.findById(sessionUser.getUser_id());

        session.setAttribute("user", freshAdmin);
        model.addAttribute("admin", freshAdmin);

        return "admin/admin-profile";
    }
}

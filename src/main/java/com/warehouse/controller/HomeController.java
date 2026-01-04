package com.warehouse.controller;

import com.warehouse.dao.ProductDao;
import com.warehouse.dao.CategoryDao;
import com.warehouse.dao.CartDao;          // ✅ ADD
import com.warehouse.model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private CategoryDao categoryDao;

    @Autowired
    private CartDao cartDao;               // ✅ ADD

    // =========================
    // HOME PAGE
    // =========================
    @GetMapping({"/", "/home"})
    public String showHomePage(Model model, HttpSession session) {

        if (session.getAttribute("user") == null)
            return "redirect:/login";

        model.addAttribute("products", productDao.findAll());
        model.addAttribute("bestSellers", productDao.findBestSellers());
        model.addAttribute("categories", categoryDao.findAll());

        return "home";
    }

    // =========================
    // ADD TO CART FROM HOME
    // =========================
    @PostMapping("/home/add")
    public String addToCart(@RequestParam int stockId,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session) {

        // 🔐 Login check
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        int userId = user.getUser_id();     // ✅ FIXED

        // 👉 DB insert/update
        cartDao.addToCart(userId, stockId, quantity);

        // 🔔 Update cart notification count
        int cartCount = cartDao.getCartByUser(userId).size();
        session.setAttribute("cartCount", cartCount);

        // 🔁 Redirect back to home
        return "redirect:/home";
    }
}

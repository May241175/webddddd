package com.warehouse.controller;

import com.warehouse.dao.CartDao;
import com.warehouse.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;                 // ✅ CORRECT IMPORT
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    private CartDao cartDao;

    // =========================
    // ADD TO CART (NO CHECKLIST)
    // =========================
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam int stockId,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session,
                            HttpServletRequest request) {

        // 🔐 Login check
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        int userId = user.getUser_id();

        // 👉 DB insert/update
        cartDao.addToCart(userId, stockId, quantity);

        // 🔔 Update cart notification count
        int cartCount = cartDao.getCartByUser(userId).size();
        session.setAttribute("cartCount", cartCount);

        // 🔁 🔥 SMART PART: redirect back to previous page
        String referer = request.getHeader("Referer");

        if (referer != null) {
            return "redirect:" + referer;
        }

        // fallback (just in case)
        return "redirect:/home";
    }

    // =========================
    // VIEW CART
    // =========================
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {

        // 🔐 Login check
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        int userId = user.getUser_id();   // ✅ FIXED

        // 🛒 Get cart items from DB
        model.addAttribute("cartItems",
                cartDao.getCartByUser(userId));

        return "cart"; // 👉 /WEB-INF/views/cart.jsp
    }
    @GetMapping("/cart/delete")
    public String deleteCartItem(@RequestParam("id") int cartId,
                                 HttpSession session) {

        // 🔐 Login check
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        int userId = user.getUser_id();

        // 🗑 Delete item
        cartDao.delete(cartId);

        // 🔔 Update cart notification count
        int cartCount = cartDao.getCartByUser(userId).size();
        session.setAttribute("cartCount", cartCount);

        // 🔁 Redirect back to cart page
        return "redirect:/cart";
    }

}

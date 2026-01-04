package com.warehouse.controller;

import com.warehouse.dao.ProductDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/product")   // ✅ class-level mapping
public class ProductController {

    @Autowired
    private ProductDao productDao;

    @GetMapping("/list")      // ✅ method-level mapping
    public String productList(Model model, HttpSession session) {

        if (session.getAttribute("user") == null)
            return "redirect:/login";

        model.addAttribute("products", productDao.findAll());
        return "product-list";
    }

    @GetMapping("/detail")
    public String productDetail(@RequestParam("id") int stockId,
                                Model model,
                                HttpSession session) {

        if (session.getAttribute("user") == null)
            return "redirect:/login";

        model.addAttribute("product", productDao.findById(stockId));
        return "product-detail";
    }
}

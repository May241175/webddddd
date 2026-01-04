package com.warehouse.controller;

import com.warehouse.dao.UserAddressDao;
import com.warehouse.model.User;
import com.warehouse.model.UserAddress;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserAddressController {

    @Autowired
    private UserAddressDao addressDao;

    @GetMapping("/address")
    public String addressPage(HttpSession session, Model model) {

        User u = (User) session.getAttribute("user");
        if (u == null) return "redirect:/login";

        model.addAttribute("addresses", addressDao.getAddresses(u.getUser_id()));
        return "address";
    }

    @PostMapping("/address/add")
    public String addAddress(UserAddress a, HttpSession session) {

        User u = (User) session.getAttribute("user");
        a.setUserId(u.getUser_id());

        addressDao.addAddress(a);
        return "redirect:/address";
    }

    @PostMapping("/address/edit")
    public String editAddress(UserAddress a, HttpSession session) {

        User u = (User) session.getAttribute("user");
        a.setUserId(u.getUser_id());

        addressDao.updateAddress(a);
        return "redirect:/address";
    }

    @GetMapping("/address/default")
    public String setDefault(@RequestParam int id, HttpSession session) {

        User u = (User) session.getAttribute("user");
        addressDao.setDefault(u.getUser_id(), id);

        return "redirect:/address";
    }

    @GetMapping("/address/delete")
    public String delete(@RequestParam int id) {

        addressDao.delete(id);
        return "redirect:/address";
    }
}

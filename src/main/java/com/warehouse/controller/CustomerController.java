package com.warehouse.controller;

import com.warehouse.dao.CustomerDao;
import com.warehouse.model.Customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    CustomerDao customerDao;

    @GetMapping("")
    public String list(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "user_name") String sortField,
            @RequestParam(defaultValue = "asc") String sortDir,
            Model model) {

        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        List<Customer> list = customerDao.searchAndSort(keyword, offset, pageSize, sortField, sortDir);
        int totalItems = customerDao.countSearch(keyword);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

        return "customer";
    }

    @PostMapping("/add")
    public String add(Customer c) {
        customerDao.add(c);
        return "redirect:/customer";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        customerDao.delete(id);
        return "redirect:/customer";
    }

    @GetMapping("/edit")
    public String edit(@RequestParam("id") int id, Model model,
                       @RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "user_name") String sortField,
                       @RequestParam(defaultValue = "asc") String sortDir) {

        Customer c = customerDao.getById(id);

        list(keyword, page, sortField, sortDir, model); // reload list
        model.addAttribute("customer", c); // open edit modal

        return "customer";
    }

    @PostMapping("/update")
    public String update(Customer c) {
        customerDao.update(c);
        return "redirect:/customer";
    }
}

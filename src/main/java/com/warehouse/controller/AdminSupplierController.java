package com.warehouse.controller;

import com.warehouse.dao.SupplierDao;
import com.warehouse.model.Supplier;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/supplier")
public class AdminSupplierController {

    @Autowired
    SupplierDao supplierDao;

    // LIST with SEARCH + SORT + PAGINATION
    @GetMapping("")
    public String list(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "supplier_name") String sortField,
            @RequestParam(defaultValue = "asc") String sortDir,
            Model model) {

        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        List<Supplier> list = supplierDao.searchAndSort(keyword, offset, pageSize, sortField, sortDir);
        int totalItems = supplierDao.countSearch(keyword);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

        return "supplier";
    }

    // OPEN EDIT MODAL
    @GetMapping("/edit")
    public String edit(
            @RequestParam("id") int id,
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "supplier_name") String sortField,
            @RequestParam(defaultValue = "asc") String sortDir,
            Model model) {

        Supplier s = supplierDao.getById(id);

        // Load supplier list like list()
        list(keyword, page, sortField, sortDir, model);

        // Add supplier to open modal
        model.addAttribute("supplier", s);

        return "supplier";
    }

    // UPDATE SUPPLIER
    @PostMapping("/update")
    public String update(Supplier s) {
        supplierDao.update(s);
        return "redirect:/supplier";
    }

    // ADD SUPPLIER
    @PostMapping("/add")
    public String add(Supplier s) {
        supplierDao.add(s);
        return "redirect:/supplier";
    }

    // DELETE SUPPLIER
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        supplierDao.delete(id);
        return "redirect:/supplier";
    }
}

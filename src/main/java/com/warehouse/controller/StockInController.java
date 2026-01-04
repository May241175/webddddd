package com.warehouse.controller;

import com.warehouse.dao.StockInDao;
import com.warehouse.model.StockIn;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/stockin")
public class StockInController {

    @Autowired
    private StockInDao stockInDao;

    @GetMapping("")
    public String list(
            @RequestParam(name = "keyword", defaultValue = "") String keyword,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "sortField", defaultValue = "date_in") String sortField,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir,
            Model model) {

        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        List<StockIn> list = stockInDao.searchAndSort(keyword, offset, pageSize, sortField, sortDir);
        int totalItems = stockInDao.countSearch(keyword);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

        return "stock_in";
    }

    @PostMapping("/add")
    public String add(
            @RequestParam("stockName") String stockName,
            @RequestParam("quantity") int quantity,
            @RequestParam("dateIn") Date dateIn,
            @RequestParam("remarks") String remarks) {

        // 1. Insert stock if not exists
        int stockId = stockInDao.getOrCreateStockId(stockName);

        // 2. Insert stock_in
        StockIn s = new StockIn();
        s.setStockId(stockId);
        s.setQuantity(quantity);
        s.setDateIn(dateIn);
        s.setRemarks(remarks);

        stockInDao.add(s);

        return "redirect:/stockin";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam(name = "id") int id) {
        stockInDao.delete(id);
        return "redirect:/stockin";
    }

    @GetMapping("/edit")
    public String edit(
            @RequestParam(name = "id") int id,
            @RequestParam(name = "keyword", defaultValue = "") String keyword,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "sortField", defaultValue = "date_in") String sortField,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir,
            Model model) {

        StockIn s = stockInDao.getById(id);

        // Reuse list method to load table + paging
        list(keyword, page, sortField, sortDir, model);

        model.addAttribute("stockIn", s);

        return "stock_in";
    }

    @PostMapping("/update")
    public String update(
            @RequestParam(name = "inId") int inId,
            @RequestParam(name = "quantity") int quantity,
            @RequestParam(name = "dateIn") Date dateIn,
            @RequestParam(name = "remarks") String remarks) {

        StockIn s = new StockIn();
        s.setInId(inId);
        s.setQuantity(quantity);
        s.setDateIn(dateIn);
        s.setRemarks(remarks);

        stockInDao.update(s);
        return "redirect:/stockin";
    }
}

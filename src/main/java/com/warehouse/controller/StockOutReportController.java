package com.warehouse.controller;

import com.warehouse.dao.StockOutDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/stockout")
public class StockOutReportController {

    @Autowired
    private StockOutDao stockOutDao;

    @GetMapping("/report")
    public String report(Model model) {

        List<Map<String, Object>> list = stockOutDao.getStockOutReport();
        model.addAttribute("list", list);

        return "stock_out_report";
    }
}

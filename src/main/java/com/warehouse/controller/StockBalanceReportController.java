package com.warehouse.controller;

import com.warehouse.dao.StockBalanceDao;
import com.warehouse.model.StockBalance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/stockbalance")
public class StockBalanceReportController {

    @Autowired
    private StockBalanceDao stockBalanceDao;

    @GetMapping("/report")
    public String report(Model model) {

        List<StockBalance> list = stockBalanceDao.getStockBalanceReport();
        model.addAttribute("list", list);

        return "stock_balance_report";
    }
}

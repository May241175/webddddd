package com.warehouse.dao;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StockOutDao {

    @Autowired
    private JdbcTemplate jdbc;

    public List<Map<String, Object>> getStockOutReport() {
        String sql =
                "SELECT so.out_id, s.stock_name, so.quantity, so.date_out, so.remark, so.bin_id " +
                "FROM stock_out so " +
                "JOIN stock s ON so.stock_id = s.stock_id " +
                "ORDER BY so.date_out DESC";

        return jdbc.queryForList(sql);
    }
}

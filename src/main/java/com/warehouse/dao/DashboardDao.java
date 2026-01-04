package com.warehouse.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DashboardDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int countOrders() {
        return jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders", Integer.class
        );
    }

    public int countCustomers() {
        return jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM user WHERE is_admin = 0 OR is_admin IS NULL",
            Integer.class
        );
    }

    public int countSuppliers() {
        return jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM supplier", Integer.class
        );
    }

    public int countStocks() {
        return jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM stock", Integer.class
        );
    }
}

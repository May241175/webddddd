package com.warehouse.dao;

import com.warehouse.model.StockBalance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class StockBalanceDao {

    @Autowired
    private JdbcTemplate jdbc;

    private StockBalance mapRow(ResultSet rs) throws SQLException {
        StockBalance sb = new StockBalance();

        sb.setStockId(rs.getInt("stock_id"));
        sb.setStockName(rs.getString("stock_name"));
        sb.setTotalIn(rs.getInt("total_in"));
        sb.setTotalOut(rs.getInt("total_out"));
        sb.setBalanceQty(rs.getInt("balance_qty"));

        return sb;
    }

    public List<StockBalance> getStockBalanceReport() {

        String sql =
            "SELECT " +
            "   s.stock_id, " +
            "   s.stock_name, " +
            "   COALESCE((SELECT SUM(quantity) FROM stock_in  WHERE stock_id = s.stock_id), 0) AS total_in, " +
            "   COALESCE((SELECT SUM(quantity) FROM stock_out WHERE stock_id = s.stock_id), 0) AS total_out, " +
            "   (COALESCE((SELECT SUM(quantity) FROM stock_in  WHERE stock_id = s.stock_id), 0) - " +
            "    COALESCE((SELECT SUM(quantity) FROM stock_out WHERE stock_id = s.stock_id), 0)) AS balance_qty " +
            "FROM stock s ORDER BY s.stock_name ASC";

        return jdbc.query(sql, (rs, rowNum) -> mapRow(rs));
    }
}

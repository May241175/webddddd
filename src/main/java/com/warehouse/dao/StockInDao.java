package com.warehouse.dao;

import com.warehouse.model.StockIn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class StockInDao {

    @Autowired
    private JdbcTemplate jdbc;

    private StockIn mapRow(ResultSet rs) throws SQLException {
        StockIn s = new StockIn();
        s.setInId(rs.getInt("in_id"));
        s.setStockId(rs.getInt("stock_id"));
        s.setStockName(rs.getString("stock_name"));
        s.setQuantity(rs.getInt("quantity"));
        s.setDateIn(rs.getDate("date_in"));
        s.setRemarks(rs.getString("remarks"));
        s.setBinId(rs.getInt("bin_id"));
        return s;
    }

    // Get next auto stock ID (round robin)
    public int getNextStockId() {
        List<Integer> ids = jdbc.queryForList(
                "SELECT stock_id FROM stock ORDER BY stock_id ASC", Integer.class);

        if (ids.isEmpty()) return 0;

        Integer last = null;
        try {
            last = jdbc.queryForObject(
                    "SELECT stock_id FROM stock_in ORDER BY in_id DESC LIMIT 1",
                    Integer.class
            );
        } catch (Exception ignored) {
            return ids.get(0); // first insert
        }

        int index = ids.indexOf(last);

        if (index == -1 || index == ids.size() - 1)
            return ids.get(0);

        return ids.get(index + 1);
    }

    
    public void add(StockIn s) {
        int binId = getBinIdForStock(s.getStockId());
        s.setBinId(binId);

        jdbc.update(
            "INSERT INTO stock_in (stock_id, quantity, date_in, remarks, bin_id) VALUES (?, ?, ?, ?, ?)",
            s.getStockId(),
            s.getQuantity(),
            s.getDateIn(),
            s.getRemarks(),
            s.getBinId()
        );
    }


    // Get bin id from stock table
    public int getBinIdForStock(int stockId) {
        return jdbc.queryForObject(
                "SELECT bin_id FROM stock WHERE stock_id=?",
                Integer.class,
                stockId
        );
    }

    // Add with auto stock & auto bin
    public void addAuto(StockIn s) {
        int nextStockId = getNextStockId();
        s.setStockId(nextStockId);

        int binId = getBinIdForStock(nextStockId);
        s.setBinId(binId);

        jdbc.update(
                "INSERT INTO stock_in (stock_id, quantity, date_in, remarks, bin_id) VALUES (?, ?, ?, ?, ?)",
                s.getStockId(),
                s.getQuantity(),
                s.getDateIn(),
                s.getRemarks(),
                s.getBinId()
        );
    }

    // Pagination + search + sort
    public List<StockIn> searchAndSort(String keyword, int offset, int limit, String sortField, String sortDir) {

        String orderBy;

        switch (sortField) {
            case "stock_name":
                orderBy = "s.stock_name";
                break;
            case "quantity":
                orderBy = "si.quantity";
                break;
            case "date_in":
                orderBy = "si.date_in";
                break;
            default:
                orderBy = "si.in_id";
        }

        String sql =
                "SELECT si.*, s.stock_name " +
                "FROM stock_in si JOIN stock s ON si.stock_id = s.stock_id " +
                "WHERE s.stock_name LIKE ? OR si.remarks LIKE ? " +
                "ORDER BY " + orderBy + " " + sortDir +
                " LIMIT ?, ?";

        String like = "%" + keyword + "%";

        return jdbc.query(sql, (rs, rowNum) -> mapRow(rs), like, like, offset, limit);
    }

    public int countSearch(String keyword) {
        String like = "%" + keyword + "%";
        return jdbc.queryForObject(
                "SELECT COUNT(*) FROM stock_in si JOIN stock s ON si.stock_id = s.stock_id " +
                        "WHERE s.stock_name LIKE ? OR si.remarks LIKE ?",
                Integer.class,
                like, like
        );
    }

    public void delete(int id) {
        jdbc.update("DELETE FROM stock_in WHERE in_id=?", id);
    }

    public StockIn getById(int id) {
        return jdbc.queryForObject(
                "SELECT si.*, s.stock_name FROM stock_in si JOIN stock s ON si.stock_id = s.stock_id WHERE si.in_id = ?",
                (rs, rowNum) -> mapRow(rs),
                id
        );
    }

    // Update without changing stock or bin
    public void update(StockIn s) {
        jdbc.update(
            "UPDATE stock_in SET quantity=?, date_in=?, remarks=? WHERE in_id=?",
            s.getQuantity(),
            s.getDateIn(),
            s.getRemarks(),
            s.getInId()
        );
    }
    public int getOrCreateStockId(String stockName) {

        // check if stock exists
        Integer id = null;
        try {
            id = jdbc.queryForObject(
                    "SELECT stock_id FROM stock WHERE stock_name = ?",
                    Integer.class,
                    stockName
            );
        } catch (Exception ignored) {}

        // if exists → return
        if (id != null) return id;

        // if not exists → insert new
        jdbc.update("INSERT INTO stock (stock_name) VALUES (?)", stockName);

        // return new id
        return jdbc.queryForObject(
                "SELECT stock_id FROM stock WHERE stock_name = ?",
                Integer.class,
                stockName
        );
    }


    public List<Map<String, Object>> getAllStocks() {
        return jdbc.queryForList("SELECT stock_id, stock_name FROM stock ORDER BY stock_name ASC");
    }

}

package com.warehouse.dao;

import com.warehouse.model.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class SupplierDao {

    @Autowired
    private JdbcTemplate jdbc;

    // =========================
    // LIST (WITH ITEM NAME)
    // =========================
    public List<Supplier> searchAndSort(
            String keyword,
            int offset,
            int limit,
            String sortField,
            String sortDir) {

        // 🔒 prevent SQL injection
        if (!List.of("supplier_name", "supplier_phone").contains(sortField)) {
            sortField = "supplier_name";
        }
        if (!sortDir.equalsIgnoreCase("asc")) {
            sortDir = "desc";
        }

        String sql = "  SELECT\r\n"
        		+ "                s.supplier_id,\r\n"
        		+ "                s.supplier_name,\r\n"
        		+ "                s.supplier_phone,\r\n"
        		+ "                s.supplier_address,\r\n"
        		+ "                st.stock_name\r\n"
        		+ "            FROM supplier s\r\n"
        		+ "            LEFT JOIN stock st\r\n"
        		+ "                ON s.supplier_id = st.supplier_id\r\n"
        		+ "            WHERE s.supplier_name LIKE ?\r\n"
        		+ "               OR s.supplier_phone LIKE ?\r\n"
        		+ "            ORDER BY \"\"\" + sortField + \" \" + sortDir + \"\"\"\r\n"
        		+ "            LIMIT ? OFFSET ?";
          
       

        String like = "%" + keyword + "%";

        return jdbc.query(sql, (rs, rowNum) -> {
            Supplier s = new Supplier();
            s.setSupplierId(rs.getInt("supplier_id"));
            s.setSupplierName(rs.getString("supplier_name"));
            s.setPhone(rs.getString("supplier_phone"));
            s.setAddress(rs.getString("supplier_address"));
            s.setStockName(rs.getString("stock_name")); // ⭐ item name
            return s;
        }, like, like, limit, offset);
    }

    // =========================
    // COUNT
    // =========================
    public int countSearch(String keyword) {
        String like = "%" + keyword + "%";
        return jdbc.queryForObject(
            "SELECT COUNT(*) FROM supplier WHERE supplier_name LIKE ? OR supplier_phone LIKE ?",
            Integer.class, like, like
        );
    }

    // =========================
    // ADD
    // =========================
    public void add(Supplier s) {
        jdbc.update(
            "INSERT INTO supplier (supplier_name, supplier_phone, supplier_address) VALUES (?, ?, ?)",
            s.getSupplierName(),
            s.getPhone(),
            s.getAddress()
        );
    }

    // =========================
    // UPDATE
    // =========================
    public void update(Supplier s) {
        jdbc.update(
            "UPDATE supplier SET supplier_name=?, supplier_phone=?, supplier_address=? WHERE supplier_id=?",
            s.getSupplierName(),
            s.getPhone(),
            s.getAddress(),
            s.getSupplierId()
        );
    }

    // =========================
    // DELETE
    // =========================
    public void delete(int id) {
        jdbc.update("DELETE FROM supplier WHERE supplier_id=?", id);
    }

    // =========================
    // GET BY ID
    // =========================
    public Supplier getById(int id) {
        return jdbc.queryForObject(
            "SELECT * FROM supplier WHERE supplier_id=?",
            (rs, rowNum) -> {
                Supplier s = new Supplier();
                s.setSupplierId(rs.getInt("supplier_id"));
                s.setSupplierName(rs.getString("supplier_name"));
                s.setPhone(rs.getString("supplier_phone"));
                s.setAddress(rs.getString("supplier_address"));
                return s;
            },
            id
        );
    }
}




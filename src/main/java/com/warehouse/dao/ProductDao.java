package com.warehouse.dao;

import com.warehouse.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // =========================
    // FIND ALL PRODUCTS
    // =========================
    public List<Product> findAll() {

        String sql = " SELECT "
                + " s.stock_id, s.stock_name, s.stock_location, s.stock_remark, "
                + " i.item_id, i.item_name, i.sku, i.unit_price, "
                + " IFNULL(sb.available_qty, 0) AS available_qty, "
                + " s.product_image "
                + " FROM stock s "
                + " JOIN item i ON s.item_id = i.item_id "
                + " LEFT JOIN stock_balance sb ON sb.stock_id = s.stock_id "
                + " ORDER BY s.stock_id ASC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapProduct(rs));
    }

    // =========================
    // FIND BY ID
    // =========================
    public Product findById(int stockId) {

        String sql = " SELECT "
                + " s.stock_id, s.stock_name, s.stock_location, s.stock_remark, "
                + " i.item_id, i.item_name, i.sku, i.unit_price, "
                + " IFNULL(sb.available_qty, 0) AS available_qty, "
                + " s.product_image "
                + " FROM stock s "
                + " JOIN item i ON s.item_id = i.item_id "
                + " LEFT JOIN stock_balance sb ON sb.stock_id = s.stock_id "
                + " WHERE s.stock_id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapProduct(rs), stockId);
    }

    // =========================
    // INSERT PRODUCT
    // =========================
    public int add(Product product) {

        String sql = "INSERT INTO stock "
                + "(item_id, stock_name, stock_location, stock_remark, product_image) "
                + "VALUES (?, ?, ?, ?, ?)";

        return jdbcTemplate.update(sql,
                product.getItemId(),
                product.getStockName(),
                product.getStockLocation(),
                product.getStockRemark(),
                product.getProductImage()
        );
    }

    // =========================
    // UPDATE PRODUCT
    // =========================
    public int update(Product product) {

        // If image is updated
        if (product.getProductImage() != null && !product.getProductImage().isEmpty()) {

            String sql = "UPDATE stock SET "
                    + "item_id=?, stock_name=?, stock_location=?, stock_remark=?, product_image=? "
                    + "WHERE stock_id=?";

            return jdbcTemplate.update(sql,
                    product.getItemId(),
                    product.getStockName(),
                    product.getStockLocation(),
                    product.getStockRemark(),
                    product.getProductImage(),
                    product.getStockId()
            );
        }

        // No image update
        String sql = "UPDATE stock SET "
                + "item_id=?, stock_name=?, stock_location=?, stock_remark=? "
                + "WHERE stock_id=?";

        return jdbcTemplate.update(sql,
                product.getItemId(),
                product.getStockName(),
                product.getStockLocation(),
                product.getStockRemark(),
                product.getStockId()
        );
    }

    // =========================
    // BEST SELLER PRODUCTS
    // =========================
    public List<Product> findBestSellers() {

        /*
         * Simple & safe logic:
         * Show latest 6 products as best sellers
         * (Later can be replaced by order-based logic)
         */

        String sql = " SELECT "
                + " s.stock_id, s.stock_name, s.stock_location, s.stock_remark, "
                + " i.item_id, i.item_name, i.sku, i.unit_price, "
                + " IFNULL(sb.available_qty, 0) AS available_qty, "
                + " s.product_image "
                + " FROM stock s "
                + " JOIN item i ON s.item_id = i.item_id "
                + " LEFT JOIN stock_balance sb ON sb.stock_id = s.stock_id "
                + " ORDER BY s.stock_id DESC "
                + " LIMIT 6";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapProduct(rs));
    }

    // =========================
    // MAP RESULTSET TO PRODUCT
    // =========================
    private Product mapProduct(ResultSet rs) throws SQLException {

        Product p = new Product();

        p.setStockId(rs.getInt("stock_id"));
        p.setStockName(rs.getString("stock_name"));
        p.setStockLocation(rs.getString("stock_location"));
        p.setStockRemark(rs.getString("stock_remark"));

        p.setItemId(rs.getInt("item_id"));
        p.setItemName(rs.getString("item_name"));
        p.setSku(rs.getString("sku"));

        p.setUnitPrice(rs.getDouble("unit_price"));
        p.setAvailableQty(rs.getInt("available_qty"));
        p.setProductImage(rs.getString("product_image"));

        return p;
    }
}

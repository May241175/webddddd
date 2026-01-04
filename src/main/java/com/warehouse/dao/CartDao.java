package com.warehouse.dao;

import com.warehouse.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDao {

    @Autowired
    private JdbcTemplate jdbc;

    // ===========================
    // ADD TO CART
    // ===========================
    public void addToCart(int userId, int stockId, int quantity) {

        // Check if already exists
        String checkSql = "SELECT COUNT(*) FROM cart WHERE user_id = ? AND stock_id = ?";
        int count = jdbc.queryForObject(checkSql, Integer.class, userId, stockId);

        if (count > 0) {
            // Update quantity
            String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND stock_id = ?";
            jdbc.update(updateSql, quantity, userId, stockId);
        } else {
            // Insert new
            String insertSql = "INSERT INTO cart (user_id, stock_id, quantity) VALUES (?, ?, ?)";
            jdbc.update(insertSql, userId, stockId, quantity);
        }
    }

    // ===========================
    // GET CART BY USER
    // ===========================
    public List<CartItem> getCartByUser(int userId) {

        String sql =
                "SELECT " +
                "   c.cart_id, " +
                "   c.user_id, " +
                "   c.stock_id, " +
                "   c.quantity, " +
                "   s.item_id, " +
                "   s.stock_name, " +
                "   i.item_name, " +
                "   i.unit_price, " +
                "   COALESCE(sb.available_qty, 0) AS available_qty, " +
                "   s.product_image " +
                "FROM cart c " +
                "JOIN stock s ON c.stock_id = s.stock_id " +
                "JOIN item i ON s.item_id = i.item_id " +
                "LEFT JOIN stock_balance sb ON s.stock_id = sb.stock_id " +
                "WHERE c.user_id = ?";

        return jdbc.query(sql, (rs, rowNum) -> {
            CartItem item = new CartItem();

            item.setCartItemId(rs.getInt("cart_id"));
            item.setUserId(rs.getInt("user_id"));
            item.setStockId(rs.getInt("stock_id"));
            item.setQuantity(rs.getInt("quantity"));

            item.setItemId(rs.getInt("item_id"));
            item.setStockName(rs.getString("stock_name"));
            item.setItemName(rs.getString("item_name"));
            item.setUnitPrice(rs.getDouble("unit_price"));
            item.setAvailableQty(rs.getInt("available_qty"));
            item.setProductImage(rs.getString("product_image"));

            item.setUnit("piece");

            return item;
        }, userId);
    }

    // ===========================
    // UPDATE QUANTITY
    // ===========================
    public void updateQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        jdbc.update(sql, quantity, cartId);
    }

    // ===========================
    // DELETE A SINGLE ITEM
    // ===========================
    public void delete(int cartId) {
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        jdbc.update(sql, cartId);
    }

    // ===========================
    // CLEAR ALL ITEMS
    // ===========================
    public void clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        jdbc.update(sql, userId);
    }
}

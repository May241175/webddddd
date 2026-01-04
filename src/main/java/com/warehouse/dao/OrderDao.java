package com.warehouse.dao;

import com.warehouse.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDao {

    @Autowired
    private JdbcTemplate jdbc;

    // ============================
    // GENERATE ORDER NUMBER
    // ============================
    private String generateOrderNumber() {
        String sql = "SELECT COUNT(*) FROM orders";
        int count = jdbc.queryForObject(sql, Integer.class) + 1;

        return String.format("ORD-%d-%04d", java.time.Year.now().getValue(), count);
    }

    // ============================
    // SAVE ORDER (header + items)
    // ============================
    public int saveOrder(int userId, String address, String payment,
                         Collection<CartItem> cartItems) {

        String orderNumber = generateOrderNumber();

        KeyHolder keyHolder = new GeneratedKeyHolder();

        // Insert order header using KeyHolder
        jdbc.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO orders (order_number, user_id, subtotal, tax, total, status, payment_method, delivery_address) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, orderNumber);
            ps.setInt(2, userId);
            ps.setDouble(3, 0.00);      // subtotal
            ps.setDouble(4, 0.00);      // tax
            ps.setDouble(5, 0.00);      // total
            ps.setString(6, "Pending");
            ps.setString(7, payment);
            ps.setString(8, address);
            return ps;
        }, keyHolder);

        int orderId = keyHolder.getKey().intValue();
        System.out.println("ORDER ID AFTER INSERT = " + orderId);

        // Insert order items
        String itemSql =
                "INSERT INTO order_items (order_id, stock_id, item_id, item_name, price, quantity, unit) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";

        for (CartItem item : cartItems) {

            jdbc.update(itemSql,
                    orderId,
                    item.getStockId(),
                    item.getItemId(),
                    item.getItemName(),
                    item.getUnitPrice(),
                    item.getQuantity(),
                    item.getUnit()
            );

            jdbc.update("UPDATE stock_balance SET available_qty = available_qty - ? WHERE stock_id = ?",
                    item.getQuantity(),
                    item.getStockId());
        }

        return orderId;
    }

    // ============================
    // ORDER SUMMARY (for success page, history, etc.)
    // ============================
    public Map<String, Object> getOrderSummary(int orderId) {

        // get order number
        String orderSql = "SELECT order_number FROM orders WHERE id = ?";
        String orderNumber = jdbc.queryForObject(orderSql, String.class, orderId);

        // get ordered items
        String itemsSql =
                "SELECT oi.item_name, oi.quantity, oi.price, (oi.price * oi.quantity) AS totalPrice " +
                "FROM order_items oi WHERE oi.order_id = ?";

        List<CartItem> items = jdbc.query(itemsSql, (rs, rowNum) -> {
            CartItem c = new CartItem();
            c.setItemName(rs.getString("item_name"));
            c.setQuantity(rs.getInt("quantity"));
            c.setUnitPrice(rs.getDouble("price"));
            c.setTotalPrice(rs.getDouble("totalPrice"));
            return c;
        }, orderId);

        double total = items.stream().mapToDouble(CartItem::getTotalPrice).sum();

        Map<String, Object> map = new HashMap<>();
        map.put("order_number", orderNumber);
        map.put("items", items);
        map.put("total", total);

        return map;
    }
    public List<Map<String, Object>> getOrdersByUser(int userId) {
        String sql =
                "SELECT id, order_number, status, total, payment_method, order_date " +
                "FROM orders WHERE user_id = ? ORDER BY id DESC";

        return jdbc.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", rs.getInt("id"));
            map.put("order_number", rs.getString("order_number"));
            map.put("status", rs.getString("status"));
            map.put("total", rs.getDouble("total"));
            map.put("payment_method", rs.getString("payment_method"));
            map.put("order_date", rs.getTimestamp("order_date"));
            return map;
        }, userId);
    }
    public Map<String, Object> getOrderStats(int userId) {

        String sql =
                "SELECT " +
                "   COUNT(*) AS total, " +
                "   SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pending, " +
                "   SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered, " +
                "   SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled " +
                "FROM orders WHERE user_id = ?";

        return jdbc.queryForMap(sql, userId);
    }
    public Map<String, Object> getInvoiceData(int orderId) {

        // Order header
        String orderSql = "SELECT o.order_number, o.order_date, o.delivery_address, u.user_fullname, u.user_email, u.user_phone_number " +
                          "FROM orders o JOIN user u ON o.user_id = u.user_id WHERE o.id = ?";
        Map<String, Object> header = jdbc.queryForMap(orderSql, orderId);

        // Order items
        String itemSql = "SELECT item_name, quantity, price, (price * quantity) AS total FROM order_items WHERE order_id = ?";
        List<Map<String, Object>> items = jdbc.queryForList(itemSql, orderId);

        // Total
        double total = items.stream()
                .mapToDouble(i -> (double) i.get("total"))
                .sum();

        header.put("items", items);
        header.put("grand_total", total);

        return header;
    }



}

package com.warehouse.dao;

import com.warehouse.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // =====================
    // LOGIN
    // =====================
    public User login(String email, String password) {
        try {
            String sql = "SELECT * FROM user WHERE user_email=? AND user_password=?";
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapUser(rs), email, password);
        } catch (Exception e) {
            return null;
        }
    }

    // =====================
    // REGISTER
    // =====================
    public int register(User user) {
        String sql = "   INSERT INTO user \r\n"
        		+ "            (user_name, user_email, user_password, user_fullname, user_phone_number)\r\n"
        		+ "            VALUES (?, ?, ?, ?, ?)";

        return jdbcTemplate.update(
            sql,
            user.getUser_name(),
            user.getUser_email(),
            user.getUser_password(),
            user.getUser_fullname(),
            user.getUser_phone_number()
        );
    }

    // =====================
    // MAP RESULTSET
    // =====================
    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUser_id(rs.getInt("user_id"));
        u.setUser_name(rs.getString("user_name"));
        u.setUser_email(rs.getString("user_email"));
        u.setUser_password(rs.getString("user_password"));
        u.setUser_fullname(rs.getString("user_fullname"));
        u.setUser_phone_number(rs.getString("user_phone_number"));
        u.setUser_address(rs.getString("user_address"));
        u.setUser_payment(rs.getString("user_payment"));
        u.setIs_admin(rs.getBoolean("is_admin"));
        return u;
    }

    // =====================
    // PROFILE
    // =====================
    public Map<String, Object> getUserProfile(int userId) {
        String sql = " SELECT user_fullname, user_email, user_phone_number \r\n"
        		+ "            FROM user WHERE user_id = ?\r\n";
        	
           
        return jdbcTemplate.queryForMap(sql, userId);
    }

    public void updateProfile(int userId, String name, String email, String phone) {
        String sql = " UPDATE user \r\n"
        		+ "            SET user_fullname=?, user_email=?, user_phone_number=? \r\n"
        		+ "            WHERE user_id=?";
           
       
        jdbcTemplate.update(sql, name, email, phone, userId);
    }

    // =====================
    // PASSWORD
    // =====================
    public String getPassword(int userId) {
        String sql = "SELECT user_password FROM user WHERE user_id = ?";
        return jdbcTemplate.queryForObject(sql, String.class, userId);
    }

    public void updatePassword(int userId, String newPass) {
        String sql = "UPDATE user SET user_password=? WHERE user_id=?";
        jdbcTemplate.update(sql, newPass, userId);
    }

    // =====================
    // FIND BY ID (ADMIN / PROFILE)
    // =====================
    public User findById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapUser(rs), userId);
    }
}

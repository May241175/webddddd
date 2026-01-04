package com.warehouse.dao;

import com.warehouse.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CustomerDao {

    @Autowired
    private JdbcTemplate jdbc;

    private Customer mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        Customer c = new Customer();
        c.setUserId(rs.getInt("user_id"));
        c.setUserName(rs.getString("user_name"));
        c.setUserEmail(rs.getString("user_email"));
        c.setUserPassword(rs.getString("user_password"));
        c.setUserFullname(rs.getString("user_fullname"));
        c.setIsAdmin(rs.getInt("is_admin"));
        c.setUserPhoneNumber(rs.getString("user_phone_number"));
        c.setUserAddress(rs.getString("user_address"));
        c.setUserPayment(rs.getString("user_payment"));
        return c;
    }

    public List<Customer> searchAndSort(String keyword, int offset, int limit, String sortField, String sortDir) {
        String sql = "SELECT * FROM user WHERE user_name LIKE ? OR user_phone_number LIKE ? "
                    + "ORDER BY " + sortField + " " + sortDir + " LIMIT ?, ?";

        String like = "%" + keyword + "%";

        return jdbc.query(sql,
            (rs, rowNum) -> mapRow(rs),
            like, like, offset, limit
        );
    }

    public int countSearch(String keyword) {
        String like = "%" + keyword + "%";
        return jdbc.queryForObject(
            "SELECT COUNT(*) FROM user WHERE user_name LIKE ? OR user_phone_number LIKE ?",
            Integer.class, like, like
        );
    }

    // ADD
    public void add(Customer c) {
        jdbc.update(
                "INSERT INTO user (user_name, user_email, user_password, user_fullname, user_phone_number, user_address, user_payment, is_admin) VALUES (?, ?, ?, ?, ?, ?, ?, 0)",
                c.getUserName(), c.getUserEmail(), c.getUserPassword(), c.getUserFullname(),
                c.getUserPhoneNumber(), c.getUserAddress(), c.getUserPayment()
        );
    }

    // DELETE
    public void delete(int id) {
        jdbc.update("DELETE FROM user WHERE user_id=?", id);
    }

    // GET BY ID
    public Customer getById(int id) {
        return jdbc.queryForObject(
            "SELECT * FROM user WHERE user_id=?",
            (rs, rowNum) -> mapRow(rs),
            id
        );
    }

    // UPDATE
    public void update(Customer c) {
        jdbc.update(
            "UPDATE user SET user_name=?, user_email=?, user_password=?, user_fullname=?, user_phone_number=?, user_address=?, user_payment=? WHERE user_id=?",
            c.getUserName(), c.getUserEmail(), c.getUserPassword(), c.getUserFullname(),
            c.getUserPhoneNumber(), c.getUserAddress(), c.getUserPayment(), c.getUserId()
        );
    }
}

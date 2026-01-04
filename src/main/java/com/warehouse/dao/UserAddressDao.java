package com.warehouse.dao;

import com.warehouse.model.UserAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserAddressDao {

    @Autowired
    private JdbcTemplate jdbc;

    // =========================
    // GET DEFAULT ADDRESS
    // =========================
    public UserAddress getDefaultAddress(int userId) {

        String sql = "SELECT *\r\n"
        		+ "            FROM user_address\r\n"
        		+ "            WHERE user_id = ? AND is_default = 1\r\n"
        		+ "            LIMIT 1";

        List<UserAddress> list = jdbc.query(
                sql,
                new BeanPropertyRowMapper<>(UserAddress.class),
                userId
        );

        return list.isEmpty() ? null : list.get(0);
    }

    // =========================
    // GET ALL ADDRESSES BY USER
    // =========================
    public List<UserAddress> getAddresses(int userId) {

        String sql = " SELECT *\r\n"
        		+ "            FROM user_address\r\n"
        		+ "            WHERE user_id = ?\r\n"
        		+ "            ORDER BY is_default DESC, address_id DESC";

        return jdbc.query(
                sql,
                new BeanPropertyRowMapper<>(UserAddress.class),
                userId
        );
    }

    // =========================
    // GET ADDRESS BY ID
    // =========================
    public UserAddress getAddressById(int addressId) {

        String sql = "SELECT * FROM user_address WHERE address_id = ?";

        return jdbc.queryForObject(
                sql,
                new BeanPropertyRowMapper<>(UserAddress.class),
                addressId
        );
    }

    // =========================
    // ADD ADDRESS (SET AS DEFAULT)
    // =========================
    public void addAddress(UserAddress address) {

        // reset old default
        jdbc.update(
                "UPDATE user_address SET is_default = 0 WHERE user_id = ?",
                address.getUserId()
        );

        String sql = "INSERT INTO user_address\r\n"
        		+ "            (user_id, full_name, phone, address_line, city, region, is_default)\r\n"
        		+ "            VALUES (?, ?, ?, ?, ?, ?, 1)";
            
       

        jdbc.update(sql,
                address.getUserId(),
                address.getFullName(),
                address.getPhone(),
                address.getAddressLine(),
                address.getCity(),
                address.getRegion()
        );
    }

    // =========================
    // UPDATE ADDRESS
    // =========================
    public void updateAddress(UserAddress address) {

        String sql = "UPDATE user_address\r\n"
        		+ "            SET full_name = ?, phone = ?, address_line = ?, city = ?, region = ?\r\n"
        		+ "            WHERE address_id = ? AND user_id = ?";
            
      

        jdbc.update(sql,
                address.getFullName(),
                address.getPhone(),
                address.getAddressLine(),
                address.getCity(),
                address.getRegion(),
                address.getAddressId(),
                address.getUserId()
        );
    }

    // =========================
    // SET DEFAULT ADDRESS
    // =========================
    public void setDefault(int userId, int addressId) {

        jdbc.update(
                "UPDATE user_address SET is_default = 0 WHERE user_id = ?",
                userId
        );

        jdbc.update(
                "UPDATE user_address SET is_default = 1 WHERE address_id = ? AND user_id = ?",
                addressId, userId
        );
    }

    // =========================
    // DELETE ADDRESS
    // =========================
    public void delete(int addressId) {

        jdbc.update(
                "DELETE FROM user_address WHERE address_id = ?",
                addressId
        );
    }
}

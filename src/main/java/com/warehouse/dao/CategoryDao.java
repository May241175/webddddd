package com.warehouse.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

// ✅ ဒီ import မဖြစ်မနေလိုအပ်
import com.warehouse.model.Category;

@Repository
public class CategoryDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Category> findAll() {

        String sql =
                "SELECT MIN(category_id) AS category_id, category_name " +
                "FROM category " +
                "GROUP BY category_name " +
                "ORDER BY category_name";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Category c = new Category();
            c.setCategoryId(rs.getInt("category_id"));
            c.setCategoryName(rs.getString("category_name"));
            return c;
        });
    }
}

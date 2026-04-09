package org.example.dao;

import org.example.models.Users;
import java.sql.*;

public class UserDAO {

    // ====================== LOGIN ======================
    public Users login(String email, String password) {
        Users user = null;

        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Users();
                    user.setName(rs.getString("name"));     // changed from "nom"
                    user.setEmail(rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // ====================== REGISTER ======================
    public boolean register(Users user) {
        String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            System.out.println("🔄 Trying to insert: Name=" + user.getName() + ", Email=" + user.getEmail());

            int rowsAffected = ps.executeUpdate();

            System.out.println("✅ Rows affected: " + rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("❌ SQL Error during registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("❌ Unexpected error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    }
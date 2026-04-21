package org.example.dao;

import org.example.models.Users;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // ====================== LOGIN ======================
    public Users login(String email, String password) {
        String sql = "SELECT id_users, name, email, role FROM users WHERE email = ? AND password = ?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email != null ? email.trim() : "");
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getInt("id_users"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ====================== REGISTER ======================
    public boolean register(Users user) {
        if (user == null || user.getEmail() == null || user.getPassword() == null) {
            return false;
        }

        String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole() != null ? user.getRole() : "etudiant");

            System.out.println("🔄 Trying to insert: Name=" + user.getName() + ", Email=" + user.getEmail());

            int rowsAffected = ps.executeUpdate();
            System.out.println("✅ Rows affected: " + rowsAffected);
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("❌ SQL Error during registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get all users for admin panel — FIXED
    public List<Users> getAllUsers() {
        List<Users> usersList = new ArrayList<>();
        String sql = "SELECT id_users, name, email, role FROM users ORDER BY id_users";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("id_users"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                usersList.add(user);
            }

            System.out.println("Successfully fetched " + usersList.size() + " users from database");

        } catch (SQLException e) {
            System.out.println("SQL Error in getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return usersList;
    }
}
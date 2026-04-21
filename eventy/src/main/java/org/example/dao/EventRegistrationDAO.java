package org.example.dao;

import java.sql.*;

public class EventRegistrationDAO {

    public boolean registerUserForEvent(int userId, int eventId, String motivation) {
        String sql = "INSERT INTO event_registration (user_id, event_id, motivation) VALUES (?, ?, ?)";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);           // Changed to int
            ps.setString(3, motivation != null ? motivation : "");

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {   // Duplicate entry
                return false; // Already registered
            }
            e.printStackTrace();
            return false;
        }
    }
}
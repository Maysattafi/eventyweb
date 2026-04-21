package org.example.dao;

import org.example.models.EventComment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventCommentDAO {

    // Add a new comment
    public boolean addComment(int eventId, int userId, String comment, int rating) {
        String sql = "INSERT INTO event_comments (event_id, user_id, comment, rating) VALUES (?, ?, ?, ?)";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ps.setString(3, comment);
            ps.setInt(4, rating);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all comments for an event
    public List<EventComment> getCommentsByEvent(int eventId) {
        List<EventComment> comments = new ArrayList<>();
        String sql = """
            SELECT c.*, u.name as username 
            FROM event_comments c
            JOIN users u ON c.user_id = u.id_users
            WHERE c.event_id = ?
            ORDER BY c.comment_date DESC
            """;

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventComment comment = new EventComment();
                    // In getCommentsByEvent:
                    comment.setId(rs.getInt("id"));
                    comment.setEventId(rs.getInt("event_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setUsername(rs.getString("username"));
                    comment.setComment(rs.getString("comment"));
                    comment.setRating(rs.getInt("rating"));
                    comment.setCommentDate(rs.getTimestamp("comment_date"));
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}

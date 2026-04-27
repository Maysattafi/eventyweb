package org.example.dao;

import org.example.models.Event;
import org.example.models.RegistrationInfo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // Add new event
    public boolean addEvent(Event event) {
        String sql = "INSERT INTO events (titre, description, date_event, n_sale, image,category) VALUES (?, ?, ?, ?, ?,?)";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getTitre());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getDateEvent());
            ps.setString(4, event.getnSale());
            ps.setString(5, event.getImage() != null ? event.getImage() : "");
            ps.setString(6,event.getCategory());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error adding event: " + e.getMessage());
            return false;
        }
    }

    // Get all events
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                event.setIdEvent(rs.getLong("id_event"));
                event.setTitre(rs.getString("titre"));
                event.setDescription(rs.getString("description"));
                event.setDateEvent(rs.getString("date_event"));
                event.setnSale(rs.getString("n_sale"));
                event.setImage(rs.getString("image"));
                event.setCategory(rs.getString("category"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Get event by ID
    public Event getEventById(Long id) {
        Event event = null;
        String sql = "SELECT * FROM events WHERE id_event = ?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    event = new Event();
                    event.setIdEvent(rs.getLong("id_event"));
                    event.setTitre(rs.getString("titre"));
                    event.setDescription(rs.getString("description"));
                    event.setDateEvent(rs.getString("date_event"));
                    event.setnSale(rs.getString("n_sale"));
                    event.setImage(rs.getString("image"));
                    event.setCategory(rs.getString("category"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return event;
    }
    // Replace your current getRecentEvents with this:
    public List<Event> getRecentEvents(int limit) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE date_event >= NOW() ORDER BY date_event ASC LIMIT ?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Event event = new Event();
                    event.setIdEvent(rs.getLong("id_event"));
                    event.setTitre(rs.getString("titre"));
                    event.setDescription(rs.getString("description"));
                    event.setDateEvent(rs.getString("date_event"));
                    event.setnSale(rs.getString("n_sale"));
                    event.setImage(rs.getString("image"));
                    event.setCategory(rs.getString("category"));
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    public List<RegistrationInfo> getRegisteredStudents(Long eventId) {
        List<RegistrationInfo> list = new ArrayList<>();

        String sql = """
            SELECT u.id_users, u.name, u.email, r.motivation, r.registration_date 
            FROM event_registration r
            JOIN users u ON r.user_id = u.id_users
            WHERE r.event_id = ?
            ORDER BY r.registration_date DESC
            """;

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, eventId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RegistrationInfo info = new RegistrationInfo();
                    info.setUserId(rs.getInt("id_users"));
                    info.setName(rs.getString("name"));
                    info.setEmail(rs.getString("email"));
                    info.setMotivation(rs.getString("motivation"));
                    info.setRegistrationDate(rs.getTimestamp("registration_date"));
                    list.add(info);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    // Get all ended (past) events
    public List<Event> getEndedEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE date_event < NOW() ORDER BY date_event DESC";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                event.setIdEvent(rs.getLong("id_event"));
                event.setTitre(rs.getString("titre"));
                event.setDescription(rs.getString("description"));
                event.setDateEvent(rs.getString("date_event"));
                event.setnSale(rs.getString("n_sale"));
                event.setImage(rs.getString("image"));
                event.setCategory(rs.getString("category"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM events WHERE category IS NOT NULL AND category != '' ORDER BY category";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
    public boolean updateEvent(Event event) {
        String sql = "UPDATE events SET titre=?, description=?, date_event=?, n_sale=?, image=? WHERE id_event=?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getTitre());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getDateEvent());
            ps.setString(4, event.getnSale());
            ps.setString(5, event.getImage() != null ? event.getImage() : "");
            ps.setLong(6, event.getIdEvent());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteEvent(Long eventId) {
        String sql = "DELETE FROM events WHERE id_event = ?";

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, eventId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }


}
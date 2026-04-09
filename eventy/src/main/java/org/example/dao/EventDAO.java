package org.example.dao;

import org.example.models.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public Event getEventById(int id) {
        Event event = null;

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM events WHERE id=?")) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    event = new Event();
                    event.setId(rs.getLong("id"));
                    event.setTitre(rs.getString("titre"));
                    event.setDescription(rs.getString("description"));
                    event.setDate(rs.getString("date"));
                    event.setn_sale(rs.getString("n_sale"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return event;
    }

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM events");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event e = new Event();
                e.setId(rs.getLong("id"));
                e.setTitre(rs.getString("titre"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getString("date"));      // make sure column name matches your DB
                e.setn_sale(rs.getString("n_sale"));  // or "lieu" if that's the column name

                events.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }
}
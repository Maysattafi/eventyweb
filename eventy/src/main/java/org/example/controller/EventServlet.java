package org.example.controller;

import org.example.dao.EventDAO;
import org.example.models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/events")
public class EventServlet extends HttpServlet {

    private final EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            // Show all events
            List<Event> events = eventDAO.getAllEvents();
            request.setAttribute("events", events);
            request.getRequestDispatcher("events.jsp").forward(request, response);

        } else {
            // Show single event details
            try {
                int id = Integer.parseInt(idParam);
                Event event = eventDAO.getEventById(id);

                if (event != null) {
                    request.setAttribute("event", event);
                    request.getRequestDispatcher("eventDetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Événement introuvable");
                    request.getRequestDispatcher("events.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID d'événement invalide");
                request.getRequestDispatcher("events.jsp").forward(request, response);
            }
        }
    }
}
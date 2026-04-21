package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Event;
import org.example.models.RegistrationInfo;
import java.io.IOException;
import java.util.List;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {

    private final EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String eventIdParam = request.getParameter("eventId");

        // 1. Show list of all events (for admin)
        if ("list".equals(action) || (action == null && idParam == null && eventIdParam == null)) {
            List<Event> events = eventDAO.getAllEvents();
            request.setAttribute("events", events);
            request.getRequestDispatcher("listeEvenements.jsp").forward(request, response);
            return;
        }

        // 2. Show single event details (when clicking "Voir plus")
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                Long eventId = Long.parseLong(idParam);
                Event event = eventDAO.getEventById(eventId);

                if (event != null) {
                    request.setAttribute("event", event);
                    request.getRequestDispatcher("eventDetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Événement non trouvé.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("index.jsp");
            }
            return;
        }

        // 3. Show students registered in an event (for admin)
        if ("registered".equals(action) && eventIdParam != null) {
            try {
                Long eventId = Long.parseLong(eventIdParam);
                Event event = eventDAO.getEventById(eventId);
                List<RegistrationInfo> registeredStudents = eventDAO.getRegisteredStudents(eventId);

                request.setAttribute("event", event);
                request.setAttribute("registeredStudents", registeredStudents);
                request.getRequestDispatcher("inscritsEvenement.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin?action=events");
            }
            return;
        }

        // 4. NEW: Show all ended (past) events
        if ("ended".equals(action)) {
            List<Event> endedEvents = eventDAO.getEndedEvents();
            request.setAttribute("endedEvents", endedEvents);
            request.getRequestDispatcher("evenementsTermines.jsp").forward(request, response);
            return;
        }

        // Default fallback
        response.sendRedirect("index.jsp");
    }
}
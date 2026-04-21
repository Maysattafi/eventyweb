package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.dao.UserDAO;
import org.example.models.Event;
import org.example.models.Users;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final EventDAO eventDAO = new EventDAO();
    private final UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security Check
        Users admin = (Users) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");

            if ("users".equals(action)) {
            List<Users> usersList = userDAO.getAllUsers();

            // === DEBUG ===
            System.out.println("=== DEBUG USERS ===");
            System.out.println("Number of users returned from DAO: " + (usersList != null ? usersList.size() : "null"));
            if (usersList != null) {
                for (Users u : usersList) {
                    System.out.println("User -> ID: " + u.getId() + " | Name: " + u.getName() + " | Email: " + u.getEmail() + " | Role: " + u.getRole());
                }
            }
            // === END DEBUG ===

            request.setAttribute("usersList", usersList);
            request.getRequestDispatcher("listeUtilisateurs.jsp").forward(request, response);
        }
        else if ("events".equals(action)) {
            // Show list of all events
            List<Event> events = eventDAO.getAllEvents();
            request.setAttribute("events", events);
            request.getRequestDispatcher("listeEvenements.jsp").forward(request, response);

        }
        else {

                List<Event> recentEvents = eventDAO.getRecentEvents(9);   // better than getAllEvents()
                request.setAttribute("recentEvents", recentEvents);
                request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
    }
}

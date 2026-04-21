package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.dao.EventRegistrationDAO;
import org.example.models.Event;
import org.example.models.Users;
import java.io.IOException;

@WebServlet("/RegisterEventServlet")
public class RegisterEventServlet extends HttpServlet {

    private final EventRegistrationDAO registrationDAO = new EventRegistrationDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String eventIdStr = request.getParameter("eventId");
        String motivation = request.getParameter("motivation");

        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Inside doPost():
        try {
            int eventId = Integer.parseInt(eventIdStr);   // keep int if your DB uses INT

            boolean success = registrationDAO.registerUserForEvent(user.getId(), eventId, motivation);

            if (success) {
                request.setAttribute("successMessage", "✅ Inscription réussie !");
            } else {
                request.setAttribute("errorMessage", "Vous êtes déjà inscrit à cet événement.");
            }

            Event event = new EventDAO().getEventById((long) eventId);  // safe cast
            request.setAttribute("event", event);
            request.getRequestDispatcher("eventDetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur est survenue.");
            request.getRequestDispatcher("eventDetails.jsp").forward(request, response);
        }
    }
}

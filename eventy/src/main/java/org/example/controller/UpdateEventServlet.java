package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Event;
import org.example.models.Users;

import java.io.IOException;

@WebServlet("/UpdateEventServlet")
public class UpdateEventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security: Only admin can update
        Users admin = (Users) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String dateEvent = request.getParameter("date_event");
            String nSale = request.getParameter("n_sale");
            String image = request.getParameter("image");

            Event event = new Event();
            event.setIdEvent(id);
            event.setTitre(titre);
            event.setDescription(description);
            event.setDateEvent(dateEvent);
            event.setnSale(nSale);
            event.setImage(image != null ? image.trim() : "");

            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.updateEvent(event);

            if (success) {
                response.sendRedirect("admin?action=events&success=updated");
            } else {
                response.sendRedirect("admin?action=events&error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=events&error=invalid_data");
        }
    }
}
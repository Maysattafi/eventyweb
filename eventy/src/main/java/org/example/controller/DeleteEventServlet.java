package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Users;
import java.io.IOException;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security Check - Only Admin
        Users admin = (Users) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("admin?action=events&error=invalid_id");
            return;
        }

        try {
            Long eventId = Long.parseLong(idParam);

            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.deleteEvent(eventId);

            if (success) {
                response.sendRedirect("admin?action=events&success=deleted");
            } else {
                response.sendRedirect("admin?action=events&error=delete_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=events&error=invalid_id");
        }
    }
}
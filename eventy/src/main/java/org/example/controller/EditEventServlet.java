package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Event;
import org.example.models.Users;

import java.io.IOException;

@WebServlet("/EditEventServlet")
public class EditEventServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check
        Users admin = (Users) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("admin?action=events");
            return;
        }

        try {
            Long id = Long.parseLong(idParam);
            EventDAO dao = new EventDAO();
            Event event = dao.getEventById(id);

            if (event != null) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("editEvenement.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin?action=events");
            }
        } catch (Exception e) {
            response.sendRedirect("admin?action=events");
        }
    }
}
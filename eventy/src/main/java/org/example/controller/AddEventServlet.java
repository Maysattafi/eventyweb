package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Event;
import java.io.IOException;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String dateEvent = request.getParameter("date_event");
        String nSale = request.getParameter("n_sale");
        String image = request.getParameter("image");

        Event event = new Event();
        event.setTitre(titre);
        event.setDescription(description);
        event.setDateEvent(dateEvent);
        event.setnSale(nSale);
        event.setImage(image != null ? image : "");

        EventDAO eventDAO = new EventDAO();
        boolean success = eventDAO.addEvent(event);

        if (success) {
            response.sendRedirect("admin?action=events&success=added");
        } else {
            response.sendRedirect("ajouterEvenement.jsp?error=failed");
        }
    }
}
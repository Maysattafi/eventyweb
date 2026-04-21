package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventCommentDAO;
import org.example.models.Users;
import java.io.IOException;

@WebServlet("/AddCommentServlet")
public class AddCommentServlet extends HttpServlet {

    private final EventCommentDAO commentDAO = new EventCommentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("loggedUser");

        // Security check
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String eventIdStr = request.getParameter("eventId");
        String commentText = request.getParameter("comment");
        String ratingStr = request.getParameter("rating");

        if (eventIdStr == null || commentText == null || commentText.trim().isEmpty() || ratingStr == null) {
            response.sendRedirect("evenementsTermines.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);
            int rating = Integer.parseInt(ratingStr);

            // Add the comment
            boolean success = commentDAO.addComment(eventId, user.getId(), commentText.trim(), rating);

            if (success) {
                request.setAttribute("successMessage", "✅ Votre commentaire a été publié avec succès !");
            } else {
                request.setAttribute("errorMessage", "❌ Erreur lors de la publication du commentaire.");
            }

            // Redirect back to the ended events page
            response.sendRedirect("EventServlet?action=ended");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "❌ Une erreur est survenue.");
            response.sendRedirect("EventServlet?action=ended");
        }
    }
}

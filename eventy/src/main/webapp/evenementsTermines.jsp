<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.models.EventComment" %>
<%@ page import="org.example.dao.EventCommentDAO" %>
<%@ page import="java.util.List" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    List<Event> endedEvents = (List<Event>) request.getAttribute("endedEvents");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    EventCommentDAO commentDAO = new EventCommentDAO();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Événements Terminés - Eventy</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; margin: 0; }
        .header {
            background: #1e40af;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        h2 { text-align: center; color: #1e3a8a; margin-bottom: 40px; }
        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 30px;
        }
        .event-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .event-card h3 { color: #1e40af; margin-bottom: 12px; }
        .event-card .date { color: #ef4444; font-weight: 600; margin-bottom: 15px; }
        .past-badge {
            background: #ef4444;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 14px;
            display: inline-block;
            margin-bottom: 15px;
        }

        /* Compact Comment Area */
        .quick-comment {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            min-height: 70px;
            font-size: 14px;
        }
        .btn-small {
            background: #22c55e;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 8px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Eventy</h2>
    <a href="<%= "admin".equals(user.getRole()) ? "admin" : "etudiant.jsp" %>"
       style="color:white;">Retour</a>
</div>

<div class="container">
    <h2>Événements Terminés</h2>

    <div class="events-grid">
        <% if (endedEvents != null && !endedEvents.isEmpty()) {
            for (Event e : endedEvents) {
                List<EventComment> comments = commentDAO.getCommentsByEvent(e.getIdEvent().intValue());
        %>
        <div class="event-card">
            <span class="past-badge">Terminé</span>
            <h3><%= e.getTitre() %></h3>
            <p class="date">📅 <%= e.getDateEvent() %></p>
            <p><strong>Lieu :</strong> <%= e.getnSale() %></p>
            <p><%= e.getDescription() != null && e.getDescription().length() > 140
                    ? e.getDescription().substring(0, 140) + "..."
                    : e.getDescription() %></p>

            <!-- Quick Comment Box -->
            <div class="quick-comment">
                <% if (!"admin".equals(user.getRole())) { %>
                <form action="AddCommentServlet" method="post">
                    <input type="hidden" name="eventId" value="<%= e.getIdEvent() %>">
                    <textarea name="comment" placeholder="Ajouter un commentaire rapide..." rows="2"></textarea>
                    <button type="submit" class="btn-small">Publier commentaire</button>
                </form>
                <% } %>
            </div>

            <!-- Link to Full Details with Expanded Comments -->
            <div style="margin-top: 15px; text-align: center;">
                <a href="EventServlet?id=<%= e.getIdEvent() %>&showComments=true"
                   style="color:#3b82f6; text-decoration:none; font-weight:600;">
                    Voir détails + tous les commentaires
                </a>
            </div>
        </div>
        <% }
        } else { %>
        <p style="text-align: center; color: #64748b; font-size: 18px;">
            Aucun événement terminé pour le moment.
        </p>
        <% } %>
    </div>
</div>

</body>
</html>
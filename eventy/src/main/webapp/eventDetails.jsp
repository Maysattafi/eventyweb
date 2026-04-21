<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.models.EventComment" %>
<%@ page import="org.example.dao.EventCommentDAO" %>
<%@ page import="java.util.List" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    Event event = (Event) request.getAttribute("event");

    if (event == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    EventCommentDAO commentDAO = new EventCommentDAO();
    List<EventComment> comments = commentDAO.getCommentsByEvent(event.getIdEvent().intValue());

    // Check if event is ended
    boolean isEnded = false;
    try {
        String dateStr = event.getDateEvent().replace(" ", "T");
        java.time.LocalDateTime eventDate = java.time.LocalDateTime.parse(dateStr);
        isEnded = eventDate.isBefore(java.time.LocalDateTime.now());
    } catch (Exception ignored) {}
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= event.getTitre() %> - Eventy</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; margin: 0; }
        .header {
            background: #1e40af;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
        }
        .container { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        }
        h1 { color: #1e3a8a; }
        .info { margin: 20px 0; font-size: 18px; }
        .description {
            margin: 30px 0;
            line-height: 1.7;
            font-size: 17px;
            background: #f8fafc;
            padding: 25px;
            border-radius: 12px;
        }

        .comments-section {
            margin-top: 40px;
            padding: 30px;
            background: #f1f5f9;
            border-radius: 12px;
        }
        .comment {
            background: white;
            padding: 18px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 5px solid #3b82f6;
        }
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .rating { color: #eab308; font-size: 20px; }
        textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            min-height: 90px;
            margin-bottom: 10px;
        }
        button {
            background: #22c55e;
            color: white;
            padding: 14px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Eventy</h2>
    <% if (user != null) { %>
    <span>Bienvenue, <%= user.getName() %></span>
    <% } %>
</div>

<div class="container">
    <div class="card">
        <h1><%= event.getTitre() %></h1>
        <div class="info">
            <strong>📅 Date :</strong> <%= event.getDateEvent() %><br>
            <strong>📍 Lieu :</strong> <%= event.getnSale() %>
        </div>

        <div class="description">
            <%= event.getDescription() %>
        </div>

        <%-- Comment Section - Shown for Ended Events --%>
        <% if (isEnded) { %>
        <div class="comments-section">
            <h2>💬 Commentaires des participants (<%= comments.size() %>)</h2>

            <% if (comments.isEmpty()) { %>
            <p style="color:#64748b; font-style:italic;">Soyez le premier à laisser un commentaire !</p>
            <% } else {
                for (EventComment c : comments) { %>
            <div class="comment">
                <div class="comment-header">
                    <strong><%= c.getUsername() %></strong>
                    <span class="rating"><%= "★".repeat(c.getRating()) %></span>
                </div>
                <p><%= c.getComment() %></p>
            </div>
            <% } } %>

            <%-- Comment Form - Only for logged in students and admins --%>
            <% if (user != null ) { %>
            <div style="margin-top: 30px;">
                <h3>Ajouter un commentaire</h3>
                <form action="AddCommentServlet" method="post">
                    <input type="hidden" name="eventId" value="<%= event.getIdEvent() %>">
                    <textarea name="comment" placeholder="Que pensez-vous de cet événement ?" required></textarea>
                    <select name="rating" style="width:100%; padding:12px; margin:10px 0;">
                        <option value="5">5 ★ Excellent</option>
                        <option value="4">4 ★ Très bien</option>
                        <option value="3">3 ★ Bien</option>
                        <option value="2">2 ★ Moyen</option>
                        <option value="1">1 ★ À améliorer</option>
                    </select>
                    <button type="submit">Publier mon commentaire</button>
                </form>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <!-- Registration for upcoming events -->
        <%-- Registration Section - Only for upcoming events and logged-in students --%>
        <% if (!isEnded && user != null && !"admin".equals(user.getRole())) { %>

        <div style="margin-top:40px; padding:30px; background:#f1f5f9; border-radius:12px;">
            <h2>S'inscrire à cet événement</h2>

            <%-- Success / Error Messages --%>
            <%
                String successMsg = (String) request.getAttribute("successMessage");
                String errorMsg = (String) request.getAttribute("errorMessage");

                if (successMsg != null) {
            %>
            <p style="color: #22c55e; font-weight: 600; margin-bottom: 20px; padding: 12px; background: #f0fdf4; border-radius: 8px;">
                ✅ <%= successMsg %>
            </p>
            <% }
                if (errorMsg != null) {
            %>
            <p style="color: #ef4444; font-weight: 600; margin-bottom: 20px; padding: 12px; background: #fef2f2; border-radius: 8px;">
                ❌ <%= errorMsg %>
            </p>
            <% } %>

            <form action="RegisterEventServlet" method="post">
                <input type="hidden" name="eventId" value="<%= event.getIdEvent() %>">
                <input type="text" name="motivation"
                       placeholder="Pourquoi voulez-vous participer ? (facultatif)"
                       style="width:100%; padding:14px; margin-bottom:18px; border-radius:8px; border:1px solid #ddd;">
                <button type="submit" style="background:#22c55e; color:white; padding:14px 32px; border:none; border-radius:8px; font-size:16px; cursor:pointer;">
                    Confirmer mon inscription
                </button>
            </form>
        </div>

        <% } %>
        <% } %>
    </div>
</div>

</body>
</html>
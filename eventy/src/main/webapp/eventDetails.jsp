<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.models.EventComment" %>
<%@ page import="org.example.dao.EventCommentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    Event event = (Event) request.getAttribute("event");

    if (event == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    EventCommentDAO commentDAO = new EventCommentDAO();
    List<EventComment> comments = commentDAO.getCommentsByEvent(event.getIdEvent().intValue());

    boolean isEnded = false;
    try {
        String rawDate = event.getDateEvent();
        if (rawDate != null && rawDate.length() >= 10) {
            LocalDate eventDate = LocalDate.parse(rawDate.substring(0, 10));
            isEnded = eventDate.isBefore(LocalDate.now());
        }
    } catch (Exception e) {
        isEnded = false;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= event.getTitre() %> - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .event-detail-container { max-width: 1100px; margin: 80px auto; padding: 0 48px; }
        .event-hero {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            margin-bottom: 40px;
        }
        .event-image { width: 100%; height:40%; object-fit: cover; }
        .event-content { padding: 50px 60px; }
        .event-title {
            font-family: 'Syne', sans-serif;
            font-size: 42px;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 20px;
        }
        .event-meta {
            display: flex; gap: 30px; flex-wrap: wrap; margin-bottom: 40px;
            font-size: 16px; color: var(--text-muted);
        }
        .event-meta strong { color: var(--blue-light); }
        .description {
            font-size: 17px; line-height: 1.8; color: var(--text-main);
            background: var(--navy-3); padding: 35px;
            border-radius: var(--radius-lg); border-left: 5px solid var(--blue);
        }
    </style>
</head>
<body>

<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="index.jsp" class="logo"><span class="logo-dot"></span> Eventy</a>
        <ul class="nav-links">
            <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a href="events.jsp" class="nav-link">Événements</a></li>
            <li><a href="evenementsTermines.jsp" class="nav-link">Historique</a></li>
        </ul>
        <a href="<%= user != null ? "logout" : "login.jsp" %>" class="btn-nav">
            <%= user != null ? "Déconnexion" : "Connexion" %>
        </a>
    </div>
</nav>

<div class="event-detail-container">
    <div class="event-hero">
        <% if (event.getImage() != null && !event.getImage().isEmpty()) { %>
        <img src="<%= request.getContextPath() + "/" + event.getImage() %>"
             alt="<%= event.getTitre() %>" class="event-image">
        <% } else { %>
        <div style="height:380px; background:linear-gradient(45deg,#1e3a8a,#3b82f6); display:flex; align-items:center; justify-content:center; color:white; font-size:18px;">
            Pas d'image disponible
        </div>
        <% } %>

        <div class="event-content">
            <h1 class="event-title"><%= event.getTitre() %></h1>
            <div class="event-meta">
                <div><strong>📅 Date et heure :</strong> <%= event.getDateEvent() != null ? event.getDateEvent() : "Non définie" %></div>
                <div><strong>📍 Lieu :</strong> <%= event.getnSale() %></div>
            </div>
            <div class="description"><%= event.getDescription() %></div>
        </div>
    </div>

    <% if (isEnded) { %>
    <!-- Comments section remains the same -->
    <div class="comments-section">
        <h2>💬 Commentaires des participants (<%= comments.size() %>)</h2>
        <% if (comments.isEmpty()) { %>
        <p style="color:var(--text-muted); font-style:italic; text-align:center; padding:60px 20px;">
            Soyez le premier à laisser un commentaire sur cet événement terminé !
        </p>
        <% } else {
            for (EventComment c : comments) { %>
        <div class="comment">
            <div class="comment-header">
                <strong><%= c.getUsername() != null ? c.getUsername() : "Participant" %></strong>
                <span class="rating"><%= "★".repeat(Math.min(5, c.getRating())) %></span>
            </div>
            <p><%= c.getComment() %></p>
        </div>
        <% } } %>

        <% if (user != null) { %>
        <div style="margin-top:40px; padding-top:30px; border-top:1px solid var(--card-border);">
            <h3 style="color:var(--white);">Ajouter votre commentaire</h3>
            <form action="AddCommentServlet" method="post">
                <input type="hidden" name="eventId" value="<%= event.getIdEvent() %>">
                <textarea name="comment" placeholder="Que pensez-vous de cet événement ?" required></textarea>
                <select name="rating" required>
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
    <!-- Registration section remains the same -->
    <% if (user != null && !"admin".equals(user.getRole())) { %>
    <div class="registration-box">
        <h2 style="color: var(--white);">S'inscrire à cet événement</h2>
        <form action="RegisterEventServlet" method="post">
            <input type="hidden" name="eventId" value="<%= event.getIdEvent() %>">
            <textarea name="motivation" placeholder="Pourquoi voulez-vous participer ? (facultatif)"
                      style="width:100%; height:110px; background:var(--navy-3); border:1px solid var(--card-border); border-radius:var(--radius-md); padding:18px; color:var(--text-main);"></textarea>
            <button type="submit">Confirmer mon inscription</button>
        </form>
    </div>
    <% } %>
    <% } %>
</div>

<script src="js/script.js"></script>
</body>
</html>
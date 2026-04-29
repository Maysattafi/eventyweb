<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.models.EventComment" %>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="org.example.dao.EventCommentDAO" %>
<%@ page import="java.util.List" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    EventDAO eventDAO = new EventDAO();
    List<Event> endedEvents = eventDAO.getEndedEvents();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>history - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .events-container {
            max-width: 1200px;
            margin: 80px auto;
            padding: 0 48px;
        }
        .page-title {
            font-family: 'Syne', sans-serif;
            font-size: 38px;
            font-weight: 700;
            color: var(--white);
            text-align: center;
            margin-bottom: 20px;
            letter-spacing: -1px;
        }
        .section-subtitle {
            text-align: center;
            color: var(--text-muted);
            font-size: 17px;
            margin-bottom: 60px;
        }

        /* Grid Layout for many events */
        .ended-events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 28px;
        }

        .ended-event-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-lg);
            padding: 32px;
            transition: var(--transition);
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .ended-event-card:hover {
            transform: translateY(-6px);
            border-color: var(--blue-light);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        }

        .ended-badge {
            display: inline-block;
            background: #ef4444;
            color: white;
            font-size: 12px;
            font-weight: 700;
            padding: 6px 18px;
            border-radius: 50px;
            margin-bottom: 16px;
            align-self: flex-start;
        }

        .event-title {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--white);
            line-height: 1.3;
            margin-bottom: 12px;
        }

        .event-meta {
            color: var(--text-muted);
            font-size: 15px;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .description {
            color: var(--text-main);
            line-height: 1.7;
            margin-bottom: 25px;
            flex-grow: 1;
        }

        /* Compact Comments */
        .comments-preview {
            background: var(--navy-3);
            border-radius: var(--radius-md);
            padding: 18px;
            margin-top: auto;
            border-left: 4px solid var(--blue-light);
        }
        .comment {
            background: var(--card-bg);
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 10px;
            font-size: 14.5px;
            line-height: 1.5;
            color: var(--text-muted);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .more-comments {
            color: var(--blue-light);
            font-size: 14px;
            cursor: pointer;
        }

        .action-btn {
            margin-top: 20px;
            display: inline-block;
            width: 100%;
            padding: 14px;
            background: var(--blue);
            color: white;
            text-align: center;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }
        .action-btn:hover {
            background: var(--blue-light);
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 120px 40px;
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="index.jsp" class="logo">
            <span class="logo-dot"></span>
            Eventy
        </a>
        <ul class="nav-links">
            <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a href="evenementsTermines.jsp" class="nav-link active">history</a></li>
            <li><a href="events.jsp" class="nav-link">Événements</a></li>

        </ul>
        <a href="<%= user != null ? "logout" : "login.jsp" %>" class="btn-nav">
            <%= user != null ? "Déconnexion" : "Connexion" %>
        </a>
    </div>
</nav>

<div class="events-container">
    <h1 class="page-title">Événements Terminés</h1>
    <p class="section-subtitle">Découvrez les retours et commentaires des participants sur les événements passés</p>

    <% if (endedEvents != null && !endedEvents.isEmpty()) { %>
    <div class="ended-events-grid">
        <% for (Event e : endedEvents) {
            EventCommentDAO commentDAO = new EventCommentDAO();
            List<EventComment> comments = commentDAO.getCommentsByEvent(e.getIdEvent().intValue());
        %>
        <div class="ended-event-card">
            <span class="ended-badge">TERMINÉ</span>

            <h2 class="event-title"><%= e.getTitre() %></h2>

            <div class="event-meta">
                📅 <%= e.getDateEvent() %><br>
                📍 <%= e.getnSale() %>
            </div>

            <p class="description">
                <%= e.getDescription() != null && e.getDescription().length() > 160
                        ? e.getDescription().substring(0, 160) + "..."
                        : (e.getDescription() != null ? e.getDescription() : "") %>
            </p>

            <!-- Compact Comments Preview -->
            <div class="comments-preview">
                <strong style="color: var(--blue-light);">💬 Commentaires des participants</strong>

                <% if (comments != null && !comments.isEmpty()) {
                    int displayCount = Math.min(2, comments.size());
                    for (int i = 0; i < displayCount; i++) {
                        EventComment c = comments.get(i);
                %>
                <div class="comment">
                    <strong><%= c.getUsername() != null ? c.getUsername() : "Participant" %> :</strong>
                    <%= c.getComment().length() > 110 ? c.getComment().substring(0, 110) + "..." : c.getComment() %>
                </div>
                <% } %>

                <% if (comments.size() > 2) { %>
                <span class="more-comments">+ <%= comments.size() - 2 %> autres commentaires</span>
                <% } %>

                <% } else { %>
                <p style="color: var(--text-muted); font-style: italic; margin: 12px 0 0 0;">
                    Aucun commentaire pour le moment.
                </p>
                <% } %>
            </div>

            <!-- Action Button -->
            <% if (user != null) { %>
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="action-btn">
                laisser un commentaire
            </a>
            <% } else { %>
            <a href="login.jsp" class="action-btn" style="background: var(--navy-3); color: var(--blue-light);">
                Connectez-vous pour commenter
            </a>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-state">
        <h3>Aucun événement terminé pour le moment</h3>
        <p>Les événements terminés et les retours des participants apparaîtront ici.</p>
    </div>
    <% } %>
</div>

<script src="js/script.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="java.util.List" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    EventDAO eventDAO = new EventDAO();
    List<Event> upcomingEvents = eventDAO.getRecentEvents(9);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Étudiant - Eventy</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .student-header {
            background: linear-gradient(135deg, #2563eb, #1e40af);
            color: white;
            padding: 25px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }
        .welcome {
            font-size: 26px;
            font-weight: 700;
        }
        .header-buttons {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .btn-rounded {
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-ended {
            background: rgba(255,255,255,0.25);
            color: white;
            border: 2px solid rgba(255,255,255,0.4);
        }
        .btn-ended:hover {
            background: rgba(255,255,255,0.35);
        }
        .btn-logout {
            background: #ef4444;
            color: white;
        }
        .btn-logout:hover {
            background: #dc2626;
        }

        .action-bar {
            background: #f8fafc;
            padding: 25px 40px;
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .action-btn {
            background: white;
            color: #1e40af;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }
        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(37, 99, 235, 0.25);
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 28px;
            padding: 40px;
        }
        .event-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .event-card:hover {
            transform: translateY(-10px);
        }
        .event-card h3 {
            padding: 20px 20px 8px;
            margin: 0;
            color: #1e3a8a;
        }
        .event-date {
            padding: 0 20px;
            color: #3b82f6;
            font-weight: 600;
        }
        .event-card p {
            padding: 12px 20px 25px;
            margin: 0;
            color: #64748b;
        }
        .btn-view {
            display: block;
            width: 85%;
            margin: 0 auto 25px;
            padding: 14px;
            background: linear-gradient(135deg, #3b82f6, #60a5fa);
            color: white;
            text-align: center;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-view:hover {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
        }
    </style>
</head>
<body>

<!-- Blue Header -->
<div class="student-header">
    <div class="welcome">👋 Bienvenue, <%= user.getName() %> !</div>

    <div class="header-buttons">
        <a href="logout" class="btn-rounded btn-logout">
            Déconnexion
        </a>
    </div>
</div>

<!-- Action Buttons Bar -->
<div class="action-bar">
    <a href="#upcoming" class="action-btn">
        📆 Événements à venir
    </a>
    <a href="EventServlet?action=ended" class="action-btn">
        📅 Événements Terminés
    </a>
</div>

<div class="container" style="max-width: 1300px; margin: 0 auto;">
    <h2 style="text-align: center; color: #1e3a8a; margin: 40px 0 30px;">Événements Populaires</h2>

    <div class="events-grid">
        <% if (upcomingEvents != null && !upcomingEvents.isEmpty()) {
            for (Event e : upcomingEvents) { %>
        <div class="event-card">
            <h3><%= e.getTitre() %></h3>
            <p class="event-date">📅 <%= e.getDateEvent() %></p>
            <p><strong>Lieu :</strong> <%= e.getnSale() %></p>
            <p><%= e.getDescription() != null && e.getDescription().length() > 120
                    ? e.getDescription().substring(0, 120) + "..."
                    : (e.getDescription() != null ? e.getDescription() : "") %></p>
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="btn-view">Voir détails & S'inscrire</a>
        </div>
        <% }
        } else { %>
        <p style="grid-column: 1 / -1; text-align: center; color: #64748b; font-size: 18px; padding: 80px 20px;">
            Aucun événement disponible pour le moment.
        </p>
        <% } %>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
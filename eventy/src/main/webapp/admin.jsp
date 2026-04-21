<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="java.util.List" %>

<%
    Users admin = (Users) session.getAttribute("loggedUser");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    EventDAO eventDAO = new EventDAO();
    List<Event> recentEvents = eventDAO.getRecentEvents(9);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Administrateur - Eventy</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .navbar {
            background: #1e40af;
            padding: 18px 40px;
            color: white;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .navbar .logo { font-size: 24px; font-weight: 700; margin-right: 60px; }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 35px;
            font-weight: 600;
            font-size: 17px;
        }
        .navbar a:hover { color: #93c5fd; }
        .logout {
            margin-left: auto;
            background: #ef4444;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 25px;
        }
        .event-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .event-card:hover { transform: translateY(-8px); }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo">Eventy</div>
    <a href="admin">Accueil</a>
    <a href="admin?action=users">Utilisateurs</a>
    <a href="admin?action=events">Événements</a>
    <a href="ajouterEvenement.jsp">Ajouter un Événement</a>
    <a href="EventServlet?action=ended">Événements Terminés</a>
    <a href="logout" class="logout">Déconnexion</a>
</div>

<div class="container" style="max-width:1300px; margin:50px auto; padding:0 20px;">
    <h2 style="text-align:center; color:#1e3a8a;">Événements Populaires</h2>

    <div class="events-grid">
        <% if (recentEvents != null && !recentEvents.isEmpty()) {
            for (Event e : recentEvents) { %>
        <div class="event-card">
            <h3><%= e.getTitre() %></h3>
            <p class="date" style="color:#3b82f6; font-weight:600;"><%= e.getDateEvent() %></p>
            <p><strong>Lieu :</strong> <%= e.getnSale() %></p>
            <p><%= e.getDescription() != null && e.getDescription().length() > 110
                    ? e.getDescription().substring(0, 110) + "..."
                    : e.getDescription() %></p>
        </div>
        <% }
        } else { %>
        <p style="text-align:center; grid-column:1/-1; color:#64748b; font-size:18px;">
            Aucun événement disponible pour le moment.
        </p>
        <% } %>
    </div>
</div>

</body>
</html>
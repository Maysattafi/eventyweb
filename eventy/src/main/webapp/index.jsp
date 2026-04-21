<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="java.util.List" %>

<%
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getRecentEvents(9);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventy - Événements Universitaires</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            color: white;
            padding: 120px 20px 100px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .hero h1 {
            font-size: 52px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 22px;
            max-width: 700px;
            margin: 0 auto 40px;
            opacity: 0.95;
        }
        .cta-button {
            background: white;
            color: #1e40af;
            padding: 16px 40px;
            border-radius: 50px;
            font-size: 18px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .cta-button:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
        }

        .section-title {
            text-align: center;
            color: #1e3a8a;
            font-size: 32px;
            margin: 70px 0 40px;
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 28px;
            padding: 0 20px;
        }

        .event-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            transition: all 0.3s ease;
        }
        .event-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        .event-card h3 {
            padding: 22px 22px 10px;
            margin: 0;
            color: #1e3a8a;
            font-size: 22px;
        }
        .event-date {
            padding: 0 22px;
            color: #3b82f6;
            font-weight: 600;
            font-size: 15px;
        }
        .event-card p {
            padding: 12px 22px 25px;
            margin: 0;
            color: #64748b;
            line-height: 1.6;
        }
        .btn-view {
            display: block;
            width: 85%;
            margin: 0 auto 28px;
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

        .nav-link {
            color: #1e40af;
            text-decoration: none;
            font-weight: 500;
            margin: 0 18px;
        }
        .nav-link:hover {
            color: #3b82f6;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav>
    <div class="logo">Eventy</div>
    <ul>
        <li><a href="index.jsp" class="nav-link">Accueil</a></li>
        <li><a href="evenementsTermines.jsp" class="nav-link">history</a></li>
    </ul>
    <div>
        <a href="login.jsp" class="btn">Connexion</a>
        <a href="signup.jsp" class="btn" style="margin-left: 12px; background: #22c55e;">Inscription</a>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <h1>Découvrez les meilleurs événements universitaires</h1>
    <p>Participez à des conférences, ateliers, formations et moments inoubliables avec vos camarades.</p>
    <a href="events.jsp" class="cta-button">Voir les événements à venir →</a>
</section>

<!-- Events Section -->
<section id="events">
    <h2 class="section-title">Événements Populaires</h2>

    <div class="events-grid">
        <% if (events != null && !events.isEmpty()) {
            for (Event e : events) { %>
        <div class="event-card">
            <h3><%= e.getTitre() %></h3>
            <p class="event-date">📅 <%= e.getDateEvent() %></p>
            <p><strong>Lieu :</strong> <%= e.getnSale() %></p>
            <p><%= e.getDescription() != null && e.getDescription().length() > 135
                    ? e.getDescription().substring(0, 135) + "..."
                    : (e.getDescription() != null ? e.getDescription() : "") %></p>
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="btn-view">Voir détails & S'inscrire</a>
        </div>
        <% }
        } else { %>
        <p style="grid-column: 1 / -1; text-align: center; color: #64748b; font-size: 19px; padding: 80px 20px;">
            Aucun événement disponible pour le moment.<br>
            <small>Revenez bientôt !</small>
        </p>
        <% } %>
    </div>
</section>

<script src="js/script.js"></script>
</body>
</html>
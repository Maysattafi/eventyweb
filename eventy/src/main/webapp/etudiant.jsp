<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="java.util.List" %>
<%
    EventDAO eventDAO = new EventDAO();
    List<Event> event = eventDAO.getAllEvents();
%>
<%
    Users user = (Users) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Event> upcomingEvents = eventDAO.getRecentEvents(9);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventy – Découvrez l'Institut</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="index.jsp" class="logo">
            <span class="logo-dot"></span>
            Eventy
        </a>
        <ul class="nav-links">
            <li><a href="index.jsp" class="nav-link active">Accueil</a></li>
            <li><a href="evenementsTermines.jsp" class="nav-link ">historique</a></li>
            <li><a href="events.jsp" class="nav-link">Événements</a></li>
        </ul>
        <div class="header-buttons">
            <a href="logout" class="btn-nav">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                Déconnexion
            </a>
        </div>
    </div>
</nav>

<!-- ALL EVENTS LIST - DYNAMIC -->
<section class="list-section">
    <div class="section-header">
        <div class="section-label">Agenda complet</div>
        <h2 class="section-title">Tous les événements</h2>
    </div>

    <div class="events-carousel" id="carouselTrack">
        <% if (event != null && !event.isEmpty()) {
            int cardIndex = 1;
            for (Event e : event) {
                String cardClass = (cardIndex % 4 == 1) ? "card-blue" :
                        (cardIndex % 4 == 2) ? "card-coral" :
                                (cardIndex % 4 == 3) ? "card-teal" : "card-purple";
                cardIndex++;
        %>
        <article class="event-card <%= cardClass %>">
            <div class="card-top">
                <div class="card-category">
                    <%= e.getCategory() != null && !e.getCategory().trim().isEmpty()
                            ? e.getCategory()
                            : "Événement" %>
                </div>
                <div class="card-bookmark">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"/></svg>
                </div>
            </div>
            <div class="card-icon-wrap">📅</div>
            <h3 class="card-title"><%= e.getTitre() %></h3>
            <p class="card-desc">
                <%= e.getDescription() != null && e.getDescription().length() > 110
                        ? e.getDescription().substring(0, 110) + "..."
                        : e.getDescription() %>
            </p>
            <div class="card-meta">
                        <span class="card-date">
                            <%= e.getDateEvent() %>
                        </span>
            </div>
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="card-btn">Voir détails</a>
        </article>
        <%
            }
        } else { %>
        <p style="grid-column: 1 / -1; text-align: center; padding: 80px 20px; color: #8892a4; font-size: 18px;">
            Aucun événement à venir pour le moment.
        </p>
        <% } %>
    </div>
</section>
<!-- FOOTER -->
<footer class="footer">
    <div class="footer-inner">
        <div class="footer-brand">
                <span class="logo">
                    <span class="logo-dot"></span>Eventy
                </span>
            <p>La plateforme officielle des événements de l'Institut.</p>
        </div>
        <div class="footer-links">
            <a href="index.jsp">Accueil</a>
            <a href="events.jsp">Événements</a>
            <a href="login.jsp">Connexion</a>
        </div>
        <p class="footer-copy">© 2026 Eventy. Tous droits réservés.</p>
    </div>
</footer>

<script src="js/script.js"></script>
</body>
</html>
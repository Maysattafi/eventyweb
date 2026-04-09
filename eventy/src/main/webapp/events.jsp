<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="org.example.models.Event"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Événements - Eventy</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav>
    <div class="logo">Eventy</div>
    <ul>
        <li><a href="index.jsp">Accueil</a></li>
        <li><a href="events">Événements</a></li>
    </ul>
    <a href="login.jsp" class="btn">Connexion</a>
</nav>

<section class="events">
    <h2>Tous les événements</h2>

    <div class="event-container">
        <%
            List<Event> events = (List<Event>) request.getAttribute("events");
            if (events != null && !events.isEmpty()) {
                for (Event e : events) {
        %>
        <div class="event-card">
            <h3><%= e.getTitre() %></h3>
            <p><%= e.getDate() %></p>
            <a href="events?id=<%= e.getId() %>" class="btn">Voir détails</a>
        </div>
        <%
            }
        } else {
        %>
        <p style="grid-column: 1 / -1; text-align:center; padding:40px;">
            Aucun événement disponible pour le moment.
        </p>
        <%
            }
        %>
    </div>
</section>

<script src="js/script.js"></script>
</body>
</html>
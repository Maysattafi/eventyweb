<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Event" %>
<%@ page import="java.util.List" %>

<%
    List<Event> results = (List<Event>) request.getAttribute("searchResults");
    String query = (String) request.getAttribute("searchQuery");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Eventy – Découvrez l'Institut</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
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
        <a href="login.jsp" class="btn-nav">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            Connexion
        </a>
    </div>
</nav>

<div class="search-results-page">
    <div class="section-header">
        <h2>Résultats pour "<%= query != null ? query : "" %>"</h2>
        <% if (selectedCategory != null && !"all".equals(selectedCategory)) { %>
        <br>
        <p>Catégorie : <%= selectedCategory %></p>
        <% } %>
    </div>

    <div class="events-list">
        <%

            if (results != null && !results.isEmpty()) {
                for (Event e : results) {
                    // === DATE PARSING (same logic as in index.jsp) ===
                    String dateStr = e.getDateEvent();
                    String day = "";
                    String month = "";
                    try {
                        if (dateStr != null && dateStr.length() >= 10) {
                            day = dateStr.substring(8, 10);           // Day (e.g. "12")
                            String monthNum = dateStr.substring(5, 7); // Month number (e.g. "05")
                            String[] months = {"JAN", "FEV", "MAR", "AVR", "MAI", "JUI", "JUI", "AOU", "SEP", "OCT", "NOV", "DEC"};
                            month = months[Integer.parseInt(monthNum) - 1];
                        }
                    } catch (Exception ex) {
                        day = "??";
                        month = "???";
                    }
        %>
        <div class="list-item">
            <div class="list-date-box">
                <span class="list-day"><%= day %></span>
                <span class="list-month"><%= month %></span>
            </div>
            <div class="list-info">
                <h4><%= e.getTitre() %></h4>
                <p><%= e.getnSale() != null ? e.getnSale() : "Lieu non spécifié" %> · Institut National</p>
            </div>
            <span class="list-tag tag-blue">
                <%= e.getCategory() != null && !e.getCategory().trim().isEmpty()
                        ? e.getCategory()
                        : "Événement" %>
            </span>
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="list-arrow">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
            </a>
        </div>
        <%
            }
        } else {
        %>
        <div class="list-item" style="justify-content: center; padding: 80px 20px;">
            <p style="color: #8892a4; font-size: 18px; text-align: center;">
                Aucun résultat trouvé pour "<%= query != null ? query : "votre recherche" %>".
            </p>
        </div>
        <% } %>
    </div>

    <a href="index.jsp" class="btn-primary">
        Retour à l'accueil <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
    </a>
</div>

<script src="js/script.js"></script>
</body>
</html>
<%!
%>
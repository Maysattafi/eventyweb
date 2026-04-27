<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.example.dao.EventDAO" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="java.util.List" %>

<%
    EventDAO eventDAO = new EventDAO();
    List<Event> popularEvents = eventDAO.getRecentEvents(6); // Get up to 6 upcoming events
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

<!-- NAVBAR -->
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

<!-- HERO -->
<section class="hero">
    <div class="hero-bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
    </div>
    <div class="hero-inner">
        <h1 class="hero-title">
            Découvrez les<br>
            <em>événements</em> de<br>
            l'Institut
        </h1>
        <p class="hero-sub">
            Conférences, ateliers et activités étudiantes — tout au même endroit.
        </p>
        <div class="hero-actions">
            <a href="events.jsp" class="btn-primary">
                Explorer les événements
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
            </a>
            <a href="evenementsTermines.jsp" class="btn-ghost">Voir l'history</a>
        </div>
    </div>
    <div class="hero-visual">
        <div class="floating-card fc-1">
            <div class="fc-icon">🎓</div>
            <div>
                <p class="fc-title">Conférence Tech</p>
            </div>
        </div>
        <div class="floating-card fc-2">
            <div class="fc-icon">⚡</div>
            <div>
                <p class="fc-title">Hackathon</p>
            </div>
        </div>
        <div class="floating-card fc-3">
            <div class="fc-icon">🤖</div>
            <div>
                <p class="fc-title">Workshop IA</p>
            </div>
        </div>
        <div class="hero-circle-graphic">
            <div class="circle-ring r1"></div>
            <div class="circle-ring r2"></div>
            <div class="circle-ring r3"></div>
            <div class="circle-center">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M8 6h13"/><path d="M8 12h13"/><path d="M8 18h13"/><path d="M3 6h.01"/><path d="M3 12h.01"/><path d="M3 18h.01"/></svg>
            </div>
        </div>
    </div>
</section>

<!-- SEARCH BAR -->
<!-- SEARCH BAR - FULLY FUNCTIONAL & DYNAMIC -->
<section class="search-section">
    <div class="search-wrap">
        <!-- Search Form -->
        <form action="EventServlet" method="get" class="search-box" id="searchForm">
            <input type="hidden" name="action" value="search">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
            <input type="text" name="query" id="searchInput" placeholder="Rechercher un événement, une conférence…" />
            <input type="hidden" name="category" id="categoryInput" value="">
            <button type="submit" class="search-btn">Rechercher</button>
        </form>

        <!-- Dynamic Categories from Database -->
        <div class="search-tags" id="categoryTags">
            <span class="tag active" onclick="filterByCategory('all')">Tous</span>

            <%
                EventDAO event1DAO = new EventDAO();
                List<String> categories = event1DAO.getAllCategories();

                for (String cat : categories) {
                    if (cat != null && !cat.trim().isEmpty()) {
            %>
            <span class="tag" onclick="filterByCategory('<%= cat %>')">
                    <%= cat %>
                </span>
            <%
                    }
                }
            %>
        </div>
    </div>
</section>

<!-- POPULAR EVENTS - DYNAMIC -->
<section class="events-section" id="popular">
    <div class="section-header">
        <div class="section-label">À la une</div>
        <h2 class="section-title">Événements populaires</h2>
        <a href="events.jsp" class="section-link">
            Tout voir
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
        </a>
    </div>

    <div class="events-carousel" id="carouselTrack">
        <% if (popularEvents != null && !popularEvents.isEmpty()) {
            int cardIndex = 1;
            for (Event e : popularEvents) {
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
            <a href="EventServlet?id=<%= e.getIdEvent() %>" class="card-btn">Voir plus</a>
        </article>
        <%
            }
        } else { %>
        <p style="grid-column: 1 / -1; text-align: center; padding: 80px 20px; color: #8892a4; font-size: 18px;">
            Aucun événement à venir pour le moment.
        </p>
        <% } %>
    </div>

    <div class="carousel-controls">
        <button class="ctrl-btn" id="prevBtn" onclick="scrollCarousel(-1)" aria-label="Précédent">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
        </button>
        <button class="ctrl-btn" id="nextBtn" onclick="scrollCarousel(1)" aria-label="Suivant">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg>
        </button>
    </div>
</section>
<!-- ALL EVENTS LIST - DYNAMIC -->
<section class="list-section">
    <div class="section-header">
        <div class="section-label">Agenda complet</div>
        <h2 class="section-title">Tous les événements</h2>
    </div>

    <div class="events-list">
        <%
            EventDAO event2DAO = new EventDAO();
            List<Event> allEvents = event2DAO.getRecentEvents(10);   // Get all events (or getRecentEvents(10) if you prefer limited)

            if (allEvents != null && !allEvents.isEmpty()) {
                for (Event e : allEvents) {
                    // Extract day and month from date_event (assuming format: "2026-05-12 09:00")
                    String dateStr = e.getDateEvent();
                    String day = "";
                    String month = "";
                    try {
                        if (dateStr != null && dateStr.length() >= 10) {
                            day = dateStr.substring(8, 10);           // Day
                            String monthNum = dateStr.substring(5, 7); // Month number
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
                <p><%= e.getnSale() %> · Institut National</p>
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
        <div class="list-item" style="justify-content: center; padding: 60px 20px;">
            <p style="color: #8892a4; font-size: 18px;">Aucun événement trouvé pour le moment.</p>
        </div>
        <% } %>
    </div>

    <div class="list-cta">
        <a href="EventServlet" class="btn-primary">
            Voir tous les événements
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
        </a>
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
            <a href="events">Événements</a>
            <a href="login.jsp">Connexion</a>
        </div>
        <p class="footer-copy">© 2026 Eventy. Tous droits réservés.</p>
    </div>
</footer>
<!-- Keep the rest of your original code (list-section, footer, script, etc.) unchanged -->
<!-- ALL EVENTS LIST, FOOTER, etc. -->

<script src="js/script.js"></script>
</body>
</html>
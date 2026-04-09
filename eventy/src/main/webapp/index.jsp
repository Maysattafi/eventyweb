<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventy - Accueil</title>
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

<header class="hero">
    <h1>Découvrez les événements de l'Institut</h1>
    <p>Conférences, ateliers et activités étudiantes</p>
    <a href="events" class="btn">Voir les événements</a>
</header>

<section class="events">
    <h2>Événements populaires</h2>
    <div class="event-container">
        <div class="event-card">
            <h3>Workshop IA</h3>
            <p>12 Mai 2026</p>
        </div>
        <div class="event-card">
            <h3>Hackathon</h3>
            <p>18 Juin 2026</p>
        </div>
        <div class="event-card">
            <h3>Conférence Tech</h3>
            <p>22 Juin 2026</p>
        </div>
    </div>
    <a href="events" class="btn more">Voir plus</a>
</section>

<script src="js/script.js"></script>
</body>
</html>
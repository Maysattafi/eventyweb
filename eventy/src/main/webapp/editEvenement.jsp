<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>

<%
    Users admin = (Users) session.getAttribute("loggedUser");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Event event = (Event) request.getAttribute("event");
    if (event == null) {
        response.sendRedirect("admin?action=events");
        return;
    }

    // Format date for datetime-local input (yyyy-MM-dd'T'HH:mm)
    String formattedDate = "";
    try {
        if (event.getDateEvent() != null) {
            String raw = event.getDateEvent();
            // Handle both "2026-04-25" and "2026-04-25 14:30:00"
            if (raw.length() >= 16) {
                formattedDate = raw.substring(0, 16);           // "2026-04-25 14:30"
            } else if (raw.length() >= 10) {
                formattedDate = raw.substring(0, 10) + "T00:00"; // "2026-04-25T00:00"
            }
        }
    } catch (Exception e) {
        formattedDate = "";
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Événement - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-card {
            max-width: 800px;
            margin: 80px auto;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-lg);
            padding: 50px;
        }
        label {
            display: block;
            color: var(--blue-light);
            font-weight: 600;
            margin-bottom: 8px;
        }
        input, textarea {
            width: 100%;
            padding: 16px;
            background: var(--navy-3);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-md);
            color: var(--text-main);
            margin-bottom: 20px;
        }
        button {
            width: 100%;
            padding: 16px;
            background: var(--blue);
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>

<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="admin" class="logo"><span class="logo-dot"></span> Eventy</a>
        <ul class="nav-links">
            <li><a href="admin" class="nav-link">Accueil</a></li>
            <li><a href="admin?action=users" class="nav-link">Utilisateurs</a></li>
            <li><a href="admin?action=events" class="nav-link">Événements</a></li>
        </ul>
        <a href="logout" class="btn-nav">Déconnexion</a>
    </div>
</nav>

<div class="form-card">
    <h2 style="color:var(--white); text-align:center; margin-bottom:40px;">Modifier l'Événement</h2>

    <form action="UpdateEventServlet" method="post">
        <input type="hidden" name="id" value="<%= event.getIdEvent() %>">

        <label>Titre de l'événement</label>
        <input type="text" name="titre" value="<%= event.getTitre() %>" required>

        <label>Description</label>
        <textarea name="description" rows="6" required><%= event.getDescription() != null ? event.getDescription() : "" %></textarea>

        <label>Date de l'événement</label>
        <input type="datetime-local" name="date_event" value="<%= formattedDate %>" required>

        <label>Salle / Lieu</label>
        <input type="text" name="n_sale" value="<%= event.getnSale() %>" required>

        <label>Image (laisser vide pour garder l'ancienne)</label>
        <input type="text" name="image" value="<%= event.getImage() != null ? event.getImage() : "" %>">

        <button type="submit">Enregistrer les modifications</button>
    </form>
</div>

</body>
</html>
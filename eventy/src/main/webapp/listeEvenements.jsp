<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="java.util.List" %>

<%
    Users admin = (Users) session.getAttribute("loggedUser");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Event> events = (List<Event>) request.getAttribute("events");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Événements - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-container {
            max-width: 1300px;
            margin: 60px auto;
            padding: 0 48px;
        }
        .page-title {
            font-family: 'Syne', sans-serif;
            font-size: 36px;
            font-weight: 700;
            color: var(--white);
            text-align: center;
            margin-bottom: 50px;
            letter-spacing: -1px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-lg);
            overflow: hidden;
        }
        th {
            background: rgba(37, 99, 235, 0.9);
            color: white;
            padding: 20px 18px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.8px;
        }
        td {
            padding: 20px 18px;
            border-bottom: 1px solid var(--card-border);
            color: var(--text-main);
        }
        tr:hover {
            background: var(--navy-3);
        }
        .btn {
            padding: 10px 20px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            margin: 4px;
            transition: var(--transition);
        }
        .btn-view { background: var(--blue); color: white; }
        .btn-inscrits { background: var(--purple); color: white; }
        .btn-edit { background: #eab308; color: #1e3a8a; }
        .btn-delete { background: #ef4444; color: white; }
        .btn-delete:hover { background: #dc2626; }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="admin" class="logo">
            <span class="logo-dot"></span> Eventy
        </a>
        <ul class="nav-links">
            <li><a href="admin" class="nav-link">Accueil</a></li>
            <li><a href="admin?action=users" class="nav-link">Utilisateurs</a></li>
            <li><a href="admin?action=events" class="nav-link active">Événements</a></li>
            <li><a href="ajouterEvenement.jsp" class="nav-link">Ajouter un Événement</a></li>
        </ul>
        <a href="logout" class="btn-nav">Déconnexion</a>
    </div>
</nav>

<div class="admin-container">
    <h2 class="page-title">Liste des Événements</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Titre</th>
            <th>Date</th>
            <th>Lieu</th>
            <th>categorie</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <% if (events != null && !events.isEmpty()) {
            for (Event e : events) { %>
        <tr>
            <td><%= e.getIdEvent() %></td>
            <td><strong><%= e.getTitre() %></strong></td>
            <td><%= e.getDateEvent() %></td>
            <td><%= e.getnSale() %></td>
            <td><%= e.getCategory() %></td>
            <td>
                <%= e.getDescription() != null && e.getDescription().length() > 80
                        ? e.getDescription().substring(0, 80) + "..."
                        : (e.getDescription() != null ? e.getDescription() : "") %>
            </td>
            <td>
                <a href="EventServlet?id=<%= e.getIdEvent() %>" class="btn btn-view">Voir Détails</a>
                <a href="EventServlet?action=registered&eventId=<%= e.getIdEvent() %>"
                   class="btn btn-inscrits">Voir Inscrits</a>
                <a href="EditEventServlet?id=<%= e.getIdEvent() %>" class="btn btn-edit">Modifier</a>
                <a href="DeleteEventServlet?id=<%= e.getIdEvent() %>"
                   class="btn btn-delete"
                   onclick="return confirm('⚠️ Voulez-vous vraiment supprimer cet événement ?\n\nCette action est irréversible et supprimera également toutes les inscriptions et commentaires associés.');">
                    Supprimer
                </a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" style="text-align:center; padding:80px 20px; color:#8892a4;">
                Aucun événement trouvé. Ajoutez un nouvel événement depuis l'espace administrateur.
            </td>
        </tr>
        <% } %>
    </table>
</div>

<script src="js/script.js"></script>
</body>
</html>
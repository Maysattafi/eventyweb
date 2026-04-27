<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="java.util.List" %>

<%
    Users admin = (Users) session.getAttribute("loggedUser");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Users> usersList = (List<Users>) request.getAttribute("usersList");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Utilisateurs - Eventy</title>
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
            padding: 22px 20px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.8px;
        }
        td {
            padding: 22px 20px;
            border-bottom: 1px solid var(--card-border);
            color: var(--text-main);
        }
        tr:hover {
            background: var(--navy-3);
        }
        .role-admin {
            background: #eab308;
            color: #1e3a8a;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
        }
        .role-user {
            background: #22c55e;
            color: white;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- Navbar - Matching index.jsp style -->
<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="admin" class="logo">
            <span class="logo-dot"></span>
            Eventy
        </a>
        <ul class="nav-links">
            <li><a href="admin" class="nav-link ">Accueil</a></li>
            <li><a href="admin?action=users" class="nav-link active">Utilisateurs</a></li>
            <li><a href="admin?action=events" class="nav-link">Événements</a></li>
            <li><a href="ajouterEvenement.jsp" class="nav-link">Ajouter un Événement </a></li>
            <li><a href="evenementsTermines.jsp" class="nav-link ">historique</a></li>
        </ul>
        <a href="logout" class="btn-nav">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            Déconnexion
        </a>
    </div>
</nav>

<div class="admin-container">
    <h2 class="page-title">Liste des Utilisateurs</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Email</th>
            <th>Rôle</th>
        </tr>
        <% if (usersList != null) {
            for (Users u : usersList) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><strong><%= u.getName() %></strong></td>
            <td><%= u.getEmail() %></td>
            <td>
                <% if ("admin".equals(u.getRole())) { %>
                <span class="role-admin">Administrateur</span>
                <% } else { %>
                <span class="role-user">Étudiant</span>
                <% } %>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="4" style="text-align:center; padding:80px 20px; color:#8892a4;">
                Aucun utilisateur trouvé.
            </td>
        </tr>
        <% } %>
    </table>
</div>

<script src="js/script.js"></script>
</body>
</html>
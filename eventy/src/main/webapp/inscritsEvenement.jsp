<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%@ page import="org.example.models.Event" %>
<%@ page import="org.example.models.RegistrationInfo" %>
<%@ page import="java.util.List" %>

<%
    Users admin = (Users) session.getAttribute("loggedUser");
    Event event = (Event) request.getAttribute("event");
    List<RegistrationInfo> registeredStudents = (List<RegistrationInfo>) request.getAttribute("registeredStudents");

    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (event == null) {
        response.sendRedirect("admin?action=events");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscrits - <%= event.getTitre() %> - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 80px auto;
            padding: 0 48px;
        }
        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }
        .page-title {
            font-family: 'Syne', sans-serif;
            font-size: 36px;
            font-weight: 700;
            color: var(--white);
            letter-spacing: -1px;
        }
        .event-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--radius-lg);
            padding: 32px;
            margin-bottom: 40px;
        }
        .event-info {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            font-size: 15px;
            color: var(--text-muted);
        }
        .event-info strong {
            color: var(--blue-light);
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
            padding: 20px 24px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.8px;
            text-align: left;
        }
        td {
            padding: 20px 24px;
            border-bottom: 1px solid var(--card-border);
            color: var(--text-main);
        }
        tr:hover {
            background: var(--navy-3);
        }
        .motivation {
            max-width: 520px;
            line-height: 1.6;
            color: var(--text-muted);
            font-size: 14.5px;
        }
        .no-data {
            text-align: center;
            padding: 80px 40px;
            color: var(--text-muted);
            font-size: 18px;
        }
        .total-count {
            text-align: right;
            margin-top: 20px;
            color: var(--blue-light);
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- Navbar - Consistent with index.jsp -->
<nav class="navbar" id="navbar">
    <div class="nav-inner">
        <a href="admin" class="logo">
            <span class="logo-dot"></span>
            Eventy
        </a>
        <ul class="nav-links">
            <li><a href="admin" class="nav-link ">Accueil</a></li>
            <li><a href="admin?action=users" class="nav-link  ">Utilisateurs</a></li>
            <li><a href="admin?action=events" class="nav-link active">Événements</a></li>
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
    <div class="page-header">
        <h1 class="page-title">Inscrits à l'événement</h1>
    </div>

    <div class="event-card">
        <h2 style="color: var(--white); margin-bottom: 20px; font-family: 'Syne', sans-serif;">
            <%= event.getTitre() %>
        </h2>

        <div class="event-info">
            <div><strong>Date :</strong> <%= event.getDateEvent() %></div>
            <div><strong>Lieu :</strong> <%= event.getnSale() %></div>
        </div>
    </div>

    <% if (registeredStudents != null && !registeredStudents.isEmpty()) { %>
    <table>
        <tr>
            <th>Nom de l'étudiant</th>
            <th>Email</th>
            <th>Date d'inscription</th>
            <th>Motivation / Réponse</th>
        </tr>
        <% for (RegistrationInfo student : registeredStudents) { %>
        <tr>
            <td><strong><%= student.getName() %></strong></td>
            <td><%= student.getEmail() %></td>
            <td><%= student.getRegistrationDate() != null ?
                    student.getRegistrationDate().toString().substring(0, 16) : "N/A" %></td>
            <td class="motivation">
                <%= student.getMotivation() != null && !student.getMotivation().trim().isEmpty()
                        ? student.getMotivation()
                        : "<em>Aucune motivation fournie</em>" %>
            </td>
        </tr>
        <% } %>
    </table>

    <div class="total-count">
        Total inscrits : <strong><%= registeredStudents.size() %></strong> étudiants
    </div>

    <% } else { %>
    <div class="event-card no-data">
        <h3>Aucun étudiant inscrit pour le moment</h3>
        <p>Les étudiants n'ont pas encore commencé à s'inscrire à cet événement.</p>
    </div>
    <% } %>

    <div style="text-align: center; margin-top: 50px;">
        <a href="admin?action=events"
           style="display: inline-block; padding: 14px 32px; background: var(--navy-3); color: var(--blue-light);
                      border: 1px solid var(--card-border); border-radius: 50px; text-decoration: none; font-weight: 500;">
            ← Retour à la liste des événements
        </a>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
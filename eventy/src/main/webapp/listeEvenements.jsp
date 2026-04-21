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
    <title>Liste des Événements - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8fafc;
        }
        /* Navbar */
        .navbar {
            background: #1e40af;
            padding: 18px 40px;
            color: white;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .navbar .logo {
            font-size: 24px;
            font-weight: 700;
            margin-right: 60px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 35px;
            font-weight: 600;
            font-size: 17px;
        }
        .navbar a:hover {
            color: #93c5fd;
        }
        .logout {
            margin-left: auto;
            background: #ef4444;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
        }

        .container {
            max-width: 1300px;
            margin: 50px auto;
            padding: 0 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #1e3a8a;
            font-size: 32px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 18px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #1e40af;
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background: #f8fafc;
        }
        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            margin: 3px;
        }
        .btn-view { background: #3b82f6; color: white; }
        .btn-inscrits { background: #8b5cf6; color: white; }
        .btn:hover { opacity: 0.9; }
    </style>
</head>
<body>

<!-- Your Desired Navbar -->
<div class="navbar">
    <div class="logo">Eventy</div>
    <a href="admin">Accueil</a>
    <a href="admin?action=users">Utilisateurs</a>
    <a href="admin?action=events">Événements</a>
    <a href="ajouterEvenement.jsp">Ajouter un Événement</a>
    <a href="logout" class="logout">Déconnexion</a>
</div>

<div class="container">
    <h2>Liste des Événements</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Titre</th>
            <th>Date</th>
            <th>Lieu</th>
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
            <td>
                <%= e.getDescription() != null && e.getDescription().length() > 80
                        ? e.getDescription().substring(0, 80) + "..."
                        : e.getDescription() %>
            </td>
            <td>
                <a href="EventServlet?id=<%= e.getIdEvent() %>" class="btn btn-view">Voir Détails</a>
                <a href="EventServlet?action=registered&eventId=<%= e.getIdEvent() %>"
                   class="btn btn-inscrits">Voir Inscrits</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" style="text-align:center; padding:60px; color:#64748b;">
                Aucun événement trouvé. Ajoutez un nouvel événement.
            </td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
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
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8fafc;
            margin: 0;
            padding: 0;
        }
        .header {
            background: #1e40af;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        h1 { color: #1e3a8a; margin-bottom: 10px; }
        .event-info {
            background: #f1f5f9;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #1e40af;
            color: white;
        }
        tr:hover {
            background: #f8fafc;
        }
        .motivation {
            max-width: 500px;
            white-space: pre-wrap;
            color: #475569;
        }
        .btn-back {
            background: #64748b;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .no-data {
            text-align: center;
            padding: 50px;
            color: #64748b;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Eventy - Administrateur</h2>
    <a href="admin?action=events" class="btn-back">← Retour aux événements</a>
</div>

<div class="container">
    <div class="card">
        <h1>Inscrits à l'événement</h1>
        <div class="event-info">
            <strong>Événement :</strong> <%= event.getTitre() %><br>
            <strong>Date :</strong> <%= event.getDateEvent() %> |
            <strong>Lieu :</strong> <%= event.getnSale() %>
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

        <p style="margin-top: 20px; color: #64748b;">
            Total inscrits : <strong><%= registeredStudents.size() %></strong> étudiants
        </p>
        <% } else { %>
        <div class="no-data">
            <h3>Aucun étudiant inscrit pour le moment</h3>
            <p>Les étudiants n'ont pas encore commencé à s'inscrire à cet événement.</p>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
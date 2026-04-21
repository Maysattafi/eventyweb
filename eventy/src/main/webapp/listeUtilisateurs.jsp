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
    <title>Liste des Utilisateurs - Admin</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7fc; margin: 0; }
        .header {
            background: #1e40af; color: white; padding: 20px 40px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .container { padding: 30px 40px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #1e40af; color: white; }
        .role-admin { background: #eab308; color: black; padding: 5px 12px; border-radius: 20px; font-size: 14px; }
        .role-user { background: #22c55e; color: white; padding: 5px 12px; border-radius: 20px; font-size: 14px; }
    </style>
</head>
<body>

<div class="header">
    <h2>Liste des Utilisateurs</h2>
    <a href="admin.jsp" style="color:white;">Retour au tableau de bord</a>
</div>

<div class="container">
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
            <td><%= u.getName() %></td>
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
        <tr><td colspan="4" style="text-align:center;">Aucun utilisateur trouvé.</td></tr>
        <% } %>
    </table>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.models.Users" %>
<%
    Users admin = (Users) session.getAttribute("loggedUser");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Événement</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fc; padding: 20px; }
        .form-container { max-width: 700px; margin: 40px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        input, textarea, button { width: 100%; padding: 12px; margin: 10px 0; border-radius: 6px; border: 1px solid #ccc; }
        button { background: #1e40af; color: white; font-size: 16px; cursor: pointer; }
        button:hover { background: #3b82f6; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Ajouter un Nouvel Événement</h2>
    <form action="AddEventServlet" method="post">
        <label>Titre de l'événement</label>
        <input type="text" name="titre" required>

        <label>Description</label>
        <textarea name="description" rows="5" required></textarea>

        <label>Date de l'événement</label>
        <input type="datetime-local" name="date_event" required>

        <label>Salle / Lieu (n_sale)</label>
        <input type="text" name="n_sale" required>

        <label>Image URL (optionnel)</label>
        <input type="text" name="image">

        <button type="submit">Ajouter l'Événement</button>
    </form>
</div>

</body>
</html>

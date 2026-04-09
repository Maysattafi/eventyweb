<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Eventy</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="form-container">
    <h2>Connexion</h2>

    <% if (request.getAttribute("error") != null) { %>
    <p style="color:red; text-align:center; margin-bottom:15px;">
        <%= request.getAttribute("error") %>
    </p>
    <% } %>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email universitaire" required>
        <input type="password" name="password" placeholder="Mot de passe" required>

        <button type="submit">Se connecter</button>
    </form>

    <p>Pas encore de compte ? <a href="signup.jsp">Créer un compte</a></p>
</div>

<script src="js/script.js"></script>
</body>
</html>
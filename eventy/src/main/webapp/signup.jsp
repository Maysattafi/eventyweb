<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Eventy</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="form-container">
    <h2>Inscription Étudiant</h2>

    <form action="signup" method="post">
        <input type="text" name="name" placeholder="Nom" required>
        <input type="email" name="email" placeholder="Email universitaire" required>
        <input type="password" name="password" placeholder="Mot de passe" required>

        <button type="submit">Créer mon compte</button>
    </form>

    <p>Déjà inscrit ? <a href="login.jsp">Se connecter</a></p>
</div>

<script src="js/script.js"></script>
</body>
</html>
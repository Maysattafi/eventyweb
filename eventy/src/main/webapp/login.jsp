<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy-950: #050d1a;
            --navy-900: #0a1628;
            --navy-800: #0d1d36;
            --accent:   #3d8ef5;
            --text-primary: #e8edf5;
            --text-secondary: #8ca0be;
            --text-muted: #4d6480;
            --card-border: rgba(61,142,245,0.15);
        }

        body {
            background-color: var(--navy-950);
            color: var(--text-primary);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        /* Grid lines background */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                    linear-gradient(rgba(61,142,245,0.04) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(61,142,245,0.04) 1px, transparent 1px);
            background-size: 60px 60px;
            mask-image: radial-gradient(ellipse 70% 70% at 50% 40%, black 30%, transparent 100%);
            pointer-events: none;
        }

        /* Glow blob */
        body::after {
            content: '';
            position: fixed;
            width: 500px;
            height: 500px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -60%);
            background: radial-gradient(circle, rgba(61,142,245,0.1) 0%, transparent 70%);
            filter: blur(60px);
            pointer-events: none;
        }

        .login-card {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 430px;
            background: var(--navy-800);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            padding: 44px 40px 38px;
            animation: fadeUp 0.5s ease both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .login-logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 20px;
            background: linear-gradient(90deg, #fff 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: inline-block;
            margin-bottom: 30px;
            text-decoration: none;
        }

        .login-title {
            font-family: 'Syne', sans-serif;
            font-size: 26px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.4px;
            margin-bottom: 6px;
        }

        .login-subtitle {
            font-size: 14px;
            color: var(--text-secondary);
            font-weight: 300;
            margin-bottom: 32px;
        }

        /* ── ALERT MESSAGES ── */
        .alert {
            display: flex;
            align-items: center;
            gap: 10px;
            border-radius: 10px;
            padding: 11px 15px;
            font-size: 13.5px;
            margin-bottom: 22px;
        }
        .alert-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            flex-shrink: 0;
        }
        .alert-success {
            background: rgba(29,158,117,0.1);
            border: 1px solid rgba(29,158,117,0.22);
            color: #5dcaa5;
        }
        .alert-success .alert-dot { background: #5dcaa5; }
        .alert-error {
            background: rgba(226,75,74,0.1);
            border: 1px solid rgba(226,75,74,0.22);
            color: #f09595;
        }
        .alert-error .alert-dot { background: #f09595; }

        /* ── FORM ── */
        .field-group { margin-bottom: 16px; }

        .field-label {
            display: block;
            font-size: 11.5px;
            font-weight: 500;
            color: var(--text-secondary);
            letter-spacing: 0.07em;
            text-transform: uppercase;
            margin-bottom: 7px;
        }

        .field-input {
            width: 100%;
            background: var(--navy-950);
            border: 1px solid rgba(61,142,245,0.18);
            border-radius: 10px;
            color: var(--text-primary);
            font-family: 'DM Sans', sans-serif;
            font-size: 14.5px;
            padding: 12px 16px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .field-input::placeholder { color: var(--text-muted); }
        .field-input:focus {
            border-color: rgba(61,142,245,0.5);
            box-shadow: 0 0 0 3px rgba(61,142,245,0.08);
        }

        .btn-submit {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            background: var(--accent);
            color: #fff;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
        }
        .btn-submit:hover {
            background: #5a9ef7;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(61,142,245,0.28);
        }
        .btn-submit:active { transform: translateY(0); }

        .login-footer {
            margin-top: 22px;
            text-align: center;
            font-size: 13.5px;
            color: var(--text-muted);
        }
        .login-footer a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }
        .login-footer a:hover { text-decoration: underline; }

        @media (max-width: 480px) {
            .login-card { padding: 32px 24px 28px; }
        }
    </style>
</head>
<body>

<div class="login-card">
    <a href="index.jsp" class="login-logo">Eventy</a>

    <h1 class="login-title">Bon retour</h1>
    <p class="login-subtitle">Connectez-vous à votre espace universitaire</p>

    <%
        String success = request.getParameter("success");
        String error = (String) request.getAttribute("error");
        if ("registered".equals(success)) {
    %>
    <div class="alert alert-success">
        <span class="alert-dot"></span>
        Inscription réussie ! Vous pouvez maintenant vous connecter.
    </div>
    <% } %>

    <% if (error != null) { %>
    <div class="alert alert-error">
        <span class="alert-dot"></span>
        <%= error %>
    </div>
    <% } %>

    <form action="login" method="post">
        <div class="field-group">
            <label class="field-label" for="email">Email universitaire</label>
            <input class="field-input" type="email" id="email" name="email" placeholder="vous@univ.tn" required>
        </div>
        <div class="field-group">
            <label class="field-label" for="password">Mot de passe</label>
            <input class="field-input" type="password" id="password" name="password" placeholder="••••••••" required>
        </div>
        <button class="btn-submit" type="submit">Se connecter</button>
    </form>

    <p class="login-footer">
        Pas encore de compte ? <a href="signup.jsp">Créer un compte</a>
    </p>
</div>

<script src="js/script.js"></script>
</body>
</html>

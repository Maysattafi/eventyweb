<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Eventy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy-950: #050d1a;
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

        .signup-card {
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
            .signup-card { padding: 32px 24px 28px; }
        }
    </style>
</head>
<body>

<div class="signup-card">
    <a href="index.jsp" class="login-logo">Eventy</a>

    <h1 class="login-title">Inscription Étudiant</h1>
    <p class="login-subtitle">Créez votre espace universitaire</p>

    <form action="signup" method="post">
        <div class="field-group">
            <label class="field-label" for="name">Nom</label>
            <input class="field-input" type="text" id="name" name="name" placeholder="Votre nom complet" required>
        </div>
        <div class="field-group">
            <label class="field-label" for="email">Email universitaire</label>
            <input class="field-input" type="email" id="email" name="email" placeholder="vous@univ.tn" required>
        </div>
        <div class="field-group">
            <label class="field-label" for="password">Mot de passe</label>
            <input class="field-input" type="password" id="password" name="password" placeholder="••••••••" required>
        </div>
        <button class="btn-submit" type="submit">Créer mon compte</button>
    </form>

    <p class="login-footer">
        Déjà inscrit ? <a href="login.jsp">Se connecter</a>
    </p>
</div>

<script src="js/script.js"></script>
</body>
</html>

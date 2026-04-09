package org.example.controller;

import org.example.dao.UserDAO;
import org.example.models.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class RegisterServlet extends HttpServlet {

    private final UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== REGISTRATION ATTEMPT ===");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);

        Users newUser = new Users(name, email, password);

        boolean success = dao.register(newUser);

        response.setContentType("text/html;charset=UTF-8");

        if (success) {
            System.out.println("✅ Registration SUCCESS");
            response.getWriter().println("<h2 style='color:green; text-align:center; margin-top:50px;'>✅ Compte créé avec succès !</h2>");
            response.getWriter().println("<p style='text-align:center;'>Bienvenue <strong>" + name + "</strong></p>");
            response.getWriter().println("<p style='text-align:center;'><a href='login.jsp' class='btn'>Se connecter maintenant</a></p>");
        } else {
            System.out.println("❌ Registration FAILED");
            response.getWriter().println("<h2 style='color:red; text-align:center; margin-top:50px;'>❌ Échec de l'inscription</h2>");
            response.getWriter().println("<p style='text-align:center;'>Vérifiez que l'email n'est pas déjà utilisé ou que la base de données est accessible.</p>");
            response.getWriter().println("<p style='text-align:center;'><a href='signup.jsp' class='btn'>Réessayer</a></p>");
        }
    }
}
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

        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            response.sendRedirect("signup.jsp?error=missing_fields");
            return;
        }

        Users newUser = new Users(name.trim(), email.trim(), password.trim());

        boolean success = dao.register(newUser);

        if (success) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("signup.jsp?error=failed");
        }
    }
}
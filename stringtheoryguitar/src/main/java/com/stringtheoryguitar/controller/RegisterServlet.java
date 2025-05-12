package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.util.DBUtil;
import com.stringtheoryguitar.util.PasswordUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String errorMessage = null;
        boolean registrationSuccess = false;

        // Basic Input Validation
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {
            errorMessage = "All fields are required.";
        } else if (username.length() < 3) { errorMessage = "Username must be at least 3 characters long.";
        } else if (!EMAIL_PATTERN.matcher(email).matches()) { errorMessage = "Please enter a valid email address.";
        } else if (password.length() < 8) { errorMessage = "Password must be at least 8 characters long.";
        } else if (!password.equals(confirmPassword)) { errorMessage = "Passwords do not match.";
        } else if (usernameExists(username)) { errorMessage = "Username already exists.";
        } else if (emailExists(email)) { errorMessage = "Email address is already registered.";
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = DBUtil.getConnection();
                String hashedPassword = PasswordUtil.hashPassword(password);
                String sql = "INSERT INTO users (username, email, full_name, password, role) VALUES (?, ?, ?, ?, 'customer')";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username.trim());
                ps.setString(2, email.trim().toLowerCase());
                ps.setString(3, fullName.trim());
                ps.setString(4, hashedPassword);

                registrationSuccess = ps.executeUpdate() > 0;
                 if (!registrationSuccess) errorMessage = "Registration failed (server issue).";

            } catch (SQLException e) {
                 if (e.getSQLState().startsWith("23")) {
                     errorMessage = e.getMessage().toLowerCase().contains("email") ? "Email already registered." : "Username already exists.";
                 } else { errorMessage = "Database error during registration."; }
                e.printStackTrace();
            } catch (Exception e) {
                errorMessage = "Unexpected error during registration."; e.printStackTrace();
            } finally {
                DBUtil.close(conn, ps);
            }
        }
        if (registrationSuccess) {
             response.sendRedirect(request.getContextPath() + "/login?registration=success");
        } else {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("usernameValue", username);
            request.setAttribute("emailValue", email);
            request.setAttribute("fullNameValue", fullName);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");
            dispatcher.forward(request, response);
        }
    }
    private boolean usernameExists(String username) {
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null; boolean exists = false;
        try { conn = DBUtil.getConnection(); String sql = "SELECT id FROM users WHERE username = ?"; ps = conn.prepareStatement(sql); ps.setString(1, username); rs = ps.executeQuery(); exists = rs.next();
        } catch (SQLException e) { e.printStackTrace(); } finally { DBUtil.close(conn, ps, rs); } return exists;
    }

    private boolean emailExists(String email) {
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null; boolean exists = false;
        if (email == null || email.trim().isEmpty()) return false;
        try { conn = DBUtil.getConnection(); String sql = "SELECT id FROM users WHERE email = ?"; ps = conn.prepareStatement(sql); ps.setString(1, email.trim().toLowerCase()); rs = ps.executeQuery(); exists = rs.next();
        } catch (SQLException e) { e.printStackTrace(); } finally { DBUtil.close(conn, ps, rs); } return exists;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");
        dispatcher.forward(request, response);
    }
}
package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.model.User;
import com.stringtheoryguitar.util.DBUtil;
import com.stringtheoryguitar.util.PasswordUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        String errorMessage = null; User user = null;

        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
             errorMessage = "Username and password are required.";
             request.setAttribute("username", username);
        } else {
            try {
                conn = DBUtil.getConnection();
                String sql = "SELECT id, username, email, full_name, role, password FROM users WHERE username = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");
                    if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
                         int id = rs.getInt("id");
                         String email = rs.getString("email");
                         String fullName = rs.getString("full_name");
                         String role = rs.getString("role");
                         user = new User(id, username, email, fullName, role);
                    } else {
                        errorMessage = "Invalid username or password.";
                        request.setAttribute("username", username);
                    }
                } else {
                    errorMessage = "Invalid username or password.";
                }
            } catch (SQLException e) {
                errorMessage = "Database error during login."; e.printStackTrace();
            } catch (Exception e) {
                 errorMessage = "An unexpected error occurred during login."; e.printStackTrace();
            } finally {
                DBUtil.close(conn, ps, rs);
            }
        }

        if (user != null) { // Login success
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30*60);
            response.sendRedirect(request.getContextPath() + ("admin".equals(user.getRole()) ? "/dashboard" : "/home"));
        } else { // Login failed
            request.setAttribute("errorMessage", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
            dispatcher.forward(request, response);
        }
    }

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
        dispatcher.forward(request, response);
    }
}
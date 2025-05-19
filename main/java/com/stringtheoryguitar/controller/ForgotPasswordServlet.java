package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.util.DBUtil;
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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int EXPIRY_MINUTES = 60;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String infoMessage = null; String errorMessage = null;
        String generatedToken = null; boolean showResetButton = false;
        Connection conn = null; PreparedStatement psFind = null; PreparedStatement psUpdate = null; ResultSet rs = null;

        if (email == null || email.trim().isEmpty()) {
            errorMessage = "Email address cannot be empty.";
        } else {
             email = email.trim().toLowerCase();
            try {
                conn = DBUtil.getConnection();
                String findSql = "SELECT id FROM users WHERE email = ?";
                psFind = conn.prepareStatement(findSql); psFind.setString(1, email); rs = psFind.executeQuery();

                if (rs.next()) { // User found
                    int userId = rs.getInt("id");
                    generatedToken = UUID.randomUUID().toString();
                    Timestamp expiryTimestamp = Timestamp.valueOf(LocalDateTime.now().plusMinutes(EXPIRY_MINUTES));

                    String updateSql = "UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE id = ?";
                    psUpdate = conn.prepareStatement(updateSql); psUpdate.setString(1, generatedToken); psUpdate.setTimestamp(2, expiryTimestamp); psUpdate.setInt(3, userId);

                    if (psUpdate.executeUpdate() > 0) {
                        infoMessage = "Password reset instructions processed. Click the button below to proceed.";
                        showResetButton = true;
                        System.out.println("Password reset token generated for " + email + ": " + generatedToken);
                    } else { errorMessage = "Could not initiate password reset."; }
                } else { // User not found
                    infoMessage = "If an account exists for the provided email, you may proceed with the next step.";
                    showResetButton = false;
                    System.out.println("Password reset requested for non-existent email: " + email);
                }
            } catch (SQLException e) { errorMessage = "Database error during password reset process."; e.printStackTrace();
            } finally { DBUtil.close(rs); DBUtil.close(psFind); DBUtil.close(psUpdate); DBUtil.close(conn); }
        }

        request.setAttribute("infoMessage", infoMessage);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("emailValue", email);
        if (showResetButton && generatedToken != null) {
            request.setAttribute("resetToken", generatedToken);
            request.setAttribute("showResetButton", Boolean.TRUE);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp");
        dispatcher.forward(request, response);
    }
}
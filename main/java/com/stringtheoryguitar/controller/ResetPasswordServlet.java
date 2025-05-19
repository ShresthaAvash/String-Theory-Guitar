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
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        boolean tokenInvalid = (token == null || token.trim().isEmpty());

        if (tokenInvalid) { request.setAttribute("errorMessage", "Invalid or missing password reset link."); }
        request.setAttribute("tokenInvalid", tokenInvalid ? Boolean.TRUE : null);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/reset_password.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String errorMessage = null; boolean passwordResetSuccess = false; boolean tokenInvalid = false;

        if (token == null || token.trim().isEmpty()) { errorMessage = "Invalid/missing reset token."; tokenInvalid = true;
        } else if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) { errorMessage = "Both password fields are required.";
        } else if (newPassword.length() < 8) { errorMessage = "Password must be at least 8 characters long.";
        } else if (!newPassword.equals(confirmPassword)) { errorMessage = "Passwords do not match.";
        } else { // Validation passed
            Connection conn = null; PreparedStatement psFind = null; PreparedStatement psUpdate = null; ResultSet rs = null;
            try {
                conn = DBUtil.getConnection(); conn.setAutoCommit(false);

                String findSql = "SELECT id FROM users WHERE reset_token = ? AND reset_token_expiry > ?";
                psFind = conn.prepareStatement(findSql); psFind.setString(1, token); psFind.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now())); rs = psFind.executeQuery();

                if (rs.next()) { 
                    int userId = rs.getInt("id");
                    String hashedPassword = PasswordUtil.hashPassword(newPassword);

                    String updateSql = "UPDATE users SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE id = ?";
                    psUpdate = conn.prepareStatement(updateSql); psUpdate.setString(1, hashedPassword); psUpdate.setInt(2, userId);

                    if (psUpdate.executeUpdate() > 0) {
                        conn.commit(); passwordResetSuccess = true;
                    } else { conn.rollback(); errorMessage = "Failed to update password. Please try again."; tokenInvalid = true; }
                } else { 
                    conn.rollback(); errorMessage = "Password reset link is invalid or has expired."; tokenInvalid = true;
                }
            } catch (SQLException e) { errorMessage = "Database error during reset."; e.printStackTrace(); try { if (conn != null) conn.rollback(); } catch (SQLException ex) {} tokenInvalid = true;
            } catch (Exception e) { errorMessage = "Unexpected error during reset."; e.printStackTrace(); try { if (conn != null) conn.rollback(); } catch (SQLException ex) {} tokenInvalid = true;
            } finally { try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) {} DBUtil.close(rs); DBUtil.close(psFind); DBUtil.close(psUpdate); DBUtil.close(conn); }
        }

        if (passwordResetSuccess) {
            response.sendRedirect(request.getContextPath() + "/login?reset=success"); 
        } else {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("tokenInvalid", tokenInvalid ? Boolean.TRUE : null);
             if (!tokenInvalid && token != null) { request.setAttribute("token", token); }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/reset_password.jsp");
            dispatcher.forward(request, response); 
        }
    }
}
package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.model.User;
import com.stringtheoryguitar.util.DBUtil;
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
import java.sql.SQLException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=Please+login+to+view+your+profile");
            return;
        }
        if ("admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        request.setAttribute("user", currentUser); // Pass current user to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/profile.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to update your profile.");
            return;
        }
        if ("admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admins cannot use this profile update form.");
            return;
        }

        String newFullName = request.getParameter("fullName");
        String successMessage = null;
        String errorMessage = null;

        if (newFullName == null || newFullName.trim().isEmpty()) {
            errorMessage = "Full Name cannot be empty.";
        } else if (newFullName.trim().length() > 100) {
            errorMessage = "Full Name cannot exceed 100 characters.";
        } else {

            boolean updateSuccess = updateUserFullName(currentUser.getId(), newFullName.trim());
            if (updateSuccess) {
                // Update the User object in the session
                currentUser.setFullName(newFullName.trim());
                session.setAttribute("loggedInUser", currentUser);
                successMessage = "Full Name updated successfully!";
            } else {
                errorMessage = "Failed to update Full Name. Please try again.";
            }
        }

        request.setAttribute("user", currentUser); 
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/profile.jsp");
        dispatcher.forward(request, response);
    }

    // This method ideally belongs in a UserDAO class
    private boolean updateUserFullName(int userId, String newFullName) {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE users SET full_name = ? WHERE id = ?";
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false;
            ps = conn.prepareStatement(sql);
            ps.setString(1, newFullName);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }
}
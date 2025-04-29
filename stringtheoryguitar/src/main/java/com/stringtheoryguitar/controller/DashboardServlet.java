package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.model.User; // Assuming User model exists

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Don't create session if not exists
        User currentUser = null;

        if (session != null) {
            currentUser = (User) session.getAttribute("loggedInUser");
        }

        // Security Check: User must be logged in and be an admin
        if (currentUser != null && "admin".equals(currentUser.getRole())) {
            // User is authorized


            // Forward to the dashboard JSP inside WEB-INF
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            // User is not authorized or not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login?error=auth");
        }
    }
}
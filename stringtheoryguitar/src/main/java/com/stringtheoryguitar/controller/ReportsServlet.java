package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.model.User; 

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // --- Security Check: Ensure user is logged in and is an admin ---
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            // Not an admin or not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login?error=auth");
            return;
        }
       
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/reports.jsp");
        dispatcher.forward(request, response);
    }


}
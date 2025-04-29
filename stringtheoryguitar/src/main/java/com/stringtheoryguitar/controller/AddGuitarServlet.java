package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-guitar")
@MultipartConfig
public class AddGuitarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security Check
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=auth"); return;
        }
        // Display message if redirected from simulated POST
        if ("true".equals(request.getParameter("success"))) { request.setAttribute("successMessage", "Demo: Guitar 'added' successfully!"); }

        // Display the empty form
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/add_guitar.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         // Security Check
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) { response.sendError(HttpServletResponse.SC_FORBIDDEN); return; }

        // Simulate action - Use 'brand' parameter
        String brand = request.getParameter("brand"); // Changed from make
        String model = request.getParameter("model");
        System.out.println("DEMO: Add Guitar POST received for " + brand + " " + model + " (Functionality Disabled).");

        // Redirect back to add form with success message
        response.sendRedirect(request.getContextPath() + "/add-guitar?success=true");
    }
}
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

@WebServlet("/edit-guitar")
@MultipartConfig
public class EditGuitarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security Check
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=auth"); return;
        }

        String idStr = request.getParameter("id");
        System.out.println("DEMO: EditGuitarServlet doGet requested for ID=" + idStr + ", forwarding to static edit page.");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/edit_guitar.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         // Security Check
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) { response.sendError(HttpServletResponse.SC_FORBIDDEN); return; }

        // Simulate action
        String guitarId = request.getParameter("guitarId");
        System.out.println("DEMO: Edit Guitar POST received for ID " + guitarId + " (Functionality Disabled).");
        response.sendRedirect(request.getContextPath() + "/manage-inventory?edit=simulated");
    }
}
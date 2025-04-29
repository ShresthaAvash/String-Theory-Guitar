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

@WebServlet("/manage-inventory")
public class ManageInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security Check
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=auth"); return;
        }

        // Check for redirect messages
        if ("simulated".equals(request.getParameter("add"))) { request.setAttribute("successMessage", "Demo: Guitar 'added' successfully!"); }
        if ("simulated".equals(request.getParameter("edit"))) { request.setAttribute("successMessage", "Demo: Guitar 'updated' successfully!"); }
        if ("simulated".equals(request.getParameter("delete"))) { request.setAttribute("successMessage", "Demo: Guitar 'deleted' successfully!"); }
        if ("error".equals(request.getParameter("delete"))) { request.setAttribute("errorMessage", "Demo: Error 'deleting' guitar."); }
        if ("notfound".equals(request.getParameter("error"))) { request.setAttribute("errorMessage", "Demo: Could not find specified guitar."); }

        // Forward to static JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/manage_inventory.jsp");
        dispatcher.forward(request, response);
    }
}
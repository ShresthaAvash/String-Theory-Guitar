package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.dao.GuitarDAO;
import com.stringtheoryguitar.model.Guitar;
import com.stringtheoryguitar.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/manage-inventory")
public class ManageInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=auth");
            return;
        }

        String addStatus = request.getParameter("add");
        String editStatus = request.getParameter("edit");
        String deleteStatus = request.getParameter("delete");
        String errorStatus = request.getParameter("error");
        String msg = request.getParameter("msg");
        String editedGuitarId = request.getParameter("id");


        if ("success".equals(addStatus)) {
            request.setAttribute("successMessage", "Guitar added successfully!");
        }
        if ("success".equals(editStatus)) {
            request.setAttribute("successMessage", "Guitar (ID: " + (editedGuitarId != null ? editedGuitarId : "") + ") updated successfully!");
        }
        if ("success".equals(deleteStatus)) {
            request.setAttribute("successMessage", "Guitar deleted successfully!");
        }
        if ("error".equals(deleteStatus)) {
            request.setAttribute("errorMessage", "Error deleting guitar. " + (msg != null ? msg : ""));
        }
        if ("notfound".equals(errorStatus)) {
            request.setAttribute("errorMessage", "Guitar not found. " + (msg != null ? msg : ""));
        }
         if ("edit_failed".equals(errorStatus)) {
            request.setAttribute("errorMessage", "Failed to edit guitar. " + (msg != null ? msg : ""));
        }

        String searchTerm = request.getParameter("search");
        String sortOrder = request.getParameter("sort");

        List<Guitar> guitars = guitarDAO.getAllGuitars(searchTerm, sortOrder);
        request.setAttribute("guitars", guitars);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("sortOrder", sortOrder);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/manage_inventory.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("guitarId");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int guitarId = Integer.parseInt(idStr);
                    boolean success = guitarDAO.deleteGuitar(guitarId);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=success");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=deletion_failed_db");
                    }
                    return;
                } catch (NumberFormatException e) {
                     response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=invalid_id_format_for_delete");
                     return;
                }
            } else {
                 response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=missing_id_for_delete");
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-inventory");
    }
}
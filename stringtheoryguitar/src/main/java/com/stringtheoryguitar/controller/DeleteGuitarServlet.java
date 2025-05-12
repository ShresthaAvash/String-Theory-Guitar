package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.dao.GuitarDAO;
import com.stringtheoryguitar.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/delete-guitar")
public class DeleteGuitarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied.");
            return;
        }

        String guitarIdStr = request.getParameter("guitarId");

        if (guitarIdStr == null || guitarIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=missing_id");
            return;
        }

        try {
            int guitarId = Integer.parseInt(guitarIdStr);
            boolean success = guitarDAO.deleteGuitar(guitarId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=db_error_or_not_found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=invalid_id_format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/manage-inventory?delete=error&msg=unexpected_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/manage-inventory?error=invalid_request_method_for_delete");
    }
}
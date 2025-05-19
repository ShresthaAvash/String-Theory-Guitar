package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.dao.GuitarDAO; // Or UserDAO if countTotalCustomers is there
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
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = null;

        if (session != null) {
            currentUser = (User) session.getAttribute("loggedInUser");
        }

        if (currentUser != null && "admin".equals(currentUser.getRole())) {
            int totalInventoryCount = guitarDAO.countTotalGuitars();
            BigDecimal estimatedInventoryValue = guitarDAO.calculateTotalInventoryValue();
            // Fetch up to 10 recently added guitars
            List<Guitar> recentlyAddedGuitars = guitarDAO.getRecentlyAddedGuitars(10);
            int totalCustomerCount = guitarDAO.countTotalCustomers();

            request.setAttribute("totalInventoryCount", totalInventoryCount);
            request.setAttribute("estimatedInventoryValue", estimatedInventoryValue);
            request.setAttribute("recentlyAddedGuitars", recentlyAddedGuitars);
            request.setAttribute("totalCustomerCount", totalCustomerCount);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login?error=auth");
        }
    }
}
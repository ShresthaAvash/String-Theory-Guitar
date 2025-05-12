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
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/add-guitar")
public class AddGuitarServlet extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/add_guitar.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<String> errors = new ArrayList<>();
        Guitar guitar = new Guitar();

        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String guitarType = request.getParameter("guitarType");
        String yearStr = request.getParameter("year");
        String serialNumber = request.getParameter("serialNumber");
        String finishColor = request.getParameter("finishColor");
        String bodyWood = request.getParameter("bodyWood");
        String neckWood = request.getParameter("neckWood");
        String fretboardWood = request.getParameter("fretboardWood");
        String pickups = request.getParameter("pickups");
        String condition = request.getParameter("condition");
        String conditionDetails = request.getParameter("conditionDetails");
        String priceStr = request.getParameter("price");
        String mainImageUrl = request.getParameter("mainImageUrl");

        if (brand == null || brand.trim().isEmpty()) {
            errors.add("Brand is required.");
        }
        guitar.setBrand(brand);

        if (model == null || model.trim().isEmpty()) {
            errors.add("Model is required.");
        }
        guitar.setModel(model);

        guitar.setGuitarType(guitarType);

        if (yearStr != null && !yearStr.trim().isEmpty()) {
            try {
                int year = Integer.parseInt(yearStr);
                int currentYear = java.time.Year.now().getValue();
                if (year < 1900 || year > currentYear + 1) { // Basic range check
                    errors.add("Year must be between 1900 and " + (currentYear + 1) + ".");
                }
                guitar.setYearProduced(year);
            } catch (NumberFormatException e) {
                errors.add("Year must be a valid number.");
            }
        } else {
             guitar.setYearProduced(null);
        }
        guitar.setSerialNumber(serialNumber);
        guitar.setFinishColor(finishColor);
        guitar.setBodyWood(bodyWood);
        guitar.setNeckWood(neckWood);
        guitar.setFretboardWood(fretboardWood);
        guitar.setPickups(pickups);

        if (condition == null || condition.trim().isEmpty()) {
            errors.add("Condition is required.");
        }
        guitar.setConditionRating(condition);

        guitar.setConditionDetails(conditionDetails);

        if (priceStr == null || priceStr.trim().isEmpty()) {
            errors.add("Price is required.");
        } else {
            try {
                BigDecimal price = new BigDecimal(priceStr);
                if (price.compareTo(BigDecimal.ZERO) < 0) {
                    errors.add("Price cannot be negative.");
                }
                guitar.setPrice(price);
            } catch (NumberFormatException e) {
                errors.add("Price must be a valid decimal number (e.g., 1299.99).");
            }
        }
        guitar.setMainImageUrl(mainImageUrl);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("guitar", guitar);
            request.setAttribute("mainImageUrlValue", mainImageUrl); // For add_guitar.jsp to repopulate URL field
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/add_guitar.jsp");
            dispatcher.forward(request, response);
            return;
        }

        boolean success = guitarDAO.addGuitar(guitar);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?add=success");
        } else {
            request.setAttribute("errorMessage", "Failed to add guitar to the database. An unexpected error occurred.");
            request.setAttribute("guitar", guitar);
            request.setAttribute("mainImageUrlValue", guitar.getMainImageUrl());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/add_guitar.jsp");
            dispatcher.forward(request, response);
        }
    }
}
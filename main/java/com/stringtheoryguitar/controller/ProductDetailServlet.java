// src/main/java/com/stringtheoryguitar/controller/ProductDetailServlet.java
package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.dao.GuitarDAO;
import com.stringtheoryguitar.model.Guitar;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        Guitar guitar = null;
        String errorMessage = null;

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int guitarId = Integer.parseInt(idStr);
                System.out.println("ProductDetailServlet: Fetching guitar with ID: " + guitarId);
                guitar = guitarDAO.getGuitarById(guitarId);

                if (guitar == null) {
                    System.out.println("ProductDetailServlet: Guitar not found for ID: " + guitarId);
                    errorMessage = "The guitar you are looking for could not be found.";
                }
            } catch (NumberFormatException e) {
                System.err.println("ProductDetailServlet: Invalid guitar ID format: " + idStr);
                errorMessage = "Invalid guitar ID specified.";
            } catch (Exception e) {
                System.err.println("ProductDetailServlet: Error fetching guitar: " + e.getMessage());
                e.printStackTrace();
                errorMessage = "An error occurred while retrieving guitar details.";
            }
        } else {
            System.out.println("ProductDetailServlet: No guitar ID provided.");
            errorMessage = "No guitar ID specified.";
        }

        if (guitar != null) {
            request.setAttribute("guitar", guitar);
        } else {
            request.setAttribute("errorMessage", errorMessage);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/product_detail.jsp");
        dispatcher.forward(request, response);
    }
}
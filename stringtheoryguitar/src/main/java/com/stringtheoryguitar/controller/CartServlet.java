package com.stringtheoryguitar.controller;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("true".equals(request.getParameter("added"))) {
            request.setAttribute("successMessage", "Item 'added' to cart (Demo).");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/cart.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        System.out.println("DEMO: Add to Cart POST received for Product ID: " + productId
                           + ", Quantity: " + quantityStr + " (Functionality Disabled).");

        response.sendRedirect(request.getContextPath() + "/cart?added=true");
    }
}
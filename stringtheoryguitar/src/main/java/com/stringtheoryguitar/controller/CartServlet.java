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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/cart.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addToCart".equals(action)) {
            String productId = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            System.out.println("CartServlet (POST): DEMO - 'Add to Cart' action received. Product ID: " + productId + ", Quantity: " + quantityStr);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if ("buyNow".equals(action)) {
            System.out.println("CartServlet (POST): DEMO - 'Buy Now' action received.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        System.out.println("CartServlet (POST): Received POST with no specific recognized 'action', forwarding to doGet.");
        doGet(request, response);
    }
}
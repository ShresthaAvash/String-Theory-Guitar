package com.stringtheoryguitar.controller;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For static demo, we just forward. No data fetching based on ID.
        String idStr = request.getParameter("id");
        System.out.println("DEMO: Product Detail request for ID=" + idStr + ", showing static page.");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/product_detail.jsp");
        dispatcher.forward(request, response);
    }
}
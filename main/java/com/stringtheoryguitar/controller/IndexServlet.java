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
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/"})
public class IndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() throws ServletException {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("IndexServlet.doGet - Entered.");
        int numberOfFeaturedGuitars = 3;
        List<Guitar> featuredGuitars = guitarDAO.getTopNFeaturedGuitars(numberOfFeaturedGuitars);

        System.out.println("IndexServlet.doGet - Fetched " + (featuredGuitars != null ? featuredGuitars.size() : "null") + " featured guitars from DAO.");
        if (featuredGuitars != null && !featuredGuitars.isEmpty()) {
            for (Guitar g : featuredGuitars) {
                System.out.println("IndexServlet.doGet - Featured Guitar: " + g.getBrand() + " " + g.getModel() + " Main Image URL: " + g.getMainImageUrl());
            }
        }

        request.setAttribute("featuredGuitars", featuredGuitars);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/index.jsp");
        dispatcher.forward(request, response);
        System.out.println("IndexServlet.doGet - Forwarded to index.jsp.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
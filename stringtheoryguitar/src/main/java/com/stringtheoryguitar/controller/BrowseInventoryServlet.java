// src/main/java/com/stringtheoryguitar/controller/BrowseInventoryServlet.java
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

@WebServlet("/browse")
public class BrowseInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        String sortOrder = request.getParameter("sort");

        List<Guitar> guitars = guitarDAO.getAllGuitars(searchTerm, sortOrder);

        request.setAttribute("guitars", guitars);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("sortOrder", sortOrder);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/browseinventory.jsp");
        dispatcher.forward(request, response);
    }
}
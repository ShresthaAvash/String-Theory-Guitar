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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GuitarDAO guitarDAO;

    @Override
    public void init() {
        guitarDAO = new GuitarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Guitar cartItem = null;
        int cartItemQuantity = 0;

        if (session != null) {
            Integer cartItemId = (Integer) session.getAttribute("cartItemId");
            Integer quantity = (Integer) session.getAttribute("cartItemQuantity");

            if (cartItemId != null && quantity != null) {
                cartItem = guitarDAO.getGuitarById(cartItemId);
                cartItemQuantity = quantity;
            }
        }

        request.setAttribute("cartItem", cartItem);
        request.setAttribute("cartItemQuantity", cartItemQuantity);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/cart.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("loggedInUser");
        String action = request.getParameter("action");

        if (currentUser == null) {
            String redirectAfterLogin = request.getContextPath() + "/cart";
            String productIdParam = request.getParameter("productId");
            String quantityParam = request.getParameter("quantity");

            if ("addToCart".equals(action) && productIdParam != null && !productIdParam.isEmpty()) {
                session.setAttribute("productToAddAfterLoginId", productIdParam);
                if (quantityParam != null && !quantityParam.isEmpty()) {
                    session.setAttribute("productToAddAfterLoginQuantity", quantityParam);
                } else {
                    session.setAttribute("productToAddAfterLoginQuantity", "1");
                }
                redirectAfterLogin = request.getContextPath() + "/cart";
            }

            String loginRedirectUrl = request.getContextPath() + "/login?message=" +
                    URLEncoder.encode("Please login to manage your cart.", StandardCharsets.UTF_8.toString()) +
                    "&redirect=" + URLEncoder.encode(redirectAfterLogin, StandardCharsets.UTF_8.toString());
            response.sendRedirect(loginRedirectUrl);
            return;
        }

        if ("addToCart".equals(action)) {
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            if (productIdStr == null || productIdStr.trim().isEmpty() ||
                quantityStr == null || quantityStr.trim().isEmpty()) {
                request.setAttribute("cartErrorMessage", "Invalid product ID or quantity.");
                doGet(request, response);
                return;
            }

            try {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);

                if (quantity <= 0) {
                    request.setAttribute("cartErrorMessage", "Quantity must be at least 1.");
                    doGet(request, response);
                    return;
                }

                Guitar product = guitarDAO.getGuitarById(productId);
                if (product == null) {
                    request.setAttribute("cartErrorMessage", "Product not found.");
                    doGet(request, response);
                    return;
                }

                session.setAttribute("cartItemId", productId);
                session.setAttribute("cartItemQuantity", quantity);
                session.removeAttribute("productToAddAfterLoginId");
                session.removeAttribute("productToAddAfterLoginQuantity");

                request.setAttribute("cartSuccessMessage", product.getBrand() + " " + product.getModel() + " added to cart!");
                response.sendRedirect(request.getContextPath() + "/cart");

            } catch (NumberFormatException e) {
                request.setAttribute("cartErrorMessage", "Invalid product ID or quantity format.");
                doGet(request, response);
            }
            return;
        }

        if ("buyNow".equals(action)) {
            session.removeAttribute("cartItemId");
            session.removeAttribute("cartItemQuantity");
            request.getSession().setAttribute("purchaseMessage", "Your order has been placed successfully!");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if ("updateQuantity".equals(action)) {
            String quantityStr = request.getParameter("quantity");
            try {
                int quantity = Integer.parseInt(quantityStr);
                if (quantity > 0) {
                    session.setAttribute("cartItemQuantity", quantity);
                } else {
                    session.removeAttribute("cartItemId");
                    session.removeAttribute("cartItemQuantity");
                }
            } catch (NumberFormatException e) {

            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
         if ("remove".equals(action)) {
            session.removeAttribute("cartItemId");
            session.removeAttribute("cartItemQuantity");
            request.setAttribute("cartSuccessMessage", "Item removed from cart.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }


        doGet(request, response);
    }
}
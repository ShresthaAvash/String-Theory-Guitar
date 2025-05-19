package com.stringtheoryguitar.controller;

import com.stringtheoryguitar.dao.GuitarDAO;
import com.stringtheoryguitar.model.Guitar;
import com.stringtheoryguitar.model.GuitarImage; // Import GuitarImage
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
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/edit-guitar")
public class EditGuitarServlet extends HttpServlet {
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
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?error=notfound&msg=missing_id");
            return;
        }
        try {
            int guitarId = Integer.parseInt(idStr);
            Guitar guitar = guitarDAO.getGuitarById(guitarId);
            if (guitar == null) {
                response.sendRedirect(request.getContextPath() + "/manage-inventory?error=notfound&msg=guitar_not_exist");
                return;
            }
            request.setAttribute("guitar", guitar);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/edit_guitar.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?error=notfound&msg=invalid_id_format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String guitarIdStr = request.getParameter("guitarId");
        if (guitarIdStr == null || guitarIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?error=edit_failed&msg=missing_id_post");
            return;
        }
        int guitarId;
        try {
            guitarId = Integer.parseInt(guitarIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?error=edit_failed&msg=invalid_id_post");
            return;
        }

        List<String> errors = new ArrayList<>();
        Guitar guitar = new Guitar();
        guitar.setId(guitarId);

        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        guitar.setBrand(brand);
        guitar.setModel(request.getParameter("model"));
        guitar.setGuitarType(request.getParameter("guitarType"));
        String yearStr = request.getParameter("year");
        if (yearStr != null && !yearStr.trim().isEmpty()) {
            try {
                int year = Integer.parseInt(yearStr);
                int currentYear = java.time.Year.now().getValue();
                if (year < 1900 || year > currentYear + 1) errors.add("Year must be between 1900 and " + (currentYear + 1) + ".");
                guitar.setYearProduced(year);
            } catch (NumberFormatException e) { errors.add("Year must be a valid number."); }
        } else { guitar.setYearProduced(null); }
        guitar.setSerialNumber(request.getParameter("serialNumber"));
        guitar.setFinishColor(request.getParameter("finishColor"));
        guitar.setBodyWood(request.getParameter("bodyWood"));
        guitar.setNeckWood(request.getParameter("neckWood"));
        guitar.setFretboardWood(request.getParameter("fretboardWood"));
        guitar.setPickups(request.getParameter("pickups"));
        String condition = request.getParameter("condition");
        if (condition == null || condition.trim().isEmpty()) errors.add("Condition is required.");
        guitar.setConditionRating(condition);
        guitar.setConditionDetails(request.getParameter("conditionDetails"));
        String priceStr = request.getParameter("price");
        if (priceStr == null || priceStr.trim().isEmpty()) errors.add("Price is required.");
        else {
            try {
                BigDecimal price = new BigDecimal(priceStr);
                if (price.compareTo(BigDecimal.ZERO) < 0) errors.add("Price cannot be negative.");
                guitar.setPrice(price);
            } catch (NumberFormatException e) { errors.add("Price must be a valid decimal number."); }
        }

        String[] existingImageIds = request.getParameterValues("imageId");
        String[] existingImageUrls = request.getParameterValues("existingImageUrl"); 
        String[] newImageUrls = request.getParameterValues("newImageUrl"); 
        String[] deleteImageCheckbox = request.getParameterValues("deleteImageCheckbox"); 
        String mainImageRadioValue = request.getParameter("mainImageRadio"); 

        List<GuitarImage> imagesToUpdateInDB = new ArrayList<>();
        List<GuitarImage> imagesToAddToDB = new ArrayList<>();
        List<Integer> imageIdsToDeleteFromDB = new ArrayList<>();

        if (deleteImageCheckbox != null) {
            for (String idToDeleteStr : deleteImageCheckbox) {
                try {
                    imageIdsToDeleteFromDB.add(Integer.parseInt(idToDeleteStr));
                } catch (NumberFormatException e) { }
            }
        }

        // Process existing images
        if (existingImageIds != null && existingImageUrls != null && existingImageIds.length == existingImageUrls.length) {
            for (int i = 0; i < existingImageIds.length; i++) {
                int imgId;
                try {
                    imgId = Integer.parseInt(existingImageIds[i]);
                } catch (NumberFormatException e) { continue;}

                if (imageIdsToDeleteFromDB.contains(imgId)) {
                    continue;
                }

                String url = existingImageUrls[i];
                if (url != null && !url.trim().isEmpty()) {
                    GuitarImage img = new GuitarImage(guitarId, url.trim(), false);
                    img.setImageId(imgId);
                    if (mainImageRadioValue != null && mainImageRadioValue.equals("existing_" + imgId)) {
                        img.setMainImage(true);
                    }
                    imagesToUpdateInDB.add(img);
                } else {

                    imageIdsToDeleteFromDB.add(imgId);
                }
            }
        }

        // Process new images
        if (newImageUrls != null) {
            for (int i = 0; i < newImageUrls.length; i++) {
                String url = newImageUrls[i];
                if (url != null && !url.trim().isEmpty()) {
                    GuitarImage img = new GuitarImage(guitarId, url.trim(), false);
                    if (mainImageRadioValue != null && mainImageRadioValue.equals("new_" + i)) {
                        img.setMainImage(true);
                    }
                    imagesToAddToDB.add(img);
                }
            }
        }


        boolean mainSelected = false;
        for (GuitarImage img : imagesToUpdateInDB) if (img.isMainImage()) mainSelected = true;
        if (!mainSelected) {
            for (GuitarImage img : imagesToAddToDB) if (img.isMainImage()) mainSelected = true;
        }

        if (!mainSelected) {
            if (!imagesToUpdateInDB.isEmpty()) {
                imagesToUpdateInDB.get(0).setMainImage(true);
            } else if (!imagesToAddToDB.isEmpty()) {
                imagesToAddToDB.get(0).setMainImage(true);
            }
        }

        if (mainSelected) {
            boolean firstMainFound = false;
            for (GuitarImage img : imagesToUpdateInDB) {
                if (img.isMainImage()) {
                    if (firstMainFound) img.setMainImage(false);
                    else firstMainFound = true;
                }
            }
            for (GuitarImage img : imagesToAddToDB) {
                 if (img.isMainImage()) {
                    if (firstMainFound) img.setMainImage(false);
                    else firstMainFound = true;
                }
            }
        }


        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);

            Guitar originalGuitar = guitarDAO.getGuitarById(guitarId);
            request.setAttribute("guitar", originalGuitar != null ? originalGuitar : guitar);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/edit_guitar.jsp");
            dispatcher.forward(request, response);
            return;
        }

        boolean success = guitarDAO.updateGuitar(guitar, imagesToAddToDB, imageIdsToDeleteFromDB, imagesToUpdateInDB);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/manage-inventory?edit=success&id=" + guitarId);
        } else {
            request.setAttribute("errorMessage", "Failed to update guitar. Please try again.");
            Guitar guitarForForm = guitarDAO.getGuitarById(guitarId);
            request.setAttribute("guitar", guitarForForm != null ? guitarForForm : guitar); 
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/edit_guitar.jsp");
            dispatcher.forward(request, response);
        }
    }
}
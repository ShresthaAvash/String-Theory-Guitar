package com.stringtheoryguitar.dao;

import com.stringtheoryguitar.model.Guitar;
import com.stringtheoryguitar.model.GuitarImage;
import com.stringtheoryguitar.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class GuitarDAO {

    private Guitar mapRowToGuitar(ResultSet rs) throws SQLException {
        Guitar guitar = new Guitar();
        guitar.setId(rs.getInt("id"));
        guitar.setBrand(rs.getString("brand"));
        guitar.setModel(rs.getString("model"));
        guitar.setGuitarType(rs.getString("guitar_type"));
        int yearProducedInt = rs.getInt("year_produced");
        guitar.setYearProduced(rs.wasNull() ? null : yearProducedInt);
        guitar.setSerialNumber(rs.getString("serial_number"));
        guitar.setFinishColor(rs.getString("finish_color"));
        guitar.setBodyWood(rs.getString("body_wood"));
        guitar.setNeckWood(rs.getString("neck_wood"));
        guitar.setFretboardWood(rs.getString("fretboard_wood"));
        guitar.setPickups(rs.getString("pickups"));
        guitar.setConditionRating(rs.getString("condition_rating"));
        guitar.setConditionDetails(rs.getString("condition_details"));
        guitar.setPrice(rs.getBigDecimal("price"));
        guitar.setDateAdded(rs.getTimestamp("date_added"));
        return guitar;
    }

    private GuitarImage mapRowToGuitarImage(ResultSet rs) throws SQLException {
        GuitarImage image = new GuitarImage();
        image.setImageId(rs.getInt("image_id"));
        image.setGuitarId(rs.getInt("guitar_id"));
        image.setImageUrlPath(rs.getString("image_url_path"));
        image.setMainImage(rs.getBoolean("is_main_image"));
        image.setDateAdded(rs.getTimestamp("date_added"));
        return image;
    }

    private void setGuitarPreparedStatementParameters(PreparedStatement ps, Guitar guitar) throws SQLException {
        ps.setString(1, guitar.getBrand());
        ps.setString(2, guitar.getModel());
        ps.setString(3, guitar.getGuitarType());
        if (guitar.getYearProduced() != null && guitar.getYearProduced() != 0) {
            ps.setInt(4, guitar.getYearProduced());
        } else {
            ps.setNull(4, Types.INTEGER);
        }
        ps.setString(5, guitar.getSerialNumber());
        ps.setString(6, guitar.getFinishColor());
        ps.setString(7, guitar.getBodyWood());
        ps.setString(8, guitar.getNeckWood());
        ps.setString(9, guitar.getFretboardWood());
        ps.setString(10, guitar.getPickups());
        ps.setString(11, guitar.getConditionRating());
        ps.setString(12, guitar.getConditionDetails());
        if (guitar.getPrice() != null) {
            ps.setBigDecimal(13, guitar.getPrice());
        } else {
            ps.setNull(13, Types.DECIMAL);
        }
    }

    private List<GuitarImage> getImagesForGuitar(Connection conn, int guitarId) throws SQLException {
        List<GuitarImage> images = new ArrayList<>();
        String sql = "SELECT * FROM guitar_images WHERE guitar_id = ? ORDER BY is_main_image DESC, image_id ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guitarId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images.add(mapRowToGuitarImage(rs));
                }
            }
        }
        return images;
    }

    private String getMainImageUrlForGuitar(Connection conn, int guitarId) throws SQLException {
        String sql = "SELECT image_url_path FROM guitar_images WHERE guitar_id = ? AND is_main_image = TRUE LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guitarId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("image_url_path");
                }
            }
        }
        sql = "SELECT image_url_path FROM guitar_images WHERE guitar_id = ? ORDER BY image_id ASC LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guitarId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("image_url_path");
                }
            }
        }
        return null;
    }

    public List<Guitar> getAllGuitars(String searchTerm, String sortOrder) {
        List<Guitar> guitars = new ArrayList<>();
        String sql = "SELECT * FROM guitars";
        List<Object> params = new ArrayList<>();
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += " WHERE (brand LIKE ? OR model LIKE ? OR serial_number LIKE ?)";
            String likeTerm = "%" + searchTerm.trim() + "%";
            params.add(likeTerm);
            params.add(likeTerm);
            params.add(likeTerm);
        }
        String orderByClause = " ORDER BY date_added DESC";
        if (sortOrder != null && !sortOrder.trim().isEmpty()) {
            switch (sortOrder) {
                case "date_asc": orderByClause = " ORDER BY date_added ASC"; break;
                case "price_asc": orderByClause = " ORDER BY price ASC"; break;
                case "price_desc": orderByClause = " ORDER BY price DESC"; break;
                case "make_asc": orderByClause = " ORDER BY brand ASC, model ASC"; break;
                case "make_desc": orderByClause = " ORDER BY brand DESC, model DESC"; break;
                default: orderByClause = " ORDER BY date_added DESC"; break;
            }
        }
        sql += orderByClause;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                 System.err.println("GuitarDAO.getAllGuitars: DB Connection is NULL");
                 return guitars;
            }
            ps = conn.prepareStatement(sql);
            for (int k = 0; k < params.size(); k++) {
                ps.setObject(k + 1, params.get(k));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Guitar guitar = mapRowToGuitar(rs);
                String mainImgUrl = getMainImageUrlForGuitar(conn, guitar.getId());
                if (mainImgUrl != null) {
                    GuitarImage mainImage = new GuitarImage(guitar.getId(), mainImgUrl, true);
                    List<GuitarImage> tempList = new ArrayList<>();
                    tempList.add(mainImage);
                    guitar.setImages(tempList);
                }
                guitars.add(guitar);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(ps);
            DBUtil.close(conn);
        }
        return guitars;
    }

    public Guitar getGuitarById(int guitarId) {
        Guitar guitar = null;
        String sql = "SELECT * FROM guitars WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("GuitarDAO.getGuitarById: DB Connection is NULL");
                return null;
            }
            ps = conn.prepareStatement(sql);
            ps.setInt(1, guitarId);
            rs = ps.executeQuery();
            if (rs.next()) {
                guitar = mapRowToGuitar(rs);
                if (guitar != null) {
                    guitar.setImages(getImagesForGuitar(conn, guitar.getId()));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(ps);
            DBUtil.close(conn);
        }
        return guitar;
    }

    public boolean addGuitar(Guitar guitar, List<GuitarImage> imagesToAdd) {
        String guitarSql = "INSERT INTO guitars (brand, model, guitar_type, year_produced, serial_number, finish_color, body_wood, neck_wood, fretboard_wood, pickups, condition_rating, condition_details, price, date_added) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement psGuitar = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("GuitarDAO.addGuitar: DB Connection is NULL");
                return false;
            }
            conn.setAutoCommit(false);
            psGuitar = conn.prepareStatement(guitarSql, Statement.RETURN_GENERATED_KEYS);
            setGuitarPreparedStatementParameters(psGuitar, guitar);
            int affectedRows = psGuitar.executeUpdate();
            if (affectedRows > 0) {
                generatedKeys = psGuitar.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int newGuitarId = generatedKeys.getInt(1);
                    guitar.setId(newGuitarId);
                    if (imagesToAdd != null && !imagesToAdd.isEmpty()) {
                        String imageSql = "INSERT INTO guitar_images (guitar_id, image_url_path, is_main_image) VALUES (?, ?, ?)";
                        try (PreparedStatement psImage = conn.prepareStatement(imageSql)) {
                            for (GuitarImage img : imagesToAdd) {
                                psImage.setInt(1, newGuitarId);
                                psImage.setString(2, img.getImageUrlPath());
                                psImage.setBoolean(3, img.isMainImage());
                                psImage.addBatch();
                            }
                            psImage.executeBatch();
                        }
                    }
                }
                conn.commit();
                success = true;
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            DBUtil.close(generatedKeys);
            DBUtil.close(psGuitar);
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
                DBUtil.close(conn);
            }
        }
        return success;
    }

    public boolean updateGuitar(Guitar guitar, List<GuitarImage> imagesToAdd, List<Integer> imageIdsToDelete, List<GuitarImage> imagesToUpdate) {
        String guitarSql = "UPDATE guitars SET brand=?, model=?, guitar_type=?, year_produced=?, serial_number=?, finish_color=?, body_wood=?, neck_wood=?, fretboard_wood=?, pickups=?, condition_rating=?, condition_details=?, price=? WHERE id=?";
        Connection conn = null;
        PreparedStatement psGuitar = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                 System.err.println("GuitarDAO.updateGuitar: DB Connection is NULL");
                return false;
            }
            conn.setAutoCommit(false);
            psGuitar = conn.prepareStatement(guitarSql);
            setGuitarPreparedStatementParameters(psGuitar, guitar);
            psGuitar.setInt(14, guitar.getId());
            int affectedRows = psGuitar.executeUpdate();

            if (affectedRows >= 0) { 
                if (imageIdsToDelete != null && !imageIdsToDelete.isEmpty()) {
                    String deleteImageSql = "DELETE FROM guitar_images WHERE image_id = ? AND guitar_id = ?";
                    try (PreparedStatement psDeleteImage = conn.prepareStatement(deleteImageSql)) {
                        for (Integer imgId : imageIdsToDelete) {
                            psDeleteImage.setInt(1, imgId);
                            psDeleteImage.setInt(2, guitar.getId());
                            psDeleteImage.addBatch();
                        }
                        psDeleteImage.executeBatch();
                    }
                }

                String unmarkMainSql = "UPDATE guitar_images SET is_main_image = FALSE WHERE guitar_id = ?";
                try(PreparedStatement psUnmark = conn.prepareStatement(unmarkMainSql)) {
                    psUnmark.setInt(1, guitar.getId());
                    psUnmark.executeUpdate();
                }

                if (imagesToUpdate != null && !imagesToUpdate.isEmpty()) {
                    String updateImageSql = "UPDATE guitar_images SET image_url_path = ?, is_main_image = ? WHERE image_id = ? AND guitar_id = ?";
                    try (PreparedStatement psUpdateImage = conn.prepareStatement(updateImageSql)) {
                        for (GuitarImage img : imagesToUpdate) {
                            psUpdateImage.setString(1, img.getImageUrlPath());
                            psUpdateImage.setBoolean(2, img.isMainImage());
                            psUpdateImage.setInt(3, img.getImageId());
                            psUpdateImage.setInt(4, guitar.getId());
                            psUpdateImage.addBatch();
                        }
                        psUpdateImage.executeBatch();
                    }
                }

                if (imagesToAdd != null && !imagesToAdd.isEmpty()) {
                    String addImageSql = "INSERT INTO guitar_images (guitar_id, image_url_path, is_main_image) VALUES (?, ?, ?)";
                    try (PreparedStatement psAddImage = conn.prepareStatement(addImageSql)) {
                        for (GuitarImage img : imagesToAdd) {
                            psAddImage.setInt(1, guitar.getId());
                            psAddImage.setString(2, img.getImageUrlPath());
                            psAddImage.setBoolean(3, img.isMainImage());
                            psAddImage.addBatch();
                        }
                        psAddImage.executeBatch();
                    }
                }
                conn.commit();
                success = true;
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            DBUtil.close(psGuitar);
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
                DBUtil.close(conn);
            }
        }
        return success;
    }

    public boolean deleteGuitar(int guitarId) {
        String deleteGuitarSql = "DELETE FROM guitars WHERE id = ?";
        Connection conn = null;
        PreparedStatement psDeleteGuitar = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("GuitarDAO.deleteGuitar: DB Connection is NULL");
                return false;
            }
            psDeleteGuitar = conn.prepareStatement(deleteGuitarSql);
            psDeleteGuitar.setInt(1, guitarId);
            int affectedRows = psDeleteGuitar.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(psDeleteGuitar);
            DBUtil.close(conn);
        }
        return success;
    }

    public List<Guitar> getTopNFeaturedGuitars(int numberOfGuitars) {
        List<Guitar> featuredGuitars = new ArrayList<>();
        String sql = "SELECT * FROM guitars WHERE price IS NOT NULL ORDER BY price DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return featuredGuitars;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, numberOfGuitars);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guitar guitar = mapRowToGuitar(rs);
                String mainImgUrl = getMainImageUrlForGuitar(conn, guitar.getId());
                if (mainImgUrl != null) {
                    GuitarImage mainImage = new GuitarImage(guitar.getId(), mainImgUrl, true);
                    List<GuitarImage> tempList = new ArrayList<>(); tempList.add(mainImage);
                    guitar.setImages(tempList);
                }
                featuredGuitars.add(guitar);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(ps);
            DBUtil.close(conn);
        }
        return featuredGuitars;
    }

    public int countTotalGuitars() {
        String sql = "SELECT COUNT(*) FROM guitars";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (conn == null) {
                System.err.println("GuitarDAO.countTotalGuitars: DB Connection is NULL");
                return 0;
            }
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal calculateTotalInventoryValue() {
        String sql = "SELECT SUM(price) FROM guitars WHERE price IS NOT NULL";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (conn == null) {
                System.err.println("GuitarDAO.calculateTotalInventoryValue: DB Connection is NULL");
                return BigDecimal.ZERO;
            }
            if (rs.next()) {
                BigDecimal sum = rs.getBigDecimal(1);
                return sum != null ? sum : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public List<Guitar> getRecentlyAddedGuitars(int limit) {
        List<Guitar> recentGuitars = new ArrayList<>();
        String sql = "SELECT * FROM guitars ORDER BY date_added DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return recentGuitars;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                Guitar guitar = mapRowToGuitar(rs);
                String mainImgUrl = getMainImageUrlForGuitar(conn, guitar.getId());
                if (mainImgUrl != null) {
                    GuitarImage mainImage = new GuitarImage(guitar.getId(), mainImgUrl, true);
                    List<GuitarImage> tempList = new ArrayList<>(); tempList.add(mainImage);
                    guitar.setImages(tempList);
                }
                recentGuitars.add(guitar);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(ps);
            DBUtil.close(conn);
        }
        return recentGuitars;
    }

    public int countTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'customer'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("GuitarDAO.countTotalCustomers: DB Connection is NULL");
                return 0;
            }
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(ps);
            DBUtil.close(conn);
        }
        return count;
    }
}
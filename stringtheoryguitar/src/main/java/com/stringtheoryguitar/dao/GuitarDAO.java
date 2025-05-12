package com.stringtheoryguitar.dao;

import com.stringtheoryguitar.model.Guitar;
import com.stringtheoryguitar.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class GuitarDAO {

    public List<Guitar> getAllGuitars(String searchTerm, String sortOrder) {
        List<Guitar> guitars = new ArrayList<>();
        String sql = "SELECT id, brand, model, guitar_type, year_produced, serial_number, finish_color, body_wood, neck_wood, fretboard_wood, pickups, condition_rating, condition_details, price, date_added, main_image_url FROM guitars";
        List<Object> params = new ArrayList<>();
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += " WHERE (brand LIKE ? OR model LIKE ? OR serial_number LIKE ?)";
            String likeTerm = "%" + searchTerm.trim().toLowerCase() + "%";
            params.add(likeTerm); params.add(likeTerm); params.add(likeTerm);
        }
        String orderByClause = " ORDER BY date_added DESC";
        if (sortOrder != null && !sortOrder.trim().isEmpty()) {
            switch (sortOrder) {
                case "date_asc": orderByClause = " ORDER BY date_added ASC"; break;
                case "price_asc": orderByClause = " ORDER BY price ASC"; break;
                case "price_desc": orderByClause = " ORDER BY price DESC"; break;
                case "make_asc": orderByClause = " ORDER BY brand ASC, model ASC"; break;
                case "make_desc": orderByClause = " ORDER BY brand DESC, model DESC"; break;
            }
        }
        sql += orderByClause;
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection(); ps = conn.prepareStatement(sql);
            for (int k = 0; k < params.size(); k++) ps.setObject(k + 1, params.get(k));
            rs = ps.executeQuery();
            while (rs.next()) {
                Guitar guitar = mapRowToGuitar(rs);
                guitars.add(guitar);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(rs); DBUtil.close(ps); DBUtil.close(conn); }
        return guitars;
    }

    public Guitar getGuitarById(int guitarId) {
        Guitar guitar = null; String sql = "SELECT id, brand, model, guitar_type, year_produced, serial_number, finish_color, body_wood, neck_wood, fretboard_wood, pickups, condition_rating, condition_details, price, date_added, main_image_url FROM guitars WHERE id = ?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection(); ps = conn.prepareStatement(sql); ps.setInt(1, guitarId);
            rs = ps.executeQuery();
            if (rs.next()) {
                guitar = mapRowToGuitar(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(rs); DBUtil.close(ps); DBUtil.close(conn); }
        return guitar;
    }

    public boolean addGuitar(Guitar guitar) {
        String guitarSql = "INSERT INTO guitars (brand, model, guitar_type, year_produced, serial_number, finish_color, body_wood, neck_wood, fretboard_wood, pickups, condition_rating, condition_details, price, main_image_url, date_added) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        Connection conn = null; PreparedStatement psGuitar = null; ResultSet generatedKeys = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            psGuitar = conn.prepareStatement(guitarSql, Statement.RETURN_GENERATED_KEYS);
            setGuitarPreparedStatementParameters(psGuitar, guitar);
            int affectedRows = psGuitar.executeUpdate();
            if (affectedRows > 0) {
                generatedKeys = psGuitar.getGeneratedKeys();
                if (generatedKeys.next()) {
                    guitar.setId(generatedKeys.getInt(1));
                }
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(generatedKeys); DBUtil.close(psGuitar); DBUtil.close(conn);
        }
        return success;
    }

    public boolean updateGuitar(Guitar guitar) {
        String guitarSql = "UPDATE guitars SET brand=?, model=?, guitar_type=?, year_produced=?, serial_number=?, finish_color=?, body_wood=?, neck_wood=?, fretboard_wood=?, pickups=?, condition_rating=?, condition_details=?, price=?, main_image_url=? WHERE id=?";
        Connection conn = null; PreparedStatement psGuitar = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            psGuitar = conn.prepareStatement(guitarSql);
            setGuitarPreparedStatementParameters(psGuitar, guitar);
            psGuitar.setInt(15, guitar.getId());
            int affectedRows = psGuitar.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(psGuitar); DBUtil.close(conn);
        }
        return success;
    }

    public boolean deleteGuitar(int guitarId) {
        String deleteGuitarSql = "DELETE FROM guitars WHERE id = ?";
        Connection conn = null; PreparedStatement psDeleteGuitar = null;
        boolean success = false;
        try {
            conn = DBUtil.getConnection();
            psDeleteGuitar = conn.prepareStatement(deleteGuitarSql);
            psDeleteGuitar.setInt(1, guitarId);
            int affectedRows = psDeleteGuitar.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(psDeleteGuitar); DBUtil.close(conn);
        }
        return success;
    }

    private Guitar mapRowToGuitar(ResultSet rs) throws SQLException {
        Guitar guitar = new Guitar();
        guitar.setId(rs.getInt("id")); guitar.setBrand(rs.getString("brand"));
        guitar.setModel(rs.getString("model")); guitar.setGuitarType(rs.getString("guitar_type"));
        int yearProducedInt = rs.getInt("year_produced");
        guitar.setYearProduced(rs.wasNull() ? null : yearProducedInt);
        guitar.setSerialNumber(rs.getString("serial_number")); guitar.setFinishColor(rs.getString("finish_color"));
        guitar.setBodyWood(rs.getString("body_wood")); guitar.setNeckWood(rs.getString("neck_wood"));
        guitar.setFretboardWood(rs.getString("fretboard_wood")); guitar.setPickups(rs.getString("pickups"));
        guitar.setConditionRating(rs.getString("condition_rating")); guitar.setConditionDetails(rs.getString("condition_details"));
        guitar.setPrice(rs.getBigDecimal("price")); guitar.setDateAdded(rs.getTimestamp("date_added"));
        guitar.setMainImageUrl(rs.getString("main_image_url"));
        return guitar;
    }

    private void setGuitarPreparedStatementParameters(PreparedStatement ps, Guitar guitar) throws SQLException {
        ps.setString(1, guitar.getBrand()); ps.setString(2, guitar.getModel());
        ps.setString(3, guitar.getGuitarType());
        if (guitar.getYearProduced() != null && guitar.getYearProduced() != 0) {
            ps.setInt(4, guitar.getYearProduced());
        } else { ps.setNull(4, Types.INTEGER); }
        ps.setString(5, guitar.getSerialNumber()); ps.setString(6, guitar.getFinishColor());
        ps.setString(7, guitar.getBodyWood()); ps.setString(8, guitar.getNeckWood());
        ps.setString(9, guitar.getFretboardWood()); ps.setString(10, guitar.getPickups());
        ps.setString(11, guitar.getConditionRating()); ps.setString(12, guitar.getConditionDetails());
        if (guitar.getPrice() != null) {
            ps.setBigDecimal(13, guitar.getPrice());
        } else { ps.setNull(13, Types.DECIMAL); }
        if (guitar.getMainImageUrl() != null && !guitar.getMainImageUrl().trim().isEmpty()) {
            ps.setString(14, guitar.getMainImageUrl().trim());
        } else {
            ps.setNull(14, Types.VARCHAR);
        }
    }

    public List<Guitar> getTopNFeaturedGuitars(int numberOfGuitars) {
        List<Guitar> featuredGuitars = new ArrayList<>();
        String sql = "SELECT id, brand, model, guitar_type, year_produced, serial_number, finish_color, body_wood, neck_wood, fretboard_wood, pickups, condition_rating, condition_details, price, date_added, main_image_url FROM guitars WHERE price IS NOT NULL ORDER BY price DESC LIMIT ?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection(); ps = conn.prepareStatement(sql);
            ps.setInt(1, numberOfGuitars); rs = ps.executeQuery();
            while (rs.next()) {
                Guitar guitar = mapRowToGuitar(rs);
                featuredGuitars.add(guitar);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(rs); DBUtil.close(ps); DBUtil.close(conn); }
        return featuredGuitars;
    }
}
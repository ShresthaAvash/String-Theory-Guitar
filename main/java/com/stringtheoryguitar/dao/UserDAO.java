package com.stringtheoryguitar.dao;

import com.stringtheoryguitar.model.User;
import com.stringtheoryguitar.util.DBUtil;
import com.stringtheoryguitar.util.PasswordUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class UserDAO {

    // Authenticate user
    public User loginUser(String username, String password) {
        User user = null;
        String sql = "SELECT id, username, email, full_name, role, password FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return null;

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
                    user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("full_name"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return user;
    }

    // Register new user
    public boolean registerUser(User user, String plainPassword) {
        String sql = "INSERT INTO users (username, email, full_name, password, role) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false;

            String hashedPassword = PasswordUtil.hashPassword(plainPassword);
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername().trim());
            ps.setString(2, user.getEmail().trim().toLowerCase());
            ps.setString(3, user.getFullName().trim());
            ps.setString(4, hashedPassword);
            ps.setString(5, user.getRole() != null ? user.getRole() : "customer"); 

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    // Check username existence
    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false;

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            return false;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    public boolean emailExists(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        String sql = "SELECT id FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false; 

            ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim().toLowerCase());
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    // Update password reset token
    public boolean setPasswordResetToken(int userId, String token, Timestamp expiry) {
        String sql = "UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false;

            ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            ps.setTimestamp(2, expiry);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    // Find user by email
    public User findUserByEmail(String email) {
        User user = null;
        String sql = "SELECT id, username, email, full_name, role FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return null;

            ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim().toLowerCase());
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return user;
    }

    // Find user by reset token
    public User findUserByResetToken(String token, Timestamp currentTime) {
        User user = null;
        String sql = "SELECT id, username, email, full_name, role FROM users WHERE reset_token = ? AND reset_token_expiry > ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return null;

            ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            ps.setTimestamp(2, currentTime);
            rs = ps.executeQuery();
            if (rs.next()) {
                 user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return user;
    }

    // Update user password
    public boolean updateUserPassword(int userId, String newHashedPassword) {
        String sql = "UPDATE users SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false;

            ps = conn.prepareStatement(sql);
            ps.setString(1, newHashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    // Update user's full name
    public boolean updateUserFullName(int userId, String newFullName) {
        String sql = "UPDATE users SET full_name = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return false; // DB connection failed

            ps = conn.prepareStatement(sql);
            ps.setString(1, newFullName.trim());
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    // Count total customers
    public int countTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'customer'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = DBUtil.getConnection();
            if (conn == null) return 0; // DB connection failed

            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return count;
    }
}
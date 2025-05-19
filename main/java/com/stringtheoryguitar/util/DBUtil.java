package com.stringtheoryguitar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {


    private static final String DB_URL = "jdbc:mysql://localhost:3306/sting_theory_guitars?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("DBUtil: MySQL JDBC Driver registered successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("DBUtil: CRITICAL - MySQL JDBC Driver not found. Ensure mysql-connector-j.jar is in WEB-INF/lib.");
            e.printStackTrace();

            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.err.println("DBUtil: CRITICAL - Failed to establish database connection.");
            System.err.println("DBUtil: URL: " + DB_URL);
            System.err.println("DBUtil: User: " + DB_USER);
            System.err.println("DBUtil: SQLException: " + e.getMessage());
            e.printStackTrace();

        }
        return connection;
    }

    public static void close(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {

                e.printStackTrace();
            }
        }
    }

    public static void close(Statement statement) {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {

                e.printStackTrace();
            }
        }
    }

     public static void close(PreparedStatement preparedStatement) {
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {

                e.printStackTrace();
            }
        }
    }

    public static void close(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {

                e.printStackTrace();
            }
        }
    }

     public static void close(Connection conn, PreparedStatement ps, ResultSet rs) {
        close(rs);
        close(ps);
        close(conn);
    }

     public static void close(Connection conn, Statement stmt, ResultSet rs) {
        close(rs);
        close(stmt);
        close(conn);
    }

     public static void close(Connection conn, PreparedStatement ps) {
        close(ps);
        close(conn);
    }

    public static void close(Connection conn, Statement stmt) {
        close(stmt);
        close(conn);
    }
}
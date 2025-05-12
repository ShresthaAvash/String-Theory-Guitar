package com.stringtheoryguitar.util;

import org.mindrot.jbcrypt.BCrypt;


public final class PasswordUtil {


    private static final int BCRYPT_WORKLOAD = 12;

    private PasswordUtil() {
        throw new UnsupportedOperationException("This is a utility class and cannot be instantiated");
    }

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password to hash cannot be null or empty.");
        }

        String salt = BCrypt.gensalt(BCRYPT_WORKLOAD);
        return BCrypt.hashpw(plainPassword, salt);
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null || plainPassword.isEmpty() || hashedPassword.isEmpty()) {
            System.err.println("Password check failed: Received null or empty input.");
            return false;
        }

        boolean passwordsMatch = false;
        try {

            passwordsMatch = BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            System.err.println("Password check failed: Invalid hash format provided. " + e.getMessage());
        } catch (Exception e) {
           System.err.println("Unexpected error during password check: " + e.getMessage());
        }

        return passwordsMatch;
    }
}
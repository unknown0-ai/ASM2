package com.example.ASM2_JAV101_TH04864.RepositoryAccount;


import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.Account;

import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.util.Base64;

public class RepoAccount {
    public List<Account> getAll() {
        List<Account> list = new ArrayList<>();
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT * FROM Account";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new Account(rs.getInt("Id"), rs.getString("Username"), rs.getString("Password"), rs.getBoolean("Active"),rs.getString("Email")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean delete(int id) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "DELETE FROM Account WHERE Id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Account findByUsername(String username) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT * FROM Account WHERE Username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("Id"), rs.getString("Username"), rs.getString("Password"), rs.getBoolean("Active"),rs.getString("Email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public Account findByEmail(String email) {
        String sql = "SELECT * FROM Account WHERE Email = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getInt("Id"));
                acc.setUsername(rs.getString("Username"));
                acc.setPassword(rs.getString("Password"));
                acc.setActive(rs.getBoolean("Active"));
                acc.setEmail(rs.getString("Email"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public String hashPassword(String password) throws Exception {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 256);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] hash = factory.generateSecret(spec).getEncoded();
        return Base64.getEncoder().encodeToString(hash) + ":" + Base64.getEncoder().encodeToString(salt);
    }

    public boolean verifyPassword(String providedPassword, String storedPassword) throws Exception {
        String[] parts = storedPassword.split(":");
        byte[] hash = Base64.getDecoder().decode(parts[0]);
        byte[] salt = Base64.getDecoder().decode(parts[1]);
        KeySpec spec = new PBEKeySpec(providedPassword.toCharArray(), salt, 65536, 256);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] testHash = factory.generateSecret(spec).getEncoded();
        return java.util.Arrays.equals(hash, testHash);
    }
    public void updateRememberToken(int userId, String token) {
        String sql = "UPDATE Account SET remember_token = ? WHERE Id = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.setInt(2, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Account checkRememberToken(int userId, String token) {
        String sql = "SELECT * FROM Account WHERE Id = ? AND remember_token = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, token);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getInt("Id"));
                acc.setUsername(rs.getString("Username"));
                acc.setPassword(rs.getString("Password"));
                acc.setActive(rs.getBoolean("Active"));
                acc.setEmail(rs.getString("Email"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Không tìm thấy hoặc token sai
    }
}

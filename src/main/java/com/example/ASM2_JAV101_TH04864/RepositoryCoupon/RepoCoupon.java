package com.example.ASM2_JAV101_TH04864.RepositoryCoupon;
import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.Coupon;

import java.util.*;
import java.sql.*;
import java.util.Date;

public class RepoCoupon {
    public List<Coupon> getAll() {
        List<Coupon> list = new ArrayList<>();
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT * FROM Coupon";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new Coupon(rs.getInt("Id"), rs.getString("Code"), rs.getInt("Discount"),
                        rs.getDate("StartDate"), rs.getDate("EndDate"), rs.getString("ApplyTo")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void add(Coupon c) {
        String sql = "INSERT INTO Coupon (Code, Discount, StartDate, EndDate, ApplyTo) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getCode());        // 1. Code – BẮT BUỘC CÓ!
            ps.setInt(2, c.getDiscount());
            ps.setDate(3, new java.sql.Date(c.getStartDate().getTime()));
            ps.setDate(4, new java.sql.Date(c.getEndDate().getTime()));
            ps.setString(5, c.getApplyTo());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean delete(int id) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "DELETE FROM Coupon WHERE Id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public float applyCoupon(String code, String loaiSP, float originalPrice) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT Discount, ApplyTo FROM Coupon WHERE Code = ? " +
                    "AND StartDate <= ? AND EndDate >= ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code.toUpperCase());
            ps.setDate(2, new java.sql.Date(new Date(2025 - 1900, 11, 8).getTime()));
            ps.setDate(3, new java.sql.Date(new Date(2025 - 1900, 11, 8).getTime()));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String applyTo = rs.getString("ApplyTo");
                if ("all".equalsIgnoreCase(applyTo) || loaiSP.equalsIgnoreCase(applyTo)) {
                    int discount = rs.getInt("Discount");
                    return (float) (originalPrice * (1 - discount / 100.0));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return originalPrice;
    }
    public List<Coupon> getAllValidCoupons() {
        List<Coupon> list = new ArrayList<>();
        String sql = "SELECT * FROM Coupon WHERE GETDATE() BETWEEN StartDate AND EndDate";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Coupon coupon = new Coupon();
                coupon.setId(rs.getInt("Id"));
                coupon.setCode(rs.getString("Code"));
                coupon.setDiscount(rs.getInt("Discount"));
                coupon.setStartDate(rs.getDate("StartDate"));
                coupon.setEndDate(rs.getDate("EndDate"));
                coupon.setApplyTo(rs.getString("ApplyTo"));

                list.add(coupon);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean isApplicable(Coupon coupon, String loaiSP) {
        if (coupon == null || loaiSP == null || loaiSP.trim().isEmpty()) {
            return false;
        }

        String applyTo = coupon.getApplyTo();

        if (applyTo == null || applyTo.trim().isEmpty() || "all".equalsIgnoreCase(applyTo)) {
            return true;
        }

        return applyTo.equalsIgnoreCase(loaiSP.trim());
    }
    public Coupon findById(int id) {
        String sql = "SELECT * FROM Coupon WHERE Id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Coupon coupon = new Coupon();
                coupon.setId(rs.getInt("Id"));
                coupon.setCode(rs.getString("Code"));
                coupon.setDiscount(rs.getInt("Discount"));
                coupon.setStartDate(rs.getDate("StartDate"));
                coupon.setEndDate(rs.getDate("EndDate"));
                coupon.setApplyTo(rs.getString("ApplyTo"));
                return coupon;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

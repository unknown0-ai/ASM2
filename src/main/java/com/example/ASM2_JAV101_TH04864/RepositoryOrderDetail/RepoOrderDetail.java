package com.example.ASM2_JAV101_TH04864.RepositoryOrderDetail;

import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.OrderDetail;
import com.example.ASM2_JAV101_TH04864.Entity.SanPham;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RepoOrderDetail {

    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, sp.TenSp, sp.HangSP, sp.LoaiSP " +
                "FROM OrderDetail od " +
                "JOIN SanPham sp ON od.SanPhamId = sp.Id " +
                "WHERE od.OrderId = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail(
                        rs.getInt("DetailId"),
                        rs.getInt("OrderId"),
                        rs.getInt("SanPhamId"),
                        rs.getInt("SoLuong"),
                        rs.getDouble("GiaGoc"),
                        rs.getDouble("GiaDaGiam"),
                        rs.getString("TenSp"),
                        rs.getString("HangSP"),
                        rs.getString("LoaiSP")
                );

                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
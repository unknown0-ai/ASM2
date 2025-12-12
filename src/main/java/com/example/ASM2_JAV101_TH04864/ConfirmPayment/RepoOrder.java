package com.example.ASM2_JAV101_TH04864.ConfirmPayment;

import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.Order;
import com.example.ASM2_JAV101_TH04864.Entity.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class RepoOrder {
    public int addOrder(Order order) {
        String sql = "INSERT INTO [Order] (CustomerName, CustomerEmail, CustomerPhone, TotalAmount, CouponCode) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, order.getCustomerName());
            ps.setString(2, order.getCustomerEmail());
            ps.setString(3, order.getCustomerPhone());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getCouponCode());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về OrderId
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Lỗi
    }

    // 2. Thêm chi tiết đơn hàng vào bảng OrderDetail
    public void addOrderDetail(OrderDetail detail) {
        String sql = "INSERT INTO OrderDetail (OrderId, SanPhamId, SoLuong, GiaGoc, GiaDaGiam) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getSanPhamId());
            ps.setInt(3, detail.getSoLuong());
            ps.setDouble(4, detail.getGiaGoc());
            ps.setDouble(5, detail.getGiaDaGiam());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. (Tùy chọn) Lấy đơn hàng theo Id (nếu anh muốn xem chi tiết đơn sau này)
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [Order] WHERE OrderId = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setCustomerEmail(rs.getString("CustomerEmail"));
                order.setCustomerPhone(rs.getString("CustomerPhone"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setCouponCode(rs.getString("CouponCode"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setStatus(rs.getString("Status"));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order] ORDER BY OrderDate DESC";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setCustomerEmail(rs.getString("CustomerEmail"));
                order.setCustomerPhone(rs.getString("CustomerPhone"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setCouponCode(rs.getString("CouponCode"));
                order.setStatus(rs.getString("Status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

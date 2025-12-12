package com.example.ASM2_JAV101_TH04864.RepositoryProduct;
import java.util.*;
import java.sql.*;
import com.example.ASM2_JAV101_TH04864.Dbconnector.DbConnector;
import com.example.ASM2_JAV101_TH04864.Entity.SanPham;

public class RepoProduct {
    public List<SanPham> getAll() {
        List<SanPham> list = new ArrayList<>();
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT * FROM SanPham";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new SanPham(rs.getInt("Id"), rs.getString("TenSp"), rs.getFloat("GiaSP"),
                        rs.getBoolean("TrangThaiSP"), rs.getInt("SoluongSP"), rs.getString("HangSP"), rs.getString("LoaiSP")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public SanPham findById(int id) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "SELECT * FROM SanPham WHERE Id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new SanPham(rs.getInt("Id"), rs.getString("TenSp"), rs.getFloat("GiaSP"),
                        rs.getBoolean("TrangThaiSP"), rs.getInt("SoluongSP"), rs.getString("HangSP"), rs.getString("LoaiSP"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean add(SanPham sp) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "INSERT INTO SanPham (TenSp, GiaSP, TrangThaiSP, SoluongSP, HangSP, LoaiSP) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sp.getTenSP());
            ps.setFloat(2, sp.getGiaSP());
            ps.setBoolean(3, sp.isTrangthaiSP());
            ps.setInt(4, sp.getSoluongSP());
            ps.setString(5, sp.getHangSP());
            ps.setString(6, sp.getLoaiSP());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(SanPham sp) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "UPDATE SanPham SET TenSp=?, GiaSP=?, TrangThaiSP=?, SoluongSP=?, HangSP=?, LoaiSP=? WHERE Id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sp.getTenSP());
            ps.setFloat(2, sp.getGiaSP());
            ps.setBoolean(3, sp.isTrangthaiSP());
            ps.setInt(4, sp.getSoluongSP());
            ps.setString(5, sp.getHangSP());
            ps.setString(6, sp.getLoaiSP());
            ps.setInt(7, sp.getMaSP());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int id) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "DELETE FROM SanPham WHERE Id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean buy(int id, int quantity) {
        try (Connection conn = DbConnector.getConnection()) {
            String sql = "UPDATE SanPham SET SoluongSP = SoluongSP - ?," +
                    " TrangThaiSP = CASE WHEN SoluongSP - ? > 0 THEN 1 ELSE 0 END " +
                    "WHERE Id = ? AND SoluongSP >= ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, quantity);
            ps.setInt(3, id);
            ps.setInt(4, quantity);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<SanPham> filter(String loaiSP, String hangSP, Float minPrice, Float maxPrice) {
        ArrayList<SanPham> List= new ArrayList<>();
        try {
            Connection connection = DbConnector.getConnection();
            String query = "SELECT * FROM SanPham\n" +
                    "WHERE GiaSP BETWEEN ? AND ?" +
                    "  AND HangSP = ?"    +
                    "  AND LoaiSP = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setFloat(1,minPrice);
            ps.setFloat(2,maxPrice);
            ps.setString(3,hangSP);
            ps.setString(4,loaiSP);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                Integer id = rs.getInt("Id");
                String ten = rs.getString("TenSp");
                Integer gia = rs.getInt("GiaSP");
                boolean TrangThai = rs.getBoolean("TrangThaiSP");
                Integer soluong = rs.getInt("SoluongSP");
                String HangSP = rs.getString("HangSP");
                String LoaiSP = rs.getString("LoaiSP");

                SanPham sp = new SanPham(id,ten,gia,TrangThai,soluong,hangSP,loaiSP);
                List.add(sp);
            }
            return List;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}

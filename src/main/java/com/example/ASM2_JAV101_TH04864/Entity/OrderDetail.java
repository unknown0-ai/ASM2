package com.example.ASM2_JAV101_TH04864.Entity;

public class OrderDetail {

    private int detailId;
    private int orderId;
    private int sanPhamId;
    private int soLuong;
    private double giaGoc;
    private double giaDaGiam;

    // Các thuộc tính bổ sung để hiển thị (tên, hãng, loại sản phẩm)
    private String tenSP;
    private String hangSP;
    private String loaiSP;

    // Constructor mặc định
    public OrderDetail() {
    }

    // Constructor khi thêm mới (chỉ cần các field bắt buộc)
    public OrderDetail(int orderId, int sanPhamId, int soLuong, double giaGoc, double giaDaGiam) {
        this.orderId = orderId;
        this.sanPhamId = sanPhamId;
        this.soLuong = soLuong;
        this.giaGoc = giaGoc;
        this.giaDaGiam = giaDaGiam;
    }

    // Constructor đầy đủ (khi lấy từ DB với JOIN SanPham)
    public OrderDetail(int detailId, int orderId, int sanPhamId, int soLuong, double giaGoc, double giaDaGiam, String tenSP, String hangSP, String loaiSP) {
        this.detailId = detailId;
        this.orderId = orderId;
        this.sanPhamId = sanPhamId;
        this.soLuong = soLuong;
        this.giaGoc = giaGoc;
        this.giaDaGiam = giaDaGiam;
        this.tenSP = tenSP;
        this.hangSP = hangSP;
        this.loaiSP = loaiSP;
    }

    // Getter & Setter
    public int getDetailId() { return detailId; }
    public void setDetailId(int detailId) { this.detailId = detailId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getSanPhamId() { return sanPhamId; }
    public void setSanPhamId(int sanPhamId) { this.sanPhamId = sanPhamId; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public double getGiaGoc() { return giaGoc; }
    public void setGiaGoc(double giaGoc) { this.giaGoc = giaGoc; }

    public double getGiaDaGiam() { return giaDaGiam; }
    public void setGiaDaGiam(double giaDaGiam) { this.giaDaGiam = giaDaGiam; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }

    public String getHangSP() { return hangSP; }
    public void setHangSP(String hangSP) { this.hangSP = hangSP; }

    public String getLoaiSP() { return loaiSP; }
    public void setLoaiSP(String loaiSP) { this.loaiSP = loaiSP; }
}
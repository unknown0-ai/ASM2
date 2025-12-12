package com.example.ASM2_JAV101_TH04864.Entity;

public class SanPham {
    private int maSP;
    private String tenSP;
    private float giaSP;
    private boolean trangthaiSP;
    private int soluongSP;
    private String hangSP;
    private String loaiSP;

    public SanPham() {}
    public SanPham(int maSP, String tenSP, float giaSP, boolean trangthaiSP, int soluongSP, String hangSP, String loaiSP) {
        this.maSP = maSP;
        this.tenSP = tenSP;
        this.giaSP = giaSP;
        this.trangthaiSP = trangthaiSP;
        this.soluongSP = soluongSP;
        this.hangSP = hangSP;
        this.loaiSP = loaiSP;
    }

    public SanPham(String tenSP, float giaSP, boolean trangthaiSP, int soluongSP, String hangSP, String loaiSP) {
        this.tenSP = tenSP;
        this.giaSP = giaSP;
        this.trangthaiSP = trangthaiSP;
        this.soluongSP = soluongSP;
        this.hangSP = hangSP;
        this.loaiSP = loaiSP;
    }

    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }
    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }
    public float getGiaSP() { return giaSP; }
    public double setGiaSP(float giaSP) { this.giaSP = giaSP;
        return 0;
    }
    public boolean isTrangthaiSP() { return trangthaiSP; }
    public void setTrangthaiSP(boolean trangthaiSP) { this.trangthaiSP = trangthaiSP; }
    public int getSoluongSP() { return soluongSP; }
    public void setSoluongSP(int soluongSP) { this.soluongSP = soluongSP; }
    public String getHangSP() { return hangSP; }
    public void setHangSP(String hangSP) { this.hangSP = hangSP; }
    public String getLoaiSP() { return loaiSP; }
    public void setLoaiSP(String loaiSP) { this.loaiSP = loaiSP; }
}

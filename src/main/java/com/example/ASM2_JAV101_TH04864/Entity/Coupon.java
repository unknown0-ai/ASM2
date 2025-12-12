package com.example.ASM2_JAV101_TH04864.Entity;

import java.util.Date;

public class Coupon {
    private int id;
    private String code;
    private int discount;
    private Date startDate;
    private Date endDate;
    private String applyTo;

    public Coupon(String code, Integer discount, Date startdate, Date enddate, String applyTo) {
        this.code = code;
        this.discount = discount;
        this.startDate = startdate;
        this.endDate = enddate;
        this.applyTo = applyTo;
    }

    public Coupon() {
    }

    public Coupon(int id, String code, int discount, Date startDate, Date endDate, String applyTo) {
        this.id = id;
        this.code = code;
        this.discount = discount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.applyTo = applyTo;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public int getDiscount() { return discount; }
    public void setDiscount(int discount) { this.discount = discount; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public String getApplyTo() { return applyTo; }
    public void setApplyTo(String applyTo) { this.applyTo = applyTo; }
}

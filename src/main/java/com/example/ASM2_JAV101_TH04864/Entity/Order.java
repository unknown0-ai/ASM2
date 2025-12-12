package com.example.ASM2_JAV101_TH04864.Entity;


import java.util.Date;

public class Order {
        private int orderId;
        private String customerName;
        private String customerEmail;
        private String customerPhone;
        private Date orderDate;
        private double totalAmount;
        private String couponCode;
        private String status;

    public Order() {
    }

    // Constructor dùng khi tạo mới
        public Order(String customerName, String customerEmail, String customerPhone, double totalAmount, String couponCode) {
            this.customerName = customerName;
            this.customerEmail = customerEmail;
            this.customerPhone = customerPhone;
            this.totalAmount = totalAmount;
            this.couponCode = couponCode;
        }

        // Getter & Setter
        public int getOrderId() { return orderId; }
        public void setOrderId(int orderId) { this.orderId = orderId; }
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        public String getCustomerPhone() { return customerPhone; }
        public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
        public Date getOrderDate() { return orderDate; }
        public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
        public double getTotalAmount() { return totalAmount; }
        public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
        public String getCouponCode() { return couponCode; }
        public void setCouponCode(String couponCode) { this.couponCode = couponCode; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }


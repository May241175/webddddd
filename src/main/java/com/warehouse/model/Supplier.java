package com.warehouse.model;

public class Supplier {

    private int supplierId;
    private String supplierName;
    private String phone;
    private String address;
    private String stockName;   // ✅ FIXED

    // ===== GETTERS =====
    public int getSupplierId() {
        return supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getStockName() {          // ✅ REQUIRED
        return stockName;
    }

    // ===== SETTERS =====
    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setStockName(String stockName) {   // ✅ REQUIRED
        this.stockName = stockName;
    }
}

package com.warehouse.model;

import java.sql.Date;

public class StockIn {

    private int inId;
    private int stockId;
    private String stockName;   // from stock table
    private int quantity;
    private Date dateIn;
    private String remarks;
    private int binId;

    // Getters
    public int getInId() {
        return inId;
    }

    public int getStockId() {
        return stockId;
    }

    public String getStockName() {
        return stockName;
    }

    public int getQuantity() {
        return quantity;
    }

    public Date getDateIn() {
        return dateIn;
    }

    public String getRemarks() {
        return remarks;
    }

    public int getBinId() {
        return binId;
    }

    // Setters
    public void setInId(int inId) {
        this.inId = inId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setDateIn(Date dateIn) {
        this.dateIn = dateIn;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public void setBinId(int binId) {
        this.binId = binId;
    }
}

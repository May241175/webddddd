package com.warehouse.model;

import java.sql.Date;

public class StockOut {

    private int outId;
    private int stockId;
    private int quantity;
    private int userId;
    private Date dateOut;
    private String remark;
    private int binId;

    // Getters & Setters
    public int getOutId() { return outId; }
    public void setOutId(int outId) { this.outId = outId; }

    public int getStockId() { return stockId; }
    public void setStockId(int stockId) { this.stockId = stockId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Date getDateOut() { return dateOut; }
    public void setDateOut(Date dateOut) { this.dateOut = dateOut; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public int getBinId() { return binId; }
    public void setBinId(int binId) { this.binId = binId; }
}

package com.warehouse.model;

public class StockBalance {

    private int stockId;
    private String stockName;
    private int totalIn;
    private int totalOut;
    private int balanceQty;

    // --- Getters & Setters ---

    public int getStockId() {
        return stockId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }

    public String getStockName() {
        return stockName;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName;
    }

    public int getTotalIn() {
        return totalIn;
    }

    public void setTotalIn(int totalIn) {
        this.totalIn = totalIn;
    }

    public int getTotalOut() {
        return totalOut;
    }

    public void setTotalOut(int totalOut) {
        this.totalOut = totalOut;
    }

    public int getBalanceQty() {
        return balanceQty;
    }

    public void setBalanceQty(int balanceQty) {
        this.balanceQty = balanceQty;
    }
}

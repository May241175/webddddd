package com.warehouse.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.warehouse.dao.OrderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class InvoiceController {

    @Autowired
    private OrderDao orderDao;

    @GetMapping("/invoice")
    public void generateInvoice(@RequestParam("id") int orderId,
                                HttpServletResponse response) throws IOException {

        Map<String, Object> data = orderDao.getInvoiceData(orderId);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=Invoice-" + data.get("order_number") + ".pdf");

        Document pdf = new Document();
        PdfWriter.getInstance(pdf, response.getOutputStream());
        pdf.open();

        // Title
        Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
        Paragraph title = new Paragraph("INVOICE", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        pdf.add(title);

        pdf.add(new Paragraph(" ")); // spacing

        // Order Info
        pdf.add(new Paragraph("Order Number: " + data.get("order_number")));
        pdf.add(new Paragraph("Order Date: " + data.get("order_date")));
        pdf.add(new Paragraph("Customer: " + data.get("user_fullname")));
        pdf.add(new Paragraph("Email: " + data.get("user_email")));
        pdf.add(new Paragraph("Phone: " + data.get("user_phone_number")));
        pdf.add(new Paragraph("Delivery Address: " + data.get("delivery_address")));

        pdf.add(new Paragraph(" "));
        pdf.add(new Paragraph(" "));

        // Table Header
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);

        table.addCell("Item");
        table.addCell("Qty");
        table.addCell("Price");
        table.addCell("Total");

        // Table Rows
        List<Map<String, Object>> items = (List<Map<String, Object>>) data.get("items");
        for (Map<String, Object> item : items) {
            table.addCell(item.get("item_name").toString());
            table.addCell(item.get("quantity").toString());
            table.addCell(item.get("price").toString());
            table.addCell(item.get("total").toString());
        }

        pdf.add(table);

        pdf.add(new Paragraph(" "));
        pdf.add(new Paragraph("Grand Total: " + data.get("grand_total") + " Ks",
                new Font(Font.HELVETICA, 14, Font.BOLD)));

        pdf.close();
    }
}

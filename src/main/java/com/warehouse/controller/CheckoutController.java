package com.warehouse.controller;

import com.warehouse.dao.CartDao;
import com.warehouse.dao.OrderDao;
import com.warehouse.dao.UserAddressDao;
import com.warehouse.model.CartItem;
import com.warehouse.model.User;
import com.warehouse.model.UserAddress;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class CheckoutController {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private OrderDao orderDao;
    
    @Autowired
    private UserAddressDao addressDao;

    // --------------------------------
    // SHOW CHECKOUT PAGE
    // --------------------------------
    @GetMapping("/checkout")
    public String checkoutPage(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<CartItem> cartItems = cartDao.getCartByUser(user.getUser_id());
        if (cartItems.isEmpty()) return "redirect:/cart";

        // 1. CALCULATE GRAND TOTAL PRICE
        double grandTotal = 0.0;
        for (CartItem item : cartItems) {
            // Assumes CartItem.getTotalPrice() holds (unitPrice * quantity)
            grandTotal += item.getTotalPrice(); 
        }
        
        // 2. Add Grand Total to the Model for the JSP
        model.addAttribute("total", grandTotal); 
        
        // Load Address and User Data
        UserAddress defaultAddr = addressDao.getDefaultAddress(user.getUser_id());
        List<UserAddress> allAddr = addressDao.getAddresses(user.getUser_id());

        model.addAttribute("defaultAddress", defaultAddr);
        model.addAttribute("addresses", allAddr);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("user", user);

        return "checkout";
    }

    // --------------------------------
    // PLACE ORDER
    // --------------------------------
    @PostMapping("/checkout/place")
    public String placeOrder(@RequestParam int addressId,
                             @RequestParam String payment,
                             HttpSession session,
                             Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        List<CartItem> cartItems = cartDao.getCartByUser(user.getUser_id());
        if (cartItems.isEmpty())
            return "redirect:/cart";

        // Get full address from DB
        UserAddress addr = addressDao.getAddressById(addressId);

        String addressText =
                addr.getFullName() + ", " +
                addr.getPhone() + ", " +
                addr.getAddressLine() + ", " +
                addr.getCity() + ", " +
                addr.getRegion();

        int orderId = orderDao.saveOrder(
                user.getUser_id(),
                addressText,     
                payment,
                cartItems
        );

        cartDao.clearCart(user.getUser_id());

        model.addAttribute("orderId", orderId);
        return "order-success";
    }

    @GetMapping("/order-success")
    public String orderSuccess(@RequestParam("id") int orderId, Model model) {
        model.addAttribute("orderId", orderId);
        return "order-success"; // loads order-success.jsp
    }
    
    @GetMapping("/order-history")
    public String orderHistory(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/login";

        List<Map<String, Object>> orders = orderDao.getOrdersByUser(user.getUser_id());

        model.addAttribute("orders", orders);
        return "order-history";
    }
    
    @GetMapping("/order-details")
    public String orderDetails(@RequestParam int id, Model model) {

        Map<String, Object> summary = orderDao.getOrderSummary(id);

        model.addAttribute("orderNumber", summary.get("order_number"));
        model.addAttribute("items", summary.get("items"));
        model.addAttribute("total", summary.get("total"));

        return "order-details-modal";
    }
}
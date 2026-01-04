package com.warehouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.warehouse.dao.CartDao;
import com.warehouse.dao.OrderDao;
import com.warehouse.dao.ProductDao;
import com.warehouse.dao.UserAddressDao;
import com.warehouse.model.CartItem;
import com.warehouse.model.User;
import com.warehouse.model.UserAddress;

/**
 * Checkout page မှ "Place Order Now" နှိပ်ပြီးနောက် ရောက်ရှိမည့် Voucher စာမျက်နှာကို ကိုင်တွယ်သော Controller ဖြစ်သည်။
 */
@Controller
@RequestMapping("/")
public class VouncherController {

    /**
     * Checkout Form မှ /voucher လမ်းကြောင်းကို GET Request ဖြင့် ခေါ်ဆိုသောအခါ voucher.jsp ကို ပြသသည်။
     * JSP Form: <form action="${pageContext.request.contextPath}/voucher" method="get">
     * * @return voucher.jsp view ကို ပြန်ပို့ပေးသည်
     */
    @GetMapping("/vouncher")
    public ModelAndView showVoucherPage() {
        
        // "voucher" ဟူသော view name ကို ပြန်ပို့သည်။ 
        // ၎င်းသည် /WEB-INF/views/voucher.jsp ကို ညွှန်ပြနေမည်ဟု ယူဆသည်။
        return new ModelAndView("vouncher");
    }

 // Inside your controller class...
    @GetMapping("/product-list")
    public String productListPage(Model model) {
        // ... logic to load products ...
        return "product-list"; // Or whatever your JSP name is
    }

}
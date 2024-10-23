package Controller.Customer;

import JpaConfig.JpaConfig;
import Service.CartItemService;
import Service.OrderDetailsService;
import Service.OrderService;
import Service.ProductService;
import Service.impl.CartItemServiceImpl;
import Service.impl.OrderDetailServiceImpl;
import Service.impl.OrderServiceImpl;
import Service.impl.ProductServiceImpl;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/order")
public class OrderController extends HttpServlet {
    
    CartItemService cartItemService = new CartItemServiceImpl();
    OrderService orderService = new OrderServiceImpl();
    OrderDetailsService orderDetailsService = new OrderDetailServiceImpl();
    ProductService productService = new ProductServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getOrders(req, resp);
        String url = "/customer-account.jsp";
        String action = req.getParameter("action");
        if (action != null){
            // If current user confirm the oder then create the order
            if (action.equalsIgnoreCase("create")){
                action = "create";
            }
            if (action.equalsIgnoreCase("checkOrder")){
                url = checkOrder(req,resp);
            }
            else if (action.equalsIgnoreCase("create")){
                createOrder(req, resp);
            }
            else if (action.equalsIgnoreCase("cancel")){
                cancelOrder(req, resp);
            }
        }
        req.getRequestDispatcher(url).forward(req, resp);
    }
    
    public static void getOrders(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{
        HttpSession session = req.getSession();
        CustomerEntity customer = (CustomerEntity) session.getAttribute("user");
        OrderService orderService = new OrderServiceImpl();
        List<OrderEntity> customerOrders = orderService.findByCustomerId(customer.getCustomerId());
        session.setAttribute("customerOrders", customerOrders);
    }
    
    protected String checkOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{
        HttpSession session = req.getSession();
        String[] checkedProducts = req.getParameterValues("checkedProduct");
        List<CartItem> proceedProduct = new ArrayList<>();
        
        for (int i=0; i<checkedProducts.length; i++) {
            CartItem cartItem = cartItemService.findById(Integer.parseInt(checkedProducts[i]));
            ProductEntity productEntity = productService.findById(cartItem.getProduct().getProductId());
            proceedProduct.add(cartItem);
        }
        
        float tempPrice = 0;
        for (CartItem cartItem : proceedProduct){
            tempPrice += cartItem.getCartItemUnitPrice();
        }
        session.setAttribute("tempOrderPrice",tempPrice);
        session.setAttribute("tempOrder", proceedProduct);
        
        return "/orderdetails.jsp";
    }
    
    protected void createOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{
        
        // Get variables from client
        HttpSession session = req.getSession();
        CustomerEntity user = (CustomerEntity) session.getAttribute("user");
        List<CartItem> products = (List<CartItem>) session.getAttribute("tempOrder");
        String province = req.getParameter("province");
        String district = req.getParameter("district");
        String ward = req.getParameter("ward");
        String street = req.getParameter("street");
        
        String tmpAddr = street + ", " + ward +", " + district + ", " + province;
        
        float tempPrice = (float) session.getAttribute("tempOrderPrice");
        
        // Create order
        OrderEntity order = new OrderEntity();
        order.setCustomer(user);
        order.setOrderShipping(9);
        order.setOrderDiscount(0);
        order.setOrderTotal(tempPrice - tempPrice*order.getOrderDiscount() + order.getOrderShipping());
        order.setOrderPaymentMethod("COD");
        if (tmpAddr.contains("Choose") || tmpAddr.contains("null")) order.setShippingAddress(user.getCustomerAddress());
        else order.setShippingAddress(tmpAddr);
        orderService.create(order);
        
        // Create order detail
        for (CartItem cartItem : products){
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProduct(cartItem.getProduct());
            orderDetail.setOrderDetailQuantity(cartItem.getCartItemQuantity());
            orderDetail.setOrder(order);
            orderDetailsService.create(orderDetail);
            cartItemService.delete(cartItem.getCartItemId());
        }
    }
    
    protected void cancelOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{
        HttpSession session = req.getSession();
        int orderId = Integer.parseInt(req.getParameter("orderId")) ;
        OrderEntity orderEntity = orderService.findById(orderId);
        if (orderEntity.getOrderStatus() == null) {
            orderEntity.setOrderStatus("Cancel");
            List<OrderDetail> orderDetailList = orderDetailsService.findByOrderId(orderEntity.getOrderId());
            for (OrderDetail orderDetail1 : orderDetailList){
                ProductEntity productEntity = productService.findById(orderDetail1.getProduct().getProductId());
                productEntity.setProductInventory(productEntity.getProductInventory() + orderDetail1.getOrderDetailQuantity());
                productService.update(productEntity);
            }
            orderService.update(orderEntity);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

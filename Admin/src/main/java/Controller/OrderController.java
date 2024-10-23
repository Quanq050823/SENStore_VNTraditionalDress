package Controller;

import Service.OrderService;
import Service.impl.OrderServiceImpl;
import model.OrderEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.print.PrinterGraphics;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/order")
public class OrderController extends HttpServlet {

    OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String url = "FE/orderManage.jsp";
        if (action == null || action.equals("getOrders")) {
            getOrders(req, resp);
        } else {
            modifyOrders(req, resp, action);
        }
        getOrders(req, resp);
        req.getRequestDispatcher(url).forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    protected void getOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{

            List<OrderEntity> orders = orderService.findAll();
            req.setAttribute("orderList",orders);

        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get orders due to: " + ex;
            req.setAttribute("responseMessage",err);
        }
    }

    protected void modifyOrders(HttpServletRequest req, HttpServletResponse resp, String action) throws ServletException, IOException{
        try{

            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = "Not changed";
            Date deliveryDate = null;
            boolean tmpAcc = false;
            String message ="";
            switch (action){
                case "confirmOrder":
                    status = "Shipping";
                    message ="Confirm order";
                    tmpAcc = true;
                    break;
                case "completeOrder":
                    status = "Complete";
                    LocalDateTime ldt = LocalDateTime.now();
                    deliveryDate = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
                    message = "Complete order";
                    break;
                case "cancelOrder":
                    status = "Cancel";
                    message = "Cancel order";
                    break;
            }
            OrderEntity orderEntity = orderService.findById(orderId);
            orderEntity.setOrderStatus(status);
            orderEntity.setOrderDeliveryDate(deliveryDate);
            orderEntity.setAccepted(tmpAcc);
            orderService.update(orderEntity);
            req.setAttribute("responseMessage", message + " success!");

        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error modify order failed due to: " + ex.toString();
            req.setAttribute("responseMessage",err);
        }
    }
}


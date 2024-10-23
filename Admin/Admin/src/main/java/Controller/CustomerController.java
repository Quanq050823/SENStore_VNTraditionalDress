package Controller;

import Service.CustomerService;
import Service.impl.CustomerServiceImpl;
import model.CustomerEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.print.PrinterGraphics;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/customer")
public class CustomerController extends HttpServlet {

    CustomerService customerService = new CustomerServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String url = "FE/customerManage.jsp";
        if (action == null || action.equals("getCustomers")) {
            getCustomers(req, resp);
        } else if (action.equals("addCustomers"))
        {
            addCustomers(req, resp);
            getCustomers(req,resp);
        }
        else if (action.equals("editCustomers"))
        {
            editCustomers(req, resp);
            getCustomers(req,resp);
        }
        else if (action.equals("banCustomers"))
        {
            banCustomers(req, resp);
            getCustomers(req,resp);
        }
        else if (action.equals("activeCustomers"))
        {
            activeCustomers(req, resp);
            getCustomers(req,resp);
        }
        req.getRequestDispatcher(url).forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    protected void addCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{
            String cusfname = req.getParameter("cusfname");
            String cuslname = req.getParameter("cuslname");
            String cusphone = req.getParameter("cusphone");
            String cusmail = req.getParameter("cusmail");
            String cusaddress = req.getParameter("cusaddress");

            CustomerEntity newcustomer = new CustomerEntity();
            newcustomer.setCustomerFName(cusfname);
            newcustomer.setCustomerLName(cuslname);
            newcustomer.setCustomerPhone(cusphone);
            newcustomer.setCustomerMail(cusmail);
            newcustomer.setCustomerAddress(cusaddress);
            customerService.insert(newcustomer);

        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get products due to: " + ex;
            req.setAttribute("error",err);
        }
    }

    protected void getCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{

            List<CustomerEntity> customers = customerService.findAll();
            req.setAttribute("customerList",customers);


        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get products due to: " + ex;
            req.setAttribute("error",err);
        }
    }

    protected void editCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{
            String cusid = req.getParameter("cusid");
            String cusfname = req.getParameter("cusfname");
            String cuslname = req.getParameter("cuslname");
            String cusphone = req.getParameter("cusphone");
            String cusmail = req.getParameter("cusmail");
            String cusaddress = req.getParameter("cusaddress");
            String cuspwd = req.getParameter("cuspwd");

            CustomerEntity newcustomer = new CustomerEntity();
            newcustomer.setCustomerId(Integer.parseInt(cusid));
            newcustomer.setCustomerFName(cusfname);
            newcustomer.setCustomerLName(cuslname);
            newcustomer.setCustomerPhone(cusphone);
            newcustomer.setCustomerMail(cusmail);
            newcustomer.setCustomerAddress(cusaddress);
            newcustomer.setCustomerPwd(cuspwd);
            customerService.update(newcustomer);

        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get products due to: " + ex;
            req.setAttribute("error",err);
        }
    }
    protected void banCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{
            String cusid = req.getParameter("cusid");
            CustomerEntity newcustomer = new CustomerEntity();
            newcustomer.setCustomerId(Integer.parseInt(cusid));
            newcustomer.setActivated(0);
            customerService.update(newcustomer);
        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get products due to: " + ex;
            req.setAttribute("error",err);
        }
    }
    protected void activeCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try{
            String cusid = req.getParameter("cusid");
            CustomerEntity newcustomer = new CustomerEntity();
            newcustomer.setCustomerId(Integer.parseInt(cusid));
            newcustomer.setActivated(1);
            customerService.update(newcustomer);
        }catch (Exception ex){
            ex.printStackTrace();
            String err = "Error can not get products due to: " + ex;
            req.setAttribute("error",err);
        }
    }
}

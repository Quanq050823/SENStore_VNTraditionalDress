package Controller;

import Service.OrderService;
import Service.impl.OrderServiceImpl;
import model.OrderEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.awt.print.PrinterGraphics;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@WebServlet(urlPatterns = "/login")
public class    LoginController extends HttpServlet {

    OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = "/FE/login.jsp";
        String message = null;
        String action = req.getParameter("action");
        if (action.equals("login")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String remember = req.getParameter("remember");
            if (username.equals("admin") && password.equals("1234")) {
                HttpSession session = req.getSession();
                session.setAttribute("admin",username);
                if (remember != null)
                {
                    // add a cookie that stores the user's email to browser
                    Cookie c = new Cookie("emailCookie", username);
                    c.setPath("/");
                    c.setMaxAge(60 * 60 * 24 * 365 * 3); // set age to 2 years
                    resp.addCookie(c);
                    url = "/order";
                }
                else
                {
                    url = "/order";
                }
            } else {
                message = "Invalid Login Information!";
                req.getRequestDispatcher("/FE/login.jsp").forward(req, resp);
            }
        }
        req.setAttribute("message", message);
        getServletContext()
                .getRequestDispatcher(url)
                .forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}

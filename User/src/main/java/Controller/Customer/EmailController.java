package Controller.Customer;

import Service.CustomerService;
import Service.impl.CustomerServiceImpl;
import model.CustomerEntity;

import javax.mail.MessagingException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = "/email", name = "EmailServlet")
public class EmailController extends HttpServlet {
    CustomerService customerService = new CustomerServiceImpl();
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("SQL");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/forgetpass.jsp";
        String action = request.getParameter("action");

        if (action.equals("forgetpass")){
            url = forgetpass(request, response);
        }
        else if (action.equals("verifyOTP")){
            url = verifyOTP(request, response);
        }
        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }
    protected String forgetpass (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String useremail = request.getParameter("email");
        String url;
        String numbers = "0123456789";
        Random rndm_method = new Random();
        char length = 6;
        char[] otp = new char[length];
        for (int i = 0; i < length; i++) {
            otp[i] = numbers.charAt(rndm_method.nextInt(numbers.length()));
        }
        String OTP = new String(otp);

        String to = useremail;
        String from = "sen@store.com";
        String subject = "[SEN STORE] - Change Password";
        String body =
                "<h1 style=\"color: #633b00\">Sen</h1>\n" +
                        "<h2 style=\"color: #633b00\">Setup password</h2>\n" +
                        "<p>Enter the OTP code below to continue setting up your account password at SEN STORE: " + "<h2 style=\"color: #2bbb8e\">" + OTP + "</h2>\n" + "\n\nIf you do not request a password change, please delete this email for information security.\n" +
                        "</p>\n" +
                        "<p>If you have any questions, don't hesitate to contact us at:\n" +
                        "\t<a href=\"mailto:quangcuatuonglai@gmail.com\" style=\"font-size:14px;text-decoration:none;color:#1666a2\" target=\"_blank\">quangcuatuonglai@gmail.com</a></p>";

        boolean isBodyHTML = true;
        String message = null;

        CustomerEntity account = customerService.findByEmail(useremail);
        if (account == null)
        {
            message = "Sorry, your email isn't exist in our Store!";
            url = "/forgetpass.jsp";
        }
        else {
            try {
                transaction.begin();
                account.setCustomerOTP(OTP);
                entityManager.merge(account);
                transaction.commit();
            }
            finally {
                if (transaction.isActive()) {
                    transaction.rollback();
                    url = "/forgetpass.jsp";
                }
                else
                {
                    url = "/verify.jsp";
                }
                entityManager.close();
                entityManagerFactory.close();
            }
            try {
                util.MailUtilGmail.sendMail(to, from, subject, body,
                        isBodyHTML);
            } catch (MessagingException e) {
                String errorMessage
                        = "ERROR: Unable to send email. "
                        + "Check Tomcat logs for details.<br>"
                        + "NOTE: You may need to configure your system "
                        + "as described in chapter 14.<br>"
                        + "ERROR MESSAGE: " + e.getMessage();
                request.setAttribute("errorMessage", errorMessage);
                this.log(
                        "Unable to send email. \n"
                                + "Here is the email you tried to send: \n"
                                + "=====================================\n"
                                + "TO: " + useremail + "\n"
                                + "FROM: " + from + "\n"
                                + "SUBJECT: " + subject + "\n\n"
                                + body + "\n\n");
            }
            url = "/verify.jsp";
        }
        request.setAttribute("message", message);
        request.setAttribute("useremail", useremail);
        return url;
    }


    protected String verifyOTP (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url;
        String message = null;
        url = "/verify.jsp";
        String email = request.getParameter("email");
        CustomerEntity account = customerService.findByEmail(email);
        if (account == null)
        {
            email = request.getParameter("email");
            url = "/verify.jsp";
        }
        else {
            String opt01 = request.getParameter("opt01");
            String opt02 = request.getParameter("opt02");
            String opt03 = request.getParameter("opt03");
            String opt04 = request.getParameter("opt04");
            String opt05 = request.getParameter("opt05");
            String opt06 = request.getParameter("opt06");
            String inputOTP = opt01+opt02+opt03+opt04+opt05+opt06;

            String trueOTP = account.getCustomerOTP();
            if (inputOTP.equals(trueOTP)) {
                url = "/changepass.jsp";
            }
            else
            {
                message = "Sorry, your OTP is not valid!";
            }
        }
        request.setAttribute("message", message);
        request.setAttribute("useremail", email);
        return url;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

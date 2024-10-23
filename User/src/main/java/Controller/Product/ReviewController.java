package Controller.Product;

import Service.ProductService;
import Service.ReviewService;
import Service.impl.ProductServiceImpl;
import Service.impl.ReviewServiceImpl;
import model.CustomerEntity;
import model.ProductEntity;
import model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/review", name = "ReviewServlet")
public class ReviewController extends HttpServlet {
    
    ReviewService reviewService = new ReviewServiceImpl();
    ProductService productService = new ProductServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equalsIgnoreCase("getReview")){
            getReview(req,resp);
            req.getRequestDispatcher("/product-detail.jsp").forward(req, resp);
        }
        else if (action.equalsIgnoreCase("addReview")){
            addReview(req,resp);
            req.getRequestDispatcher("product?action=getDetails").forward(req, resp);
        }
    }
    
    protected void addReview(HttpServletRequest req, HttpServletResponse resp)
            throws  IOException,ServletException{
        HttpSession session= req.getSession();
        int productId = Integer.parseInt(req.getParameter("productId"));
        req.setAttribute("product",productId);
        ProductEntity currProduct = productService.findById(productId);
        CustomerEntity customerEntity = (CustomerEntity) session.getAttribute("user");
        
        String content = req.getParameter("reviewContent");
        int rating = Integer.parseInt(req.getParameter("rating"));
        
        ReviewService reviewService = new ReviewServiceImpl();
        Review review = new Review(content,customerEntity,currProduct,rating-1);
        reviewService.insert(review);
        
        req.setAttribute("productId",productId);
        
    }
    
    public static void getReview(HttpServletRequest req, HttpServletResponse resp)
            throws  IOException,ServletException{
        HttpSession session= req.getSession();
        ProductEntity currProduct = (ProductEntity) req.getAttribute("product");
        ReviewService reviewService = new ReviewServiceImpl();
        List<Review> reviews = reviewService.findByProductId(currProduct.getProductId());
    
        boolean isLogged = false;
        boolean isBought = false;
        String message = "You must logged in to give a comment.";
        if (session.getAttribute("user") !=null){
            message = "You must bought the product before give a review.";
            isLogged= true;
            CustomerEntity customerEntity = (CustomerEntity) session.getAttribute("user");
            isBought = reviewService.isBought(customerEntity, currProduct);
            if (isBought){
                message ="";
            }
        }
        
        req.setAttribute("isLogged", isLogged);
        req.setAttribute("isBought", isBought);
        req.setAttribute("reviewMessage", message);
        req.setAttribute("reviews", reviews);
        
    }
    
}

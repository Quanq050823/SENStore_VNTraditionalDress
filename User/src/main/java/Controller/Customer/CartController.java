package Controller.Customer;

import JpaConfig.JpaConfig;
import Service.CartItemService;
import Service.CartService;
import Service.CustomerService;
import Service.ProductService;
import Service.impl.CartItemServiceImpl;
import Service.impl.CartServiceImpl;
import Service.impl.CustomerServiceImpl;
import Service.impl.ProductServiceImpl;
import model.Cart;
import model.CartItem;
import model.CustomerEntity;
import model.ProductEntity;

import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.parser.Entity;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/cart", name = "CartServlet")
public class CartController extends HttpServlet {
    CustomerService customerService = new CustomerServiceImpl();
    CartService cartService = new CartServiceImpl();
    CartItemService cartItemService = new CartItemServiceImpl();
    ProductService productService = new ProductServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String url = "/shopping-cart.jsp";
        
        if (session.getAttribute("user") == null){
            url = "/login.jsp";
            req.getRequestDispatcher(url).forward(req, resp);
        };
        
        String action = req.getParameter("action");
        String src = req.getParameter("src");
        if (action == null || action.equalsIgnoreCase("")) action = "getCart";
        if (action.equalsIgnoreCase("getCart")){
            getCart(req, resp);
        }
        else if (action.equalsIgnoreCase("addCart")){
            addCart(req,resp);
            if (req.getParameter("src") != null) url = "product?action=getDetails";
        }
        else if (action.equalsIgnoreCase("getDetails")){
            getCart(req,resp);
        }
        else if (action.equalsIgnoreCase("removeCart")){
            removeCart(req, resp);
        }
        req.getRequestDispatcher(url).forward(req, resp);
    }
    
    public static void getCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            CustomerService customerService = new CustomerServiceImpl();
            CartService cartService = new CartServiceImpl();
            CartItemService cartItemService = new CartItemServiceImpl();
    
            CustomerEntity customerEntity = (CustomerEntity) session.getAttribute("user");
    
            Cart cart = cartService.findByCustomerId(customerEntity.getCustomerId());
            List<CartItem> cartItemList = cartItemService.findByCartId(cart.getCartId());
            session.setAttribute("cart",cartItemList);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            req.setAttribute("error","Error: "+ ex.getMessage());
        }
    }
    
    protected void addCart(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String productName = req.getParameter("productName");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int size = Integer.parseInt(req.getParameter("size"));
        int color = Integer.parseInt(req.getParameter("color"));
        
        HttpSession session = req.getSession();
        CustomerEntity customerEntity = (CustomerEntity) session.getAttribute("user");
        
        Cart cart = cartService.findByCustomerId(customerEntity.getCustomerId());
        
        ProductEntity modifiedProduct = productService.findByColorSize(productName, size, color);
        CartItem cartProduct = cartItemService.findItemInCart(cart.getCartId(), modifiedProduct);
    
        //Check Stock before adding
        if (quantity > modifiedProduct.getProductInventory()){
            String message = "Product quantity is greater than inventory left! ("
                            + modifiedProduct.getProductInventory() + " left)";
            req.setAttribute("notEnough",true);
            req.setAttribute("notEnoughMessage",message);
            return;
        }
        else {
            req.setAttribute("notEnough",false);
        }
        
        // If product existed then increase quantity, else add product to cart
        if (cartProduct != null){
            cartProduct.setCartItemQuantity(cartProduct.getCartItemQuantity() + quantity);
            cartProduct.setCartItemUnitPrice(cartProduct.getCartItemQuantity() * cartProduct.getProduct().getProductPrice() );
            if (cartProduct.getCartItemQuantity() <= 0){
                cartItemService.delete(cartProduct.getCartItemId());
            }
            else{
                cartItemService.update(cartProduct);
                
                // Reduce the number of the product in stock
                modifiedProduct.setProductInventory(modifiedProduct.getProductInventory() - quantity);
                productService.update(modifiedProduct);
            }
        }
        else {
            cartProduct = new CartItem(cart, modifiedProduct, quantity, modifiedProduct.getProductPrice()*quantity);
            cartItemService.insert(cartProduct);
            
            // Reduce the number of the product in stock
            modifiedProduct.setProductInventory(modifiedProduct.getProductInventory() - quantity);
            productService.update(modifiedProduct);
        }
       
    }
    
    protected void removeCart(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
        CartItem cartItem = cartItemService.findById(cartItemId);
        
        //back to stock
        ProductEntity productEntity = productService.findById(cartItem.getProduct().getProductId());
        productEntity.setProductInventory(productEntity.getProductInventory() + cartItem.getCartItemQuantity());
        productService.update(productEntity);
        
        cartItemService.delete(cartItemId);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}


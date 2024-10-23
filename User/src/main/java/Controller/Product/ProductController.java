package Controller.Product;

import Service.CategoryService;
import Service.ImageService;
import Service.ProductService;
import Service.impl.CategoryServiceImpl;
import Service.impl.ImageServiceImpl;
import Service.impl.ProductServiceImpl;
import model.CategoryEntity;
import model.ImageEntity;
import model.ProductEntity;
import model.Review;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.Console;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/product", name = "ProductListServlet")
public class ProductController extends HttpServlet {
    
    ProductService productService = new ProductServiceImpl();
    CategoryService categoryService = new CategoryServiceImpl();
    ImageService imageService = new ImageServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String action = req.getParameter("action");
        if (action.equalsIgnoreCase("getShop")){
            getShop(req, resp);
            req.getRequestDispatcher("/product.jsp").forward(req, resp);
        }
        
        else if (action.equalsIgnoreCase("getDetails")){
            getDetails(req, resp);
            req.getRequestDispatcher("/product-detail.jsp").forward(req, resp);
        }
        else if (action.equalsIgnoreCase("searchByPrice")){
            searchByPrice(req,resp);
            req.getRequestDispatcher("/product.jsp").forward(req,resp);
        }
        else if (action.equalsIgnoreCase("searchByKeyword"))
        {
            searchByKeyword(req,resp);
            req.getRequestDispatcher("/product.jsp").forward(req,resp);
        }
        else if (action.equalsIgnoreCase("filter"))
        {
            filterByOrder(req,resp);
            req.getRequestDispatcher("/product.jsp").forward(req,resp);
        }
    }
    
    protected void getShop(HttpServletRequest req, HttpServletResponse resp)
            throws  IOException,ServletException{
        try {
            List<ProductEntity> productList = productService.findAllDistinct();
            List<CategoryEntity> categoryList = categoryService.findAllByActivated();
            req.setAttribute("categoryList",categoryList);
            req.setAttribute("productList", productList);
            List<Integer> productIds = productService.productIdList(productList);
            req.setAttribute("productIds",productIds);
        }catch (Exception ex){
            ex.printStackTrace();
            req.setAttribute("error","Error: "+ ex.getMessage());
        }
    }
    
    protected void getDetails(HttpServletRequest req, HttpServletResponse resp)
            throws  IOException,ServletException{
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            ProductEntity productEntity = productService.findById(productId);
            List<ImageEntity> itemImages = productEntity.getImages();
        
            if (productEntity.getProductInventory() == 0){
                req.setAttribute("isOutOfStock",true);
            }
            
            if (productEntity != null){
                req.setAttribute("product", productEntity);
                req.setAttribute("itemImages",itemImages);
                ReviewController.getReview(req, resp);
            }
            else {
                String message = "Error item not found";
                req.setAttribute("error",message);
            }
        }catch (Exception ex){
            ex.printStackTrace();
            req.setAttribute("error","Error: "+ ex.getMessage());
        }
    }
    protected void searchByPrice(HttpServletRequest req, HttpServletResponse resp)throws IOException,ServletException{
        try{
            float start = Float.parseFloat(req.getParameter("start"));
            float end = Float.parseFloat(req.getParameter("end"));
            List<ProductEntity> productEntityList = productService.searchByPrice(start,end);
            List<Integer> productIds = productService.productIdList(productEntityList);
            req.setAttribute("productList",productEntityList);
            req.setAttribute("productIds",productIds);
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            req.setAttribute("error","Error"+ex.getMessage());
        }
    }
    protected void searchByKeyword(HttpServletRequest req,HttpServletResponse resp) throws IOException,ServletException{
        try{
            String keyword = req.getParameter("keyword");
            List<ProductEntity> productEntityList = productService.searchByKeyword(keyword);
            List<Integer> productIds = productService.productIdList(productEntityList);
            req.setAttribute("productList",productEntityList);
            req.setAttribute("productIds",productIds);
        }catch (Exception ex)
        {
            ex.printStackTrace();
            req.setAttribute("error","Error"+ex.getMessage());
        }
    }
    protected void filterByOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException{
        try{
            String[] productIdsArray = req.getParameterValues("productIds");
            List<Integer> productIds = new ArrayList<>();
            for (int i=0; i<productIdsArray.length; i++){
                productIds.add(Integer.parseInt(productIdsArray[i]));
            }
            String flag = req.getParameter("flag");
            List<ProductEntity> productEntityList =productService.filterProductByOrder(productIds,flag);
            List<Integer> productIdList = productService.productIdList(productEntityList);
            req.setAttribute("productList",productEntityList);
            req.setAttribute("productIds",productIdList);
        }catch (Exception ex)
        {
            ex.printStackTrace();
            req.setAttribute("error","Error"+ex.getMessage());
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

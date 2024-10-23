package Service;

import model.CartItem;
import model.CustomerEntity;
import model.ProductEntity;
import model.Review;

import java.util.List;

public interface ReviewService {
    void insert(Review review);
    
    void update(Review review);
    
    void delete(int reviewId) throws Exception;
    
    Review findById(int reviewId);
    
    List<Review> findByProductId(int productId);
    
    boolean isBought(CustomerEntity customer, ProductEntity product) ;
    
    List<Review> findAll();
}

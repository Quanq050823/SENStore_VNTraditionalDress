package Service;

import model.Cart;
import model.CategoryEntity;

public interface CartService {
    void insert(Cart cart);
    
    void update(Cart cart);
    
    Cart findById(int cartId);
    
    Cart findByCustomerId(int customerId);
}

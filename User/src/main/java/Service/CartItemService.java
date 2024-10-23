package Service;

import model.Cart;
import model.CartItem;
import model.ProductEntity;

import java.util.List;

public interface CartItemService {
    void insert(CartItem cartItem);
    
    void update(CartItem cartItem);
    
    void delete(long cartItemID);
    
    CartItem findById(long cartItemId);
    
    List<CartItem> findAll();
    
    List<CartItem> findAll(int page, int pagesize);
    
    List<CartItem> findByCartId(long cartId);
    
    List<CartItem> findAllByActivated();
    
    CartItem findItemInCart(long cartId, ProductEntity productEntity);
    
    int count();
}

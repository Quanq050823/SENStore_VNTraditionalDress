package model;

import javax.persistence.*;

@Entity
public class CartItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cartItemId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "cartId")
    private Cart shoppingCart;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId")
    private ProductEntity product;
    private int cartItemQuantity;
    private double cartItemUnitPrice;

    public CartItem( Cart shoppingCart, ProductEntity product, int cartItemQuantity, double cartItemUnitPrice) {
        this.shoppingCart = shoppingCart;
        this.product = product;
        this.cartItemQuantity = cartItemQuantity;
        this.cartItemUnitPrice = cartItemUnitPrice;
    }
    
    public CartItem() {

    }

    public Long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Cart getShoppingCart() {
        return shoppingCart;
    }

    public void setShoppingCart(Cart shoppingCart) {
        this.shoppingCart = shoppingCart;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public int getCartItemQuantity() {
        return cartItemQuantity;
    }

    public void setCartItemQuantity(int cartItemQuantity) {
        this.cartItemQuantity = cartItemQuantity;
    }

    public double getCartItemUnitPrice() {
        return cartItemUnitPrice;
    }

    public void setCartItemUnitPrice(double cartItemUnitPrice) {
        this.cartItemUnitPrice = cartItemUnitPrice;
    }
}

package model;

import javax.persistence.*;

@Entity
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long oderDetailId;
    int orderDetailQuantity;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "orderId")
    private OrderEntity order;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId")
    private ProductEntity product;
    public OrderDetail() {
    }
    
    public OrderDetail(Long oderDetailId, int orderDetailQuantity, OrderEntity order, ProductEntity product) {
        this.oderDetailId = oderDetailId;
        this.orderDetailQuantity = orderDetailQuantity;
        this.order = order;
        this.product = product;
    }
    
    public Long getOderDetailId() {
        return oderDetailId;
    }

    public void setOderDetailId(Long oderDetailId) {
        this.oderDetailId = oderDetailId;
    }
    
    public int getOrderDetailQuantity() {
        return orderDetailQuantity;
    }
    
    public void setOrderDetailQuantity(int orderDetailQuantity) {
        this.orderDetailQuantity = orderDetailQuantity;
    }
    
    public OrderEntity getOrder() {
        return order;
    }

    public void setOrder(OrderEntity order) {
        this.order = order;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }
    
}

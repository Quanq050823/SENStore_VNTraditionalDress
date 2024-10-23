package model;

import javax.persistence.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Entity
public class OrderEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;
    private Date orderDate; // Auto create when create object
    private Date orderDeliveryDate;
    private float orderTotal;
    private float orderDiscount;
    private float orderShipping;
    private String orderStatus; //Cancel, Shipping and Complete
    private boolean isAccepted; // default is false
    private String orderPaymentMethod;
    private String shippingAddress; //default is customerAddress
    
    @ManyToOne
    @JoinColumn(name = "customerId")
    private CustomerEntity customer;
    @OneToMany(cascade = CascadeType.MERGE, mappedBy = "order",fetch = FetchType.EAGER)
    private List<OrderDetail> orderDetailList;

    //  Auto generate orderDate, orderStatus, isAccepted default is false
    public OrderEntity() {
        LocalDateTime ldt = LocalDateTime.now();
        this.orderDate = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
        this.isAccepted = false;
    }

    public OrderEntity(int orderId, Date orderDate, Date orderDeliveryDate, float orderTotal, float orderDiscount, String orderStatus, boolean isAccepted, String orderPaymentMethod, CustomerEntity customer, List<OrderDetail> orderDetailList) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.orderDeliveryDate = orderDeliveryDate;
        this.orderTotal = orderTotal;
        this.orderDiscount = orderDiscount;
        this.orderStatus = orderStatus;
        this.isAccepted = isAccepted;
        this.orderPaymentMethod = orderPaymentMethod;
        this.customer = customer;
        this.orderDetailList = orderDetailList;
    }

    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public Date getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    
    public Date getOrderDeliveryDate() {
        return orderDeliveryDate;
    }
    
    public void setOrderDeliveryDate(Date orderDeliveryDate) {
        this.orderDeliveryDate = orderDeliveryDate;
    }
    
    public float getOrderTotal() {
        return orderTotal;
    }
    
    public void setOrderTotal(float orderTotal) {
        this.orderTotal = orderTotal;
    }
    
    public float getOrderDiscount() {
        return orderDiscount;
    }
    
    public void setOrderDiscount(float orderDiscount) {
        this.orderDiscount = orderDiscount;
    }
    
    public float getOrderShipping() {
        return orderShipping;
    }
    
    public void setOrderShipping(float orderShipping) {
        this.orderShipping = orderShipping;
    }
    
    public String getOrderStatus() {
        return orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public boolean isAccepted() {
        return isAccepted;
    }
    
    public void setAccepted(boolean accepted) {
        isAccepted = accepted;
    }
    
    public String getOrderPaymentMethod() {
        return orderPaymentMethod;
    }
    
    public void setOrderPaymentMethod(String orderPaymentMethod) {
        this.orderPaymentMethod = orderPaymentMethod;
    }
    
    public CustomerEntity getCustomer() {
        return customer;
    }
    
    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }


    public List<OrderDetail> getOrderDetailList() {
        return orderDetailList;
    }

    public void setOrderDetailList(List<OrderDetail> orderDetailList) {
        this.orderDetailList = orderDetailList;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
}

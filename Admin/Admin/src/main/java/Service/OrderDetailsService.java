package Service;

import model.OrderDetail;

import java.util.List;

public interface OrderDetailsService {
    
    void update(OrderDetail order);
    
    OrderDetail findById(long orderDetailId);
    
    List<OrderDetail> findByOrderId (int orderId);
    
    List<OrderDetail> findAll();
    
    List<OrderDetail> findByCustomerId(int customerId);
    
    int count();
    
}

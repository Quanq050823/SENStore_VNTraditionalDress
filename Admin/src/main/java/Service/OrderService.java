package Service;

import model.OrderEntity;

import java.util.List;

public interface OrderService {
    void update(OrderEntity order);

    OrderEntity findById(int orderId);
    
    List<OrderEntity> findByCustomerId(int customerId);

    List<OrderEntity> findAll();

    int count();
}

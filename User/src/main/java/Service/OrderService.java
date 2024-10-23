package Service;

import model.OrderDetail;
import model.OrderEntity;
import org.hibernate.criterion.Order;

import java.util.List;

public interface OrderService {
    void create(OrderEntity order);
    
    void update(OrderEntity order);

    void delete(int orderId) throws Exception;

    OrderEntity findById(int orderId);
    
    List<OrderEntity> findByCustomerId(int customerId);

    List<OrderEntity> findAll();

    int count();
}

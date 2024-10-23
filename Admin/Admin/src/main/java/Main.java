import JPAConfig.JPAConfig;
import Service.OrderService;
import Service.impl.OrderServiceImpl;
import model.OrderEntity;
import org.hibernate.criterion.Order;

import javax.persistence.EntityManager;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        OrderService orderService = new OrderServiceImpl();
        List<OrderEntity> orders = orderService.findAll();
        for (OrderEntity order:orders){
            System.out.println(order.getOrderId());
        }
    }
}

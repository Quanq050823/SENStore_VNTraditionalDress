package Service.impl;

import JPAConfig.JPAConfig;
import Service.OrderDetailsService;
import model.OrderDetail;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailsService {
    
    @Override
    public void update(OrderDetail order) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.merge(order);
            trans.commit();
        }catch (Exception ex)
        {
            ex.printStackTrace();
            trans.rollback();
            throw ex;
        }finally {
            enma.close();
        }
    }
    
    @Override
    public OrderDetail findById(long orderDetailId) {
        return JPAConfig.getEntityManager().find(OrderDetail.class, orderDetailId);
    }
    
    @Override
    public List<OrderDetail> findByOrderId(int orderId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderDetail o WHERE o.order.id = :id";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        query.setParameter("id", orderId);
        return query.getResultList();
    }
    
    @Override
    public List<OrderDetail> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderDetail o ";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        return query.getResultList();
    }
    
    @Override
    public List<OrderDetail> findByCustomerId(int customerId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderDetail o where o.order.customer.customerId = :id";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        query.setParameter("id", customerId);
        return query.getResultList();
    }
    
    @Override
    public int count() {
        return 0;
    }
}

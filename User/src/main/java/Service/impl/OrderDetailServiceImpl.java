package Service.impl;

import JpaConfig.JpaConfig;
import Service.OrderDetailsService;
import model.OrderDetail;
import model.OrderEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailsService {
    
    @Override
    public void create(OrderDetail order) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(order);
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
    public void update(OrderDetail order) {
        EntityManager enma = JpaConfig.getEntityManager();
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
        return JpaConfig.getEntityManager().find(OrderDetail.class, orderDetailId);
    }
    
    @Override
    public List<OrderDetail> findByOrderId(int orderId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderDetail o WHERE o.order.id = :id";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        query.setParameter("id", orderId);
        return query.getResultList();
    }
    
    @Override
    public List<OrderDetail> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderDetail o ";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        return query.getResultList();
    }
    
    @Override
    public List<OrderDetail> findByCustomerId(int customerId) {
        EntityManager enma = JpaConfig.getEntityManager();
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

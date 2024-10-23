package Service.impl;

import JPAConfig.JPAConfig;
import Service.OrderService;
import model.OrderEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    
    @Override
    public void update(OrderEntity order)
    {
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
    public OrderEntity findById(int orderId)
    {
        EntityManager enma = JPAConfig.getEntityManager();
        return enma.find(OrderEntity.class,orderId);
    }
    
    @Override
    public List<OrderEntity> findByCustomerId(int customerId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderEntity o where o.customer.id = :id";
        TypedQuery<OrderEntity> query = enma.createQuery(jpql, OrderEntity.class);
        query.setParameter("id",customerId);
        return query.getResultList();
    }
    
    @Override
    public List<OrderEntity> findAll(){
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderEntity o ";
        TypedQuery<OrderEntity> query = enma.createQuery(jpql, OrderEntity.class);
        return query.getResultList();
    }
    
    @Override
    public int count(){
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT count(o) FROM OrderEntity o";
        Query query = enma.createQuery(jpql);
        return ((Long)query.getSingleResult()).intValue();

    }
}

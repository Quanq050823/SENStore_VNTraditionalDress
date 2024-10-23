package Service.impl;

import JpaConfig.JpaConfig;
import Service.OrderService;
import model.OrderEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    @Override
    public void create(OrderEntity order) {
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
    public void update(OrderEntity order)
    {
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
    public void delete(int orderId) throws Exception
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
           OrderEntity order = enma.find(OrderEntity.class,orderId);
            if(order!=null)
            {
                enma.remove(order);
            }
            else{
                throw new Exception("Cant find category");
            }
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
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(OrderEntity.class,orderId);
    }
    
    @Override
    public List<OrderEntity> findByCustomerId(int customerId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderEntity o where o.customer.id = :id";
        TypedQuery<OrderEntity> query = enma.createQuery(jpql, OrderEntity.class);
        query.setParameter("id",customerId);
        return query.getResultList();
    }
    
    @Override
    public List<OrderEntity> findAll(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT o FROM OrderEntity o ";
        TypedQuery<OrderEntity> query = enma.createQuery(jpql, OrderEntity.class);
        return query.getResultList();
    }
    @Override
    public int count(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(o) FROM OrderEntity o";
        Query query = enma.createQuery(jpql);
        return ((Long)query.getSingleResult()).intValue();

    }
}

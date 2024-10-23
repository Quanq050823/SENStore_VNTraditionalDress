package Service.impl;

import JpaConfig.JpaConfig;
import Service.OrderDetailsService;
import Service.OrderService;
import Service.ReviewService;
import model.*;
import org.hibernate.criterion.Order;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class ReviewServiceImpl implements ReviewService {
    @Override
    public void insert(Review review) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(review);
            trans.commit();
        }catch (Exception ex){
            ex.printStackTrace();
            trans.rollback();
            throw ex;
        }finally {
            enma.close();
        }
    }
    
    @Override
    public void update(Review review) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(review);
            trans.commit();
        }catch (Exception ex){
            ex.printStackTrace();
            trans.rollback();
            throw ex;
        }finally {
            enma.close();
        }
    }
    
    @Override
    public void delete(int reviewId) throws Exception{
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            Review review = enma.find(Review.class,reviewId);
            if(review!=null)
            {
                enma.remove(review);
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
    public Review findById(int reviewId) {
        return JpaConfig.getEntityManager().find(Review.class, reviewId);
    }
    
    @Override
    public List<Review> findByProductId(int productId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT o FROM Review o where o.product.productId = :id";
        TypedQuery<Review> query = enma.createQuery(jpql, Review.class);
        query.setParameter("id", productId);
        return query.getResultList();
    }
    
    @Override
    public boolean isBought(CustomerEntity customer, ProductEntity product) {
        EntityManager enma = JpaConfig.getEntityManager();
        OrderDetailsService orderDetailsService = new OrderDetailServiceImpl();
        String jpql = "SELECT o FROM OrderDetail o where o.order.customer.customerId = :id AND " +
                              "o.product.productName = :pname AND o.order.orderStatus = :stat";
        TypedQuery<OrderDetail> query = enma.createQuery(jpql, OrderDetail.class);
        query.setParameter("id", customer.getCustomerId());
        query.setParameter("pname", product.getProductName());
        query.setParameter("stat","Complete");
        
        List<OrderDetail> resultList = query.getResultList();
        if (resultList.isEmpty()) return false;
        return true;
    }
    
    @Override
    public List<Review> findAll() {
        return null;
    }
}

package Service.impl;

import JpaConfig.JpaConfig;
import Service.CartService;
import Service.CustomerService;
import model.Cart;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

public class CartServiceImpl implements CartService {
    @Override
    public void insert(Cart cart) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(cart);
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
    public void update(Cart cart) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(cart);
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
    public Cart findById(int cartId) {
        return JpaConfig.getEntityManager().find(Cart.class, cartId);
    }
    
    @Override
    public Cart findByCustomerId(int customerId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Cart c where c.customer.customerId = :customerId";
        TypedQuery<Cart> query = enma.createQuery(jpql, Cart.class);
        query.setParameter("customerId", customerId);
        Cart result = query.getSingleResult(); // Retrieve the single result
        
        return result;
    }
}

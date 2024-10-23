package Service.impl;

import JpaConfig.JpaConfig;
import Service.CartItemService;
import model.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;

public class CartItemServiceImpl implements CartItemService {
    @Override
    public void insert(CartItem cartItem){
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(cartItem);
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
    public void update(CartItem cartItem) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(cartItem);
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
    public void delete(long cartItemId) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            CartItem product = enma.find(CartItem.class,cartItemId);
            /*enma.remove(product);*/
            
            String jpql = "DELETE  FROM CartItem where cartItemId = :id";
            Query query = enma.createQuery(jpql);
            query.setParameter("id",product.getCartItemId());
            int row = query.executeUpdate();
            
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
    public CartItem findById(long cartItemId) {
        return JpaConfig.getEntityManager().find(CartItem.class, cartItemId);
    }
    
    @Override
    public List<CartItem> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CartItem c";
        TypedQuery<CartItem> query = enma.createQuery(jpql, CartItem.class);
        return query.getResultList();
    }
    
    @Override
    public List<CartItem> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CartItem c";
        TypedQuery<CartItem> query = enma.createQuery(jpql, CartItem.class);
        query.setFirstResult(page*pagesize);
        query.setMaxResults(pagesize);
        return query.getResultList();
    }
    
    @Override
    public List<CartItem> findByCartId(long cartId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CartItem c WHERE c.shoppingCart.cartId = :cartId";
        TypedQuery<CartItem> query = enma.createQuery(jpql, CartItem.class);
        query.setParameter("cartId", cartId);
        return query.getResultList();
    }
    
    @Override
    public List<CartItem> findAllByActivated() {
        return null;
    }
    
    @Override
    public CartItem findItemInCart(long cartId, ProductEntity productEntity) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CartItem c WHERE c.shoppingCart.cartId = :cartId " +
                              "AND c.product = :product ";
        TypedQuery<CartItem> query = enma.createQuery(jpql, CartItem.class);
    
        query.setParameter("cartId", cartId);
        query.setParameter("product", productEntity);
        List<CartItem> list= query.getResultList();
        if (list.size() != 0){
            return list.get(0);
        }
        return null;
    }
    
    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(c) FROM CartItem c";
        Query query = enma.createQuery(jpql);
        return ((Long)query.getSingleResult()).intValue();
    }
}

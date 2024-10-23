package Service.impl;

import JpaConfig.JpaConfig;
import Service.CustomerService;
import model.CustomerEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

public class CustomerServiceImpl implements CustomerService {
    @Override
    public void insert(CustomerEntity customerEntity) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(customerEntity);
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
    public void update(CustomerEntity customerEntity) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(customerEntity);
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
    public CustomerEntity findById(int customerId) {
        return JpaConfig.getEntityManager().find(CustomerEntity.class, customerId);
    }
    
    @Override
    public CustomerEntity findByEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CustomerEntity c WHERE c.customerMail = :mail";
    
        TypedQuery<CustomerEntity> query = enma.createQuery(jpql, CustomerEntity.class);
        query.setParameter("mail", email);
        if (query.getResultList().stream().count() != 0) {
            return query.getSingleResult();
        }
        return null;
    }
    
    @Override
    public boolean checklogin(String customermail, String customerpwd) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CustomerEntity c WHERE c.customerMail = :mail and c.customerPwd = :pwd";
    
        TypedQuery<CustomerEntity> query = enma.createQuery(jpql, CustomerEntity.class);
        query.setParameter("mail", customermail);
        query.setParameter("pwd", customerpwd);
    
        if (query.getResultList().stream().count() != 0) {
            return true;
        }
        return false;
    }
}

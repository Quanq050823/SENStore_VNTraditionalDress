package Service.impl;

import JPAConfig.JPAConfig;
import Service.CustomerService;
import model.CustomerEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class CustomerServiceImpl implements CustomerService {

    @Override
    public void insert(CustomerEntity customer)
    {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(customer);
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
    public void update(CustomerEntity customer)
    {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.merge(customer);
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
    public void delete(int customerId) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            CustomerEntity customer = enma.find(CustomerEntity.class,customerId);
            enma.remove(customer);
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
    public CustomerEntity findById(int customerId)
    {
        EntityManager enma = JPAConfig.getEntityManager();
        return enma.find(CustomerEntity.class,customerId);
    }

    @Override
    public List<CustomerEntity> findAll(){
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT p FROM CustomerEntity p";
        TypedQuery<CustomerEntity> query = enma.createQuery(jpql, CustomerEntity.class);
        return query.getResultList();
    }
}

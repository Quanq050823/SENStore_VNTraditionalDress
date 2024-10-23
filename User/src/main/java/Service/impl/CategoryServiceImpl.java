package Service.impl;

import JpaConfig.JpaConfig;
import Service.CategoryService;
import model.CategoryEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.awt.print.Pageable;
import java.util.List;
public class CategoryServiceImpl implements CategoryService {
    @Override
    public void insert(CategoryEntity category)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(category);
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
    public void update(CategoryEntity category)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.merge(category);
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
    public void delete(int categoryId) throws Exception
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            CategoryEntity category = enma.find(CategoryEntity.class,categoryId);
            if(category!=null)
            {
                enma.remove(category);
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
    public CategoryEntity findById(int categoryId)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(CategoryEntity.class,categoryId);
    }
    @Override
    public List<CategoryEntity> findAll(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CategoryEntity c where c.isActivated = true";
        TypedQuery<CategoryEntity> query = enma.createQuery(jpql, CategoryEntity.class);
        return query.getResultList();
    }
    @Override
    public List<CategoryEntity> findAll(int page, int pagesize){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CategoryEntity c";
        TypedQuery<CategoryEntity> query = enma.createQuery(jpql, CategoryEntity.class);
        query.setFirstResult(page*pagesize);
        query.setMaxResults(pagesize);
        return query.getResultList();
    }
    @Override
    public List<CategoryEntity> findByCategoryName(String categoryName){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM CategoryEntity c WHERE c.categoryName like :categoryName";
        TypedQuery<CategoryEntity> query = enma.createQuery(jpql, CategoryEntity.class);
        query.setParameter("categoryName","%" + categoryName + "%");
        return query.getResultList();
    }
    @Override
    public List<CategoryEntity> findAllByActivated() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql="SELECT c FROM CategoryEntity c WHERE c.isActivated=true";
        TypedQuery<CategoryEntity> query = enma.createQuery(jpql,CategoryEntity.class);
        return query.getResultList();
    }

    @Override
    public int count(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(c) FROM CategoryEntity c";
        Query query = enma.createQuery(jpql);
        return ((Long)query.getSingleResult()).intValue();

    }

}

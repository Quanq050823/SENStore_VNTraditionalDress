package Service.impl;

import JpaConfig.JpaConfig;
import Service.ProductService;
import model.ColorEntity;
import model.ProductEntity;
import model.SizeEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ProductServiceImpl implements ProductService {

    @Override
    public void insert(ProductEntity product)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(product);
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
    public void update(ProductEntity product)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.merge(product);
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
    public void delete(int productId) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            ProductEntity product = enma.find(ProductEntity.class,productId);
            enma.remove(product);
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
    public ProductEntity findById(int productId)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(ProductEntity.class,productId);
    }
    
    @Override
    public List<ProductEntity> findAllDistinct() {
        EntityManager enma = JpaConfig.getEntityManager();
        ProductService productService = new ProductServiceImpl();
        String jpql = "SELECT distinct p.productName FROM ProductEntity p where p.isActivated=true";
        TypedQuery<String> query = enma.createQuery(jpql,String.class);
        
       List<String> nameList = query.getResultList();
       List<ProductEntity> productEntityList = new ArrayList<>();
       
       for (String name : nameList){
           productEntityList.add(productService.findByName(name).get(0));
       }
        return  productEntityList;
    }
    
    @Override
    public ProductEntity findByColorSize(String productName, int sizeId, int colorId) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p WHERE p.productName = :productName " +
                              "AND p.size.sizeId = :sizeId AND p.color.colorId = :colorId ";
        TypedQuery<ProductEntity> query = enma.createQuery(jpql,ProductEntity.class);
        query.setParameter("productName", productName);
        query.setParameter("sizeId", sizeId);
        query.setParameter("colorId", colorId);
        if (query.getSingleResult() == null ) return null;
        return query.getSingleResult();
    }
    
    @Override
    public ColorEntity findColorsById(int colorId) {
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(ColorEntity.class,colorId);
    }

    @Override
    public SizeEntity findSizeById(int sizeId) {
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(SizeEntity.class,sizeId);
    }

    @Override
    public List<ProductEntity> findAll(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p";
        TypedQuery<ProductEntity> query = enma.createQuery(jpql, ProductEntity.class);
        return query.getResultList();
    }

    @Override
    public List<ProductEntity> findByName(String productName) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p where p.productName like :productName";
        TypedQuery<ProductEntity> query = enma.createQuery(jpql,ProductEntity.class);
        query.setParameter("productName",productName);
        return query.getResultList();
    }

    @Override
    public List<ColorEntity> findAllColors() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM ColorEntity c";
        TypedQuery<ColorEntity> query = enma.createQuery(jpql,ColorEntity.class);
        return query.getResultList();
    }

    @Override
    public List<SizeEntity> findAllSizes() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT s FROM SizeEntity s";
        TypedQuery<SizeEntity> query = enma.createQuery(jpql,SizeEntity.class);
        return query.getResultList();
    }
    
    @Override
    public List<SizeEntity> findAllExistSize(String productName) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT distinct s.size FROM ProductEntity s where s.productName = :pName";
        TypedQuery<SizeEntity> query = enma.createQuery(jpql,SizeEntity.class);
        query.setParameter("pName",productName);
        return query.getResultList();
    }
    
    @Override
    public List<ColorEntity> findAllExistColor(String productName) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT distinct s.color FROM ProductEntity s where s.productName = :pName";
        TypedQuery<ColorEntity> query = enma.createQuery(jpql,ColorEntity.class);
        query.setParameter("pName",productName);
        return query.getResultList();
    }
    
    @Override
    public List<ProductEntity> findAllPage(int index) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p order by productName";
        TypedQuery<ProductEntity> query = entityManager.createQuery(jpql, ProductEntity.class);
        query.setFirstResult(index*6);
        query.setMaxResults(6);
        return query.getResultList();
    }

    @Override
    public List<ProductEntity> search(String keyword, int index) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p WHERE p.productName like :keyword or p.productStyle like :keyword ";
        TypedQuery<ProductEntity> query = entityManager.createQuery(jpql,ProductEntity.class);
        query.setParameter("keyword","%" + keyword +"%");
        query.setFirstResult(index*6);
        query.setMaxResults(6);
        return query.getResultList();
    }

    @Override
    public List<ProductEntity> searchByPrice(float start, float end) {
        EntityManager entityManager =  JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p WHERE p.productPrice >= :start and p.productPrice <= :end";
        TypedQuery<ProductEntity> query = entityManager.createQuery(jpql,ProductEntity.class);
        query.setParameter("start",start);
        query.setParameter("end",end);
        return query.getResultList();
    }

    @Override
    public List<Integer> productIdList(List<ProductEntity> productEntityList) {
        List<Integer> productIdList = new ArrayList<>();
        for(ProductEntity product : productEntityList)
        {
            productIdList.add(product.getProductId());
        }
        return productIdList;
    }

    @Override
    public List<ProductEntity> filterProductByOrder(List<Integer> productIds, String flag) {
        List<ProductEntity> productEntityList = new ArrayList<>();
        
        while (!productIds.isEmpty()) {
            int currPosition = 0;
            double max = 0;
            int index = 0;
            
            double min = 99999;
            ProductEntity product = new ProductEntity();
            if (Objects.equals(flag, "DESC")) {
                for (Integer item : productIds) {
                    index ++;
                    ProductEntity productDto = findById(item);
                    if (productDto.getProductPrice() > max) {
                        currPosition = index;
                        max = productDto.getProductPrice();
                        product = productDto;
                    }
                }
            }
            
            if(Objects.equals(flag, "ASC"))
            {
                for (Integer item : productIds) {
                    index ++;
                    ProductEntity productDto = findById(item);
                    if (productDto.getProductPrice() < min) {
                        currPosition = index;
                        min = productDto.getProductPrice();
                        product = productDto;
                    }
                }
            }
            productEntityList.add(product);
            productIds.remove(currPosition - 1);
        }
        return  productEntityList;
    }

    @Override
    public List<ProductEntity> searchByKeyword(String keyword) {
        EntityManager entityManager =  JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM ProductEntity p WHERE p.productName like :keyword or p.category.categoryName like :keyword or p.productStyle like :keyword";
        TypedQuery<ProductEntity> query = entityManager.createQuery(jpql,ProductEntity.class);
        query.setParameter("keyword",keyword);
        return query.getResultList();
    }

    @Override
    public int countSearch(String keyword) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT count(p) FROM ProductEntity p WHERE p.productName like :keyword or p.productStyle like :keyword";
        Query query = entityManager.createQuery(jpql);
        query.setParameter("keyword","%" + keyword +"%");
        return ((Long)query.getSingleResult()).intValue();
    }

    @Override
    public int count(){
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(p) FROM ProductEntity p";
        Query query = enma.createQuery(jpql);
        return ((Long)query.getSingleResult()).intValue();

    }
}

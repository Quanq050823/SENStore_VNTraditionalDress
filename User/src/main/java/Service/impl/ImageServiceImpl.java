package Service.impl;

import JpaConfig.JpaConfig;
import Service.ImageService;
import model.CategoryEntity;
import model.ImageEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

public class ImageServiceImpl implements ImageService {
    @Override
    public void insert(ImageEntity imageEntity)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.persist(imageEntity);
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
    public void update(ImageEntity imageEntity)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            enma.merge(imageEntity);
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
    public void delete(int imageId) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try{
            trans.begin();
            ImageEntity image = enma.find(ImageEntity.class,imageId);
            if(image!=null)
            {
                enma.remove(image);
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
    public ImageEntity findById(int imageId)
    {
        EntityManager enma = JpaConfig.getEntityManager();
        return enma.find(ImageEntity.class,imageId);
    }
}

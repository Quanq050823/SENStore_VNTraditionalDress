package Service;


import model.ColorEntity;
import model.ProductEntity;
import model.SizeEntity;

import java.util.List;

public interface ProductService {
    void insert(ProductEntity product);
    void update(ProductEntity product);
    void delete(int productId);
    
    ProductEntity findById(int productId);
    List<ProductEntity> findAll();
    List<ProductEntity> findAllDistinct();
    
    List<ProductEntity> findByName(String productName);
    
    ProductEntity findByColorSize(String productName, int sizeId,int colorId);
    
    SizeEntity findSizeById(int sizeId);
    ColorEntity findColorsById(int colorId);
    
    List<SizeEntity> findAllSizes();
    List<ColorEntity> findAllColors();
    
    List<SizeEntity> findAllExistSize(String productName);
    List<ColorEntity> findAllExistColor(String productName);
    
    List<ProductEntity> findAllPage(int index);
    
    List<ProductEntity> search(String keyword, int index);

    List<ProductEntity> searchByPrice(float start, float end);

    List<Integer> productIdList(List<ProductEntity> productEntityList);

    List<ProductEntity> filterProductByOrder(List<Integer> productIds,String flag);
    List<ProductEntity> searchByKeyword(String keyword);
    int countSearch(String keyword);
    int count();
}

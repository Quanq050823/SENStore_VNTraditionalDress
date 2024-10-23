package Service;

import model.CategoryEntity;
import model.ColorEntity;

import java.util.List;

public interface CategoryService {
    void insert(CategoryEntity category);

    void update(CategoryEntity category);

    void delete(int categoryId) throws Exception;

    CategoryEntity findById(int categoryId);

    List<CategoryEntity> findAll();

    List<CategoryEntity> findAll(int page, int pagesize);

    List<CategoryEntity> findByCategoryName(String categoryName);

    List<CategoryEntity> findAllByActivated();
    int count();
}

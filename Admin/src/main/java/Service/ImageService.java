package Service;

import model.ImageEntity;

public interface ImageService {
    void insert(ImageEntity imageEntity);

    void update(ImageEntity imageEntity);

    void delete(int categoryId) throws Exception;
    ImageEntity findById(int imageId);
}

 package model;

import javax.persistence.*;

@Entity
public class ImageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int imageId;
    @Lob
    @Column(columnDefinition = "MEDIUMBLOB")
    private String productImage;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId")
    private ProductEntity product;



    public ImageEntity() {

    }

    public ImageEntity(int imageId, String productImage, ProductEntity product) {
        this.imageId = imageId;
        this.productImage = productImage;
        this.product = product;
    }


    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }


    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}


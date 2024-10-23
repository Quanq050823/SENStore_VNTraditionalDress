package model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"productName"}))
public class ProductEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;
    private String productName;
    private String productDesc;
    private float productPrice;
    private float productRating;
    private int productInventory;
    boolean isActivated;
    private String productStyle;
    
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    private SizeEntity size;
    
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "colorId")
    private ColorEntity color;
    
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "categoryId")
    private CategoryEntity category;
    
    @OneToMany(mappedBy="product", cascade = CascadeType.MERGE)
    private List<ImageEntity> images;
    
    
    public ProductEntity() {
    }

    public ProductEntity(int productId, String productName, String productDesc, float productPrice, float productRating, int productInventory, boolean isActivated, SizeEntity size, ColorEntity color, CategoryEntity category, List<ImageEntity> images, String productStyle) {
        this.productId = productId;
        this.productName = productName;
        this.productDesc = productDesc;
        this.productPrice = productPrice;
        this.productRating = productRating;
        this.productInventory = productInventory;
        this.isActivated = isActivated;
        this.size = size;
        this.color = color;
        this.category = category;
        this.images = images;
        this.productStyle = productStyle;
    }


    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDesc() {
        return productDesc;
    }

    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public float getProductRating() {
        return productRating;
    }

    public void setProductRating(float productRating) {
        this.productRating = productRating;
    }

    public int getProductInventory() {
        return productInventory;
    }

    public void setProductInventory(int productInventory) {
        this.productInventory = productInventory;
    }

    public boolean isActivated() {
        return isActivated;
    }

    public void setActivated(boolean activated) {
        isActivated = activated;
    }

    public CategoryEntity getCategory() {
        return category;
    }

    public void setCategory(CategoryEntity category) {
        this.category = category;
    }

    public List<ImageEntity> getImages() {
        return images;
    }

    public void setImages(List<ImageEntity> images) {
        this.images = images;
    }

    public String getProductStyle() {
        return productStyle;
    }

    public void setProductStyle(String productStyle) {
        this.productStyle = productStyle;
    }
    
    public SizeEntity getSize() {
        return size;
    }
    
    public void setSize(SizeEntity size) {
        this.size = size;
    }
    
    public ColorEntity getColor() {
        return color;
    }
    
    public void setColor(ColorEntity color) {
        this.color = color;
    }
}

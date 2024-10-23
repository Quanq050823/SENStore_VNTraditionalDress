package model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = "categoryName"))
public class CategoryEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryId;
    private String categoryName;
    private boolean isActivated;

    public CategoryEntity(int categoryId, String categoryName, boolean isActivated) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.isActivated = isActivated;
    }

    public CategoryEntity() {
    }

    public boolean isActivated() {
        return isActivated;
    }
    
    public void setActivated(boolean isActivated) {
        this.isActivated = isActivated;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    
}

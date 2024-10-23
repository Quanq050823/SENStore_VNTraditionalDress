package Service;

import model.CartItem;
import model.CustomerEntity;

public interface CustomerService {
    void insert(CustomerEntity customerEntity);
    
    void update(CustomerEntity customerEntity);
    
    CustomerEntity findById(int customerId);
    
    CustomerEntity findByEmail(String email);
    boolean checklogin(String customermail, String customerpwd);
    
}

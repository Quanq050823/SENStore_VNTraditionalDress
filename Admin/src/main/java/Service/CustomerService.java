package Service;


import model.ColorEntity;
import model.CustomerEntity;
import model.ProductEntity;
import model.SizeEntity;

import java.util.List;

public interface CustomerService {
    void insert(CustomerEntity customer);
    void update(CustomerEntity customer);
    void delete(int customerid);
    
    CustomerEntity findById(int customerId);
    List<CustomerEntity> findAll();
}

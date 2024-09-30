package com.example.crud_api.services;

import com.example.crud_api.entity.Product;
import java.util.List;

public interface ProductService {
    Product createProduct(Product product);
    List<Product> getAllProducts();
    Product getProductById(int id);
    Product updateProduct(int id, Product product);
    void deleteProduct(int id);
}

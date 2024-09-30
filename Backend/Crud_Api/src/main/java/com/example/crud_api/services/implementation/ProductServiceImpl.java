package com.example.crud_api.services.implementation;

import com.example.crud_api.entity.Product;
import com.example.crud_api.repository.ProductRepository;
import com.example.crud_api.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;


    @Override
    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public Product getProductById(int id) {
        return productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Product not found")
        );
    }

    @Override
    public Product updateProduct(int id, Product product) {
        Product updatedProduct = productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Product not found")
        );

        updatedProduct.setProductName(product.getProductName());
        updatedProduct.setProductCode(product.getProductCode());
        updatedProduct.setImg(product.getImg());
        updatedProduct.setQty(product.getQty());
        updatedProduct.setUnitPrice(product.getUnitPrice());
        updatedProduct.setTotalPrice(product.getTotalPrice());

        return productRepository.save(updatedProduct);
    }

    @Override
    public void deleteProduct(int id) {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Product not found")
        );

        productRepository.deleteById(id);
    }
}

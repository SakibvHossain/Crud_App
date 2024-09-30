package com.example.crud_api.controllers;

import com.example.crud_api.entity.Product;
import com.example.crud_api.payloads.ApiResponse;
import com.example.crud_api.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("add_product")
    public ApiResponse<Product> addProduct(@RequestBody Product product) {
        return new ApiResponse<>("success", productService.createProduct(product));
    }

    @GetMapping("getAllProduct")
    public ApiResponse<Product> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return new ApiResponse<>("success", products);
    }

    @GetMapping("getProductByID/{id}")
    public ApiResponse<Product> getProductByID(@PathVariable Integer id) {
        return new ApiResponse<>("success", productService.getProductById(id));
    }

    @PutMapping("updateProduct/{id}")
    public ApiResponse<Product> updateProduct(@PathVariable Integer id, @RequestBody Product product) {
        return new ApiResponse<>("success", productService.updateProduct(id, product));
    }

    @DeleteMapping("deleteById/{id}")
    public ResponseEntity<String> deleteEmployeeByID(@PathVariable Integer id) {
        productService.deleteProduct(id);
        return new ResponseEntity<>("Product Deleted!", HttpStatus.OK);
    }
}

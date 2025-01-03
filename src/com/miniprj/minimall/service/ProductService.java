package com.miniprj.minimall.service;

import com.miniprj.minimall.dao.ProductDao;
import com.miniprj.minimall.model.ProductDto;

public class ProductService {
    private final ProductDao productDao;

    public ProductService() {
        productDao = new ProductDao();
    }

    public ProductDto getProductDetail(int prodId) {
        return productDao.getProductDetail(prodId);
    }
}

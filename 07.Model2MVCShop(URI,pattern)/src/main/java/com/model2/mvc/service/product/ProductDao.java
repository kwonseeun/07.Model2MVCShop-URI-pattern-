package com.model2.mvc.service.product;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {
	
	public Product findProduct(int no) throws SQLException;
	
	public List<Product> getProductList(Search search) throws Exception;

	public void insertProduct(Product product) throws Exception;
	
	public void updateProduct(Product product) throws SQLException;

	public void deleteProduct(int prodNo) throws SQLException;
	
	public int getTotalCount(Search search) throws Exception ;

}

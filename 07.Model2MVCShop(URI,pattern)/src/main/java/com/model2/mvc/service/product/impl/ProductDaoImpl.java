package com.model2.mvc.service.product.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl extends HttpServlet implements ProductDao{
      
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
    public ProductDaoImpl() {
    	
		System.out.println(this.getClass());
    }
    
    public Product findProduct(int no) throws SQLException {
    	
		return sqlSession.selectOne("ProductMapper.getProduct",no);
	}

	public List<Product> getProductList(Search search) throws Exception {
		
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	public void insertProduct(Product product) throws Exception {
		
		sqlSession.insert("ProductMapper.addProduct", product);
	}

	public void updateProduct(Product product) throws SQLException {

		sqlSession.update("ProductMapper.updateProduct", product);
	}

	public void deleteProduct(int prodNo) throws SQLException {

		sqlSession.delete("ProductMapper.deleteProduct", prodNo);
	}

	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	

}
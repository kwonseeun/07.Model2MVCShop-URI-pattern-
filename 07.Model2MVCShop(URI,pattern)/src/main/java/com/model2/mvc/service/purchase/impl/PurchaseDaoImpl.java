package com.model2.mvc.service.purchase.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDaoImpl() {
		
		System.out.println(this.getClass());
	}

	public Purchase findPurchase(int tranNo) throws SQLException {

		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}
	
	public Purchase findPurchase2(int prodNo) throws SQLException {
		
		return sqlSession.selectOne("PurchaseMapper.getPurchase", prodNo);
	}

	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}

	public List<Purchase> getSaleList(Search search) throws Exception {
		
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	public void insertPurchase(Purchase purchase) throws Exception {

		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}

	public void updatePurchase(Purchase purchase) throws SQLException {

		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	public void updateTranCode(Map map) throws SQLException {

		sqlSession.update("PurchaseMapper.updateTranCode", map);
	}
	
	public int getTotalCount(String buyerId) throws Exception {
		
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId);
	}

}
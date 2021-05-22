package com.model2.mvc.service.purchase;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public Purchase findPurchase(int tranNO) throws SQLException;
	
	public Purchase findPurchase2(int prodNo) throws SQLException;

	public List<Purchase> getPurchaseList(Search search, String buyer_id) throws Exception;

	public List<Purchase> getSaleList(Search search) throws Exception;

	public void insertPurchase(Purchase purchase) throws Exception;

	public void updatePurchase(Purchase purchase) throws SQLException;
	
	public void updateTranCode(Map map) throws SQLException;
	
	public int getTotalCount(String buyerId) throws Exception;

}

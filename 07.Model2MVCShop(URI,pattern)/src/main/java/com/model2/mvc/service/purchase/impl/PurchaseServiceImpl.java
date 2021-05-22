package com.model2.mvc.service.purchase.impl;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;

	public PurchaseServiceImpl() {
		
		System.out.println(this.getClass());
	}

	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertPurchase(purchase);
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		Purchase purchase = purchaseDao.findPurchase(tranNo);
		String retrunDivyDate = purchase.getDivyDate();
		if(retrunDivyDate != null) {
			purchase.setDivyDate(retrunDivyDate.substring(0, 10));
		}
		
		return purchase;
	}

	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {

		List<Purchase> list = purchaseDao.getPurchaseList(search, buyerId);
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("buyerId", buyerId);
		//map.put("role", "user");
		int totalCount = purchaseDao.getTotalCount(buyerId);
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	public Map<String, Object> getSaleList(Search search) throws Exception {
		
		List<Purchase> list = purchaseDao.getSaleList(search);
		Map<String, Object> map = new HashMap();
		//map.put("role", "admin");
		String buyerId = null;
		int totalCount = purchaseDao.getTotalCount(buyerId);

		map.put("list", list);
		map.put("totalCount", totalCount);

		return map;
	}

	public void updatePurcahse(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	public void updateTranCode(Map map) throws Exception {
		purchaseDao.updateTranCode(map);
	}

	public Purchase getPurchase2(int prodNo) throws Exception {
		Purchase purchase = purchaseDao.findPurchase2(prodNo);
		
		return purchase;
	}

}

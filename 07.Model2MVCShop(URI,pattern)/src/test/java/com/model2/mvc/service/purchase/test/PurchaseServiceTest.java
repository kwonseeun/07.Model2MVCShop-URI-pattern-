package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
											"classpath:config/context-aspect.xml",
											"classpath:config/context-mybatis.xml",
											"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception{
		
		Purchase purchase = new Purchase();
		User user = new User();
		Product product = new Product();
		user.setUserId("user02");
		purchase.setBuyer(user);
		product.setProdNo(12345);
		purchase.setPurchaseProd(product);
		purchase.setTranNo(12345);
		purchase.setDivyAddr("nowon");
		purchase.setPaymentOption("1");
		
		purchaseService.addPurchase(purchase);
		
		
		purchase = purchaseService.getPurchase(12345);
		System.out.println("testAddPurchase :: "+purchase);
		
		Assert.assertEquals("user02", purchase.getBuyer().getUserId());
		Assert.assertEquals(12345, purchase.getPurchaseProd().getProdNo());
		
	}
	
	//@Test
	public void testGetPurchaseTranNo() throws Exception{
		
		Purchase purchase = purchaseService.getPurchase(12345);
		
		System.out.println("testGetPurchaseTranNo :: "+purchase);
		
		Assert.assertEquals("user02", purchase.getBuyer().getUserId());
		Assert.assertEquals(12345, purchase.getPurchaseProd().getProdNo());
		
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = new Purchase();
		purchase = purchaseService.getPurchase(12345);
		System.out.println("변경전 : "+purchase);
		
		purchase.setPaymentOption("2");
		purchase.setReceiverName("mybatis");
		purchase.setDivyAddr("seoul");
		
		purchaseService.updatePurcahse(purchase);
		
		purchaseService.getPurchase(12345);
		
		System.out.println("변경후 : "+purchase);
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("mybatis", purchase.getReceiverName());
		Assert.assertEquals("seoul", purchase.getDivyAddr());
	}
	
	@Test
	public void testUpdateTranCode() throws Exception{
		
		Purchase purchase = new Purchase();
		purchase = purchaseService.getPurchase(12345);
		System.out.println("testUpdateTranCode 전 : "+purchase.getTranCode());
		purchase.setTranCode("2");
		
		purchaseService.updateTranCode(purchase);
		purchase= purchaseService.getPurchase(12345);
		
		System.out.println("testUpdateTranCode 후 : "+purchase.getTranCode());
		
		Assert.assertEquals("2  ", purchase.getTranCode());
	}
//	
//	//@Test
//	public void testDeleteProduct() throws Exception{
//		
//		productService.deleteProduct(12345);
//		
//	}
//	
	 @Test
	 public void testGetPurchaseList() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user02");
	 	
	 	List<Purchase> list = (List<Purchase>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("PurchaseList :: "+totalCount);
	 	
	 }	 
	 
	 @Test
	 public void testGetSaleList() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getSaleList(search);
	 	
	 	List<Purchase> list = (List<Purchase>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("SaleList :: "+totalCount);
	 	
	 }	 
}
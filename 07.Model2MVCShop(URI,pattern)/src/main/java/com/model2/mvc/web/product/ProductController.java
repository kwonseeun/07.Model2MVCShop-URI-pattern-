package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.CookieGenerator;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	public ProductController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@RequestMapping(value = "addProduct", method = RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct :: GET");

		return "redirect:/product/addProductView.jsp";
	}

	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/addProduct :: POST");
		// Business Logic
		productService.addProduct(product);

		return "forward:/product/addProduct.jsp";
	}

	@RequestMapping("getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo,
			@RequestParam(value = "menu", defaultValue = "search") String menu, Model model,
			@CookieValue(value="history", required=false) String history, HttpServletResponse response) throws Exception {

		System.out.println("/getProduct.do");
		// Business Logic
		Product product = productService.getProduct(prodNo);
		
// 		Cookie History (Spring frameWork 사용)
		CookieGenerator cookie = new CookieGenerator();
		
		history = history + "," + product.getProdNo() + "/" + product.getProdName();
		
		cookie.setCookieName("history");
		cookie.addCookie(response, history);

// 		java cookie (안됨)
//		String history = null;
//		Cookie[] cookies = request.getCookies();
//		if (cookies != null && cookies.length > 0) {
//			for (int i = 0; i < cookies.length; i++) {
//				Cookie cookie = cookies[i];
//				if (cookie.getName().equals("history")) {
//					history = cookies[i].getValue();
//				}
//			}
//		}
//
//		Cookie cookie = new Cookie("history", history + "," + product.getProdNo() + "/" + product.getProdName());
//		response.addCookie(cookie);

		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);

		return "forward:/product/getProduct.jsp";
	}

	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/product/updateProduct :: GET");
		// Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);

		return "forward:/product/updateProductView.jsp";
	}

	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/updateProduct :: POST");
		// Business Logic
		productService.updateProduct(product);

		return "forward:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=manage";
	}

	@RequestMapping("listProduct")
	public String listProduct(@RequestParam("menu") String menu, @ModelAttribute("search") Search search, Model model)
			throws Exception {

		System.out.println("/product/listProduct");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		if(search.getOrder() == null) {
			search.setOrder("reg_date");
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);

		return "forward:/product/listProduct.jsp";
	}

	@RequestMapping("deleteProduct")
	public String deleteProduct(@RequestParam("prodNo") int prodNo) throws Exception {
		System.out.println("/product/deleteProduct");
		productService.deleteProduct(prodNo);

		return "forward:/product/listProduct?menu=manage";
	}
}
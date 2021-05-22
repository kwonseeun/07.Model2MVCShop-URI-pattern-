<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.model2.mvc.common.Search"%>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.service.domain.Purchase"%>
<%@ page import="java.util.List"%>

<%
List<Purchase> list = (List<Purchase>) request.getAttribute("list");
Search search = (Search) request.getAttribute("search");
Page resultPage = (Page) request.getAttribute("resultPage");
%>

<html>
<head>
<title>판매내역</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetSaleList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listSale" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">판매내역</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="80">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">구매자이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">구매자연락처</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="">구매상품</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">주문일자</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<%
	for(int i=0; i<list.size(); i++) {
		Purchase purchase = (Purchase)list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center">
			<a href="/purchase/getPurchase?tranNo=<%= purchase.getTranNo() %>"><%= i+1 %></a>
		</td>
		<td></td>
		<td align="left">
			<a href="/user/getUser?userId=<%= purchase.getBuyer().getUserId() %>"><%= purchase.getBuyer().getUserId() %></a>
		</td>
		<td></td>
		<td align="left"><%= purchase.getReceiverName() %></td>
		<td></td>
		<td align="left"><%= purchase.getReceiverPhone() %></td>
		<td></td>
		<td align="left">
			<a href="/product/getProduct?prodNo=<%= purchase.getPurchaseProd().getProdNo() %>&menu=manage"><%= purchase.getPurchaseProd().getProdName() %>(<%= purchase.getPurchaseProd().getProdNo() %>)</a>
		</td>
		<td></td>
		<td align="left" width="100px">
			<%= purchase.getOrderDate() %>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<td align="center">
			<% if(resultPage.getCurrentPage() > resultPage.getPageUnit()){ %>
				<a href="javascript:fncGetSaleList('<%=resultPage.getBeginUnitPage()-1%>')">이전</a>	
			<% } %>
			<% for(int i = resultPage.getBeginUnitPage(); i<=resultPage.getEndUnitPage(); i++){ %>
				<a href="javascript:fncGetSaleList('<%= i %>')"><%= i %></a>					
			<% } %>
			<% if(resultPage.getCurrentPage() <= resultPage.getPageUnit()){ %>
				<% if(!(resultPage.getMaxPage() <= resultPage.getPageUnit())){%>
					<a href="javascript:fncGetSaleList('<%=resultPage.getEndUnitPage()+1%>')">다음</a>
				<% } %>		
			<% } %>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>
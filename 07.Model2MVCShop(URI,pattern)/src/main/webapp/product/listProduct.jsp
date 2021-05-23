<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<html>
<head>
<title><c:if test="${menu == 'manage' }">
			상품관리
		</c:if>
		<c:if test="${ menu == 'search' }">
			상품검색
	</c:if>
</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();
}

function fncSetOrder(order){
	document.getElementById("order").value = order.value;
	fncGetList('1');
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
<input type="hidden" name="order" id="order" value="${search.order}"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${menu == 'manage' }">
							상품관리
						</c:if>
						<c:if test="${ menu == 'search' }">
							상품검색
						</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr height="30">
		<td colspan="8" >전체 ${ resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지</td>
		<td align="right">
			<select onchange="javascript:fncSetOrder(this)">
				<option value="reg_date" ${search.order == 'reg_date' ? "selected" : ""}>
						최신순
				</option>
				<option value="price" ${search.order == 'price' ? "selected" : ""}>
						가격순
				</option>
			</select>
				판매중만 표시<input onclick="javascript:fncGetList('1')" type="checkbox" name="display" value="on" ${search.display == 'on' ? "checked" : ""}></input>
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="80">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">현재상태 <a href="javascript:fncSetOrder('tranCode')">정렬</a></td>	
	</tr>
	<tr>
		<td colspan="9" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
		<c:forEach var="product" items="${ list }">
		<c:set var="i" value="${ i+1 }"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
				<td align="left">
					<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a>
				</td>
		<td></td>
		<td align="left">${product.price }</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
		<td align="left">
		 	<c:choose>
		 		<c:when test="${ menu == 'search'}">
		 			<c:choose>
		 				<c:when test="${product.proTranCode == null}">
		 					판매중
		 				</c:when>
		 				<c:otherwise>
		 					재고없음
		 				</c:otherwise>
		 			</c:choose>
		 		</c:when>
		 		<c:otherwise>
		 			<c:if test="${product.proTranCode == null}">
		 				판매중
		 			</c:if>
		 			<c:if test="${product.proTranCode == '1  ' || product.proTranCode == '1'}">
		 				구매완료
		 				<c:if test="${menu == 'manage'}">
		 					<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2"> 배송하기</a>
		 				</c:if>
		 			</c:if>
		 			<c:if test="${product.proTranCode == '2  ' || product.proTranCode == '2'}">
		 				배송중
		 			</c:if>
		 			<c:if test="${product.proTranCode == '3  ' || product.proTranCode == '3'}">
		 				배송완료
		 			</c:if>
		 		</c:otherwise>
		 	</c:choose>
		</td>	
	</tr>
	<tr>
		<td colspan="9" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<td align="center">
			
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right" wdith="42%">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>상품번호</option>
				<option value="1" ${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>상품명</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>상품가격</option>
			</select>
		</td>
		<jsp:include page="../common/searchList.jsp"/>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>

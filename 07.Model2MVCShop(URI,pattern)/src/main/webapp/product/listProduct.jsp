<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<html>
<head>
<title><c:if test="${menu == 'manage' }">
			��ǰ����
		</c:if>
		<c:if test="${ menu == 'search' }">
			��ǰ�˻�
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
							��ǰ����
						</c:if>
						<c:if test="${ menu == 'search' }">
							��ǰ�˻�
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
		<td colspan="8" >��ü ${ resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage} ������</td>
		<td align="right">
			<select onchange="javascript:fncSetOrder(this)">
				<option value="reg_date" ${search.order == 'reg_date' ? "selected" : ""}>
						�ֽż�
				</option>
				<option value="price" ${search.order == 'price' ? "selected" : ""}>
						���ݼ�
				</option>
			</select>
				�Ǹ��߸� ǥ��<input onclick="javascript:fncGetList('1')" type="checkbox" name="display" value="on" ${search.display == 'on' ? "checked" : ""}></input>
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="80">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">������� <a href="javascript:fncSetOrder('tranCode')">����</a></td>	
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
		 					�Ǹ���
		 				</c:when>
		 				<c:otherwise>
		 					������
		 				</c:otherwise>
		 			</c:choose>
		 		</c:when>
		 		<c:otherwise>
		 			<c:if test="${product.proTranCode == null}">
		 				�Ǹ���
		 			</c:if>
		 			<c:if test="${product.proTranCode == '1  ' || product.proTranCode == '1'}">
		 				���ſϷ�
		 				<c:if test="${menu == 'manage'}">
		 					<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2"> ����ϱ�</a>
		 				</c:if>
		 			</c:if>
		 			<c:if test="${product.proTranCode == '2  ' || product.proTranCode == '2'}">
		 				�����
		 			</c:if>
		 			<c:if test="${product.proTranCode == '3  ' || product.proTranCode == '3'}">
		 				��ۿϷ�
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
				<option value="0" ${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>��ǰ��ȣ</option>
				<option value="1" ${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>��ǰ����</option>
			</select>
		</td>
		<jsp:include page="../common/searchList.jsp"/>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>

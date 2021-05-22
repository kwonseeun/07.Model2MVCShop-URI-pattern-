<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="com.model2.mvc.service.domain.User" %>

<%
User user = (User)session.getAttribute("user");
	String role="";
	
	if(user != null) {
		role=user.getRole();
	}
%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function history(){
	popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}
</script>

</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
<td valign="top"> 
	<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
		<% 	if(user != null){ %>
		<tr>
			<td class="Depth03">
				<a href="/user/getUser?userId=<%=user.getUserId() %>" target="rightFrame">����������ȸ</a>
			</td>
		</tr>
		<%	}  %>
		<% if(role.equals("admin")){%>
		<tr>
			<td class="Depth03" >
				<a href="/user/listUser" target="rightFrame">ȸ��������ȸ</a>
			</td>
		</tr>
		<% } %>
		<tr>
			<td class="DepthEnd">&nbsp;</td>
		</tr>
	</table>
</td>
</tr>

<%	if(role.equals("admin")){ %>
<!--menu 02 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					<a href="/purchase/listSale" target="rightFrame">�Ǹų���</a>
				</td>
			</tr>
			<tr>
				<td class="Depth03">
					<a href="/product/addProduct" target="rightFrame">�ǸŻ�ǰ���</a>
				</td>
			</tr>
			<tr>
				<td class="Depth03">
					<a href="/product/listProduct?menu=manage"  target="rightFrame">�ǸŻ�ǰ����</a>
				</td>
			</tr>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<% } %>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					<a href="/product/listProduct?menu=search" target="rightFrame">�� ǰ �� ��</a>
				</td>
			</tr>
			<%	if(user != null && role.equals("user")){%>
			<tr>
				<td class="Depth03">
					<a href="/purchase/listPurchase"  target="rightFrame">�����̷���ȸ</a>
				</td>
			</tr>
			<%  }%>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">
					<a href="javascript:history()">�ֱ� �� ��ǰ</a>
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

<title>열어본 상품 보기</title>

</head>
<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String history = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split(",");
			System.out.println("h[] :: "+h);
			for (int i = 0; i < h.length; i++) {
				String[] his = h[i].split("/");
					if (!h[i].equals("null")) {
						System.out.println("his 0 :: "+his[0]);
						System.out.println("his 1 :: "+his[1]);
%>
					<a href="/getProduct.do?prodNo=<%=his[0]%>&menu=search"
						target="rightFrame"><%=his[1]%></a>
					<br>
<%
				}
			}
		}
	}
%>

</body>
</html>
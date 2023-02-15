<%@ page contentType="text/html; charset=UTF-8"
%><%@ page import="com.fp.dto.CardDTO"
%><%@ page import="java.util.ArrayList"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();

   ArrayList<CardDTO> cardList = (ArrayList<CardDTO>)request.getAttribute("cardList");
   int cardCount = cardList.size();
   
%><?xml version="1.0" encoding="UTF-8"?>
<list>
	<totalDataCount><%=cardCount %></totalDataCount>
	<%
	for(int i=0; i<cardCount; i++)
	{
	%>
	<card>
		<cardnum><%=cardList.get(i).getCard_num() %></cardnum>
		<cardlocation><%=cardList.get(i).getCard_location() %></cardlocation>
	</card>
	<%
	}
	%>	
</list>

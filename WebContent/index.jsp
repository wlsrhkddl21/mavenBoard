<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	$("#btnLogin").click(function(){
		login();
	});
	
	$("#btnLogout").click(function(){
		sessionStorage.clear();
		
		location.reload();
	});
	
});
function login(){
	var sData={"userId":$("#userId").val()
				,"userPw":$("#userPw").val()}
	$.post("./loginCheck.ino",sData,function(rData) {
	    if(rData=="success"){
	   		alert("로그인성공.");
	   		location.href="./viewMenu.ino"
	    }else if(rData=="fail"){
	    	alert("로그인실패");
		    location.reload();
	    }
	});
	console.log(sData);
}
</script>
</head>
<body>
<a href="<%=request.getContextPath() %>/main.ino">메인페이지</a>
<input type="text" id="userId" name="userId" placeholder="아이디">
<input type="text" id="userPw" name="userPw" placeholder="비밀번호">
<input type="button" id="btnLogin" value="로그인">
<!-- <a href="/main.ino">메인페이지</a> -->
</body>
</html>
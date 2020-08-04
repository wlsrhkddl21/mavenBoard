<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
</head>
<script>
function modify(){
	var title = $("#title").val().trim();
	var num = $("#num").val();
	var content=$("#content").val();
	
	
	if(title!=""){	
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				url:"./freeBoardModify.ino",
				type:"POST",
				dateType:"JSON",
				data:{
					"title":title,
					"content":content,
					"num":num
				},
				success: function(result){
					console.log(result);
					if(result=="success"){
						alert("수정하였습니다.");
					}else if(result=="fail"){
						alert("error:제목,내용은 100Byte이하로 작성하세요.");
					}
				},
				error: function (request, status, error){	// 서버와 통신이 정상적으로 이루어지지 않았을때     
					console.log(error);
			    }
			});
		}
	}else{
		alert("제목을 입력하세요.")
	}
// 	console.log(title);
} //modify
function del(){
// 	var num=$("#num").val();
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url:"./freeBoardDelete.ino",
			type:"POST",
			datatype:"JSON",
			data:"num=${freeBoardDto.NUM }",
			success : function(result){
				if(result=="success"){
					alert("삭제되었습니다.");
					location.href = "./main.ino";
				}
			},
			error:function(request, status, error){
				alert("실패")
			}
		});
// 		location.href="?num=${freeBoardDto.num }";
	
	
	}//if(confirm)
}//del

	
</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form name="insertForm">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.NUM }" />
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.NAME }" readonly/></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title" id="title" value="${freeBoardDto.TITLE }"/></div>
	
		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.REGDATE }" readonly/></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" id="content" rows="25" cols="65"  >${freeBoardDto.CONTENT }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="del()">
		
		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div>
		
	</form>
	
</body>
</html>
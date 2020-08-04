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
<style>
.left-box {
	float: left;
}

.right-box {
	float: right;
}
</style>

<script>
	function insert(){
		var name=$("#name").val().trim();
		var title=$("#title").val().trim();
		var content=$("#content").val();
		
		if(name==""){
			alert("이름을 입력하세요.");
			return false;
		}else if(title==""){
			alert("제목을 입력하세요.");
			return false;
		}else if(name!=""&&title!=""){
			if(confirm("작성하시겠습니까?")){
				$.ajax({
					url:"./freeBoardInsertPro.ino",
					data:{
						"name":name,
						"title":title,
						"content":content
					},
					type:"POST",
					datatype:"JSON",
					success:function(result){
							console.log(result);
						if(result=="success"){
							alert("작성되었습니다.");
							location.href="./main.ino";
							
						}else if(result.result=="fail"){
							alert("error:이름,제목,내용은 100Byte이하로 작성하세요.");
						}
					},
					error:function(request, status, error){
						alert("실패");
					}
				});
			}
		}
	}
</script>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form>
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="name" name="name" /></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="title" name="title" /></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea id="content" name="content" rows="25" cols="65"  ></textarea></div>
		<div>
			<div class='left-box'style="padding-left: 150px;"></div>
			<div class='right-box'>
			<input type="button" value="글쓰기" onclick="insert()">
			<input type="button" value="다시쓰기" onclick="reset()">
			<a href="./main.ino"><input type="button" value="취소"></a> 
			&nbsp;&nbsp;&nbsp;
			</div>
		</div>
	</form>
	
	
	
</body>
</html>
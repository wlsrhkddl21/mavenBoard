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
			alert("�̸��� �Է��ϼ���.");
			return false;
		}else if(title==""){
			alert("������ �Է��ϼ���.");
			return false;
		}else if(name!=""&&title!=""){
			if(confirm("�ۼ��Ͻðڽ��ϱ�?")){
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
							alert("�ۼ��Ǿ����ϴ�.");
							location.href="./main.ino";
							
						}else if(result.result=="fail"){
							alert("error:�̸�,����,������ 100Byte���Ϸ� �ۼ��ϼ���.");
						}
					},
					error:function(request, status, error){
						alert("����");
					}
				});
			}
		}
	}
</script>
<body>
	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	
	<form>
		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="name" name="name" /></div>
		
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" id="title" name="title" /></div>
	
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea id="content" name="content" rows="25" cols="65"  ></textarea></div>
		<div>
			<div class='left-box'style="padding-left: 150px;"></div>
			<div class='right-box'>
			<input type="button" value="�۾���" onclick="insert()">
			<input type="button" value="�ٽþ���" onclick="reset()">
			<a href="./main.ino"><input type="button" value="���"></a> 
			&nbsp;&nbsp;&nbsp;
			</div>
		</div>
	</form>
	
	
	
</body>
</html>
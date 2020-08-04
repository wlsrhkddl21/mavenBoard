<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<style>
th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
input[name=listDcode],input[name=listDcode_Name],input[name=delCode]{
	border:unset; 
	background-color:unset; 
	text-align:center; 
	font-size:16px; 
}
</style>
<script>
var index = 0;
var dup = 0;
$(document).ready(function(){
	
	$("span[name=radios]").hide();
	
	$(document).on("click", "input[name=removeBox]", function(){
	    console.log($(this));
	    $(this).parent("form").remove();
		index--;
		console.log(index);
	});

	$("#btnSave").click(function(){
		var c="d";
		if($("input[type=checkbox]:checked").length==0&&index==0){
			alert("변경 사항이 없습니다.");
			return false;
		}
		if(!confirm("추가하시겠습니까?")){
			return false;
		}
		if(index>0){
			if(!checkData()){
				alert("빈칸을 확인하세요.");
			return  false;
			}	
			$.ajax({
			    url	     : "./checkCode.ino", // 호출하고자 하는 URL 주소
			    type     : "POST", 				  // 호출방식 GET , POST 
			    dataType : "JSON",    		  //json(배열로 보내고 받는다.{}) , html , text
			    data     : $("Form[name=formInsert]").serialize(),
			    async:false,
			    success: function(rData){ 	  // 서버와 통신이 정상적으로 이루어졌을떄. 
// 				console.log(rData);
				c=rData;
			    }//success: function(rData)
			}); //$post
			console.log(c);
			if(c==1){
				alert("디테일코드는 중복이 안됩니다.");
				return false;
			}else if(c == -11){
				alert("경고! 최대 글자수 100bytes 입니다.");
				return false;
			} //if rData > 0
		}//if index !=0
		console.log(c);
		if(!updateCheckData()){
			return false;
		}
		
		$.post("./insertCode.ino",updateCode(), function(rData) {
			var msg = rData.trim();
			console.log(msg);
			if (msg == "success") {
				alert("코드저장 성공");
				location.reload();
			}else if(msg=="fail"){
				alert("코드저장 실패");
			}
		});
	}); //#btnclickfunction
	
	$("#btnUpdate").click(function(){
		var check =0; 
		$("input[type=checkbox]:checked").each(function(index){
			var strDcode = $(this).parents("tr").find("input[name=listDcode_Name]").prop("defaultValue");
			var datasave = $(this).parents("tr").find("input[name=listDcode_Name]").attr("data-save");
			if(datasave=="u"){
				$(this).prop("checked",false);
				$(this).parents("tr").find("span[name=yNn]").show();
				$(this).parents("tr").find("span[name=radios]").hide();
				$(this).parents("tr").find("input[name=listDcode_Name]").attr("readonly" ,true).attr("data-save","default");
				$(this).parents("tr").find("input[name=listDcode_Name]").css("border" ,"unset").css("background-color","unset");
				$(this).parents("tr").find("input[name=listDcode_Name]").val(strDcode);
			}else if(datasave=="default"){
				$(this).parents("tr").find("span[name=yNn]").hide();
				$(this).parents("tr").find("span[name=radios]").show();
				$(this).parents("tr").find("input[name=listDcode_Name]").attr("readonly" ,false).attr("data-save","u");
				$(this).parents("tr").find("input[name=listDcode_Name]").css("border" ,"1px solid").css("background-color","white");
				check++;
			}
		});
// 		if($("input[type=checkbox]:checked").length==0&&check==0){
// 			alert("체크된 항목이 없습니다.");
// 			return false;
// 		}
	});
	$("#btnDelete").click(function(){
		$("input[type=checkbox]:checked").each(function(index){
			var datasave = $(this).parents("tr").find("input[name=listDcode_Name]").attr("data-save");
				console.log(datasave)
			if(datasave=="default"){
				$(this).parents("form").css("background-color","red");
				$(this).parents("tr").find("input[name=listDcode_Name]").attr("data-save","d");
				$(this).parents("tr").find("input[name=listDcode]").attr("name","delCode");
			}else if(datasave=="d"){
				$(this).parents("form").css("background-color","unset");
				$(this).parents("tr").find("input[name=delCode]").attr("name","listDcode");
				$(this).parents("tr").find("input[name=listDcode_Name]").attr("data-save","default");
				$(this).prop("checked",false);
			}
		});
	});
});
function updateCode(){
	var checkdata= $("input[type=checkbox]:checked").parents("form").serialize();
	if(index!=0){
		var insertdata = $("Form[name=formInsert]").serialize();
		return checkdata+"&"+insertdata;
	}else{
		return checkdata;
	}
}
function checkData(){
	var x = true;
	
	$("Form[name=formInsert]").each(function(index){
		var rDCode=$(this).children('#dCode').val().trim();
		var rCodeName=$(this).children('#codeName').val().trim();
		
		if(rDCode==""||rCodeName==""){
			x =false;
		}
	});
	return x;
}
function updateCheckData(){
	var x= true;
	$("input[type=checkbox]:checked").each(function(index){
		var listDcode_Name=$(this).parents("tr").find("input[name=listDcode_Name]").val();
// 		console.log(listDcode_Name);
		if(listDcode_Name==""){
			alert("빈칸을 확인하세요.");
			console.log("여기");
			x =false;
		}
	});
	return x;
}
function addInsertBox(){
	var str = "";	
	if(index<3){
		str += "<form name='formInsert'>" 
		str += "<input type='button' name='removeBox' value='제거'/>"
		str += "<input type='text' id='mCode' name='mCode' value='${list[0].CODE}' style='margin-left: 5px;' readonly />"
		str += "<input type='text' id='dCode' name='dCode' style='margin-left: 25px;'/>"
		str += "<input type='text 'id='codeName' name='codeName' style='margin-left: 30px;'/>"
		str += "<input type='radio' id='userYn' name='userYn' value='Y' style='margin-left: 38px;' checked='checked'>Y"
		str += "<input type='radio' id='userYn' name='userYn' value='N'>N"
		str += "</form>"
		$("#crud").append(str);
		index++;
	}else{
		alert("3개 까지만 추가 가능합니다.")
	}
	console.log(index);
}
</script>
<title>Insert title here</title>
</head>
<body>
<div style="background-color:#dedede; height:700px;">
<h1 style="text-align: center;">디테일</h1>
	<div style="width:700px;" align="right">
		<input type="button" id="btnAdd" onclick="addInsertBox()" value="추가"/>
		<input type="button" id="btnUpdate" value="수정"/>
		<input type="button" id="btnDelete" value="삭제"/>
		<input type="button" id="btnSave" value="저장"/>
	</div>
		<table  style="text-align:center">						
			<tr>					
				<th style="width: 20px;"></th>
				<th style="width: 160px;">마스터코드</th>				
				<th style="width: 175px;">디테일코드</th>				
				<th style="width: 170px;">코드이름</th>				
				<th style="width: 80px;">사용유무</th>				
			</tr>	
		</table>	
		
		<c:forEach items="${list }" var="dto">					
			<form id="listForm">
				<table  style="text-align:center">				
					<tr>				
						<td><input type="checkbox"></td>
						<td style="width: 160px;">${dto.CODE       }</td>			
						<td style="width: 175px;"><input type="text" value="${dto.DCODE      }" style="width: 150px;" name="listDcode" readonly></td>			
						<td style="width: 170px;"><input type="text" value="${dto.DCODE_NAME }" style="width: 150px;" name="listDcode_Name" data-save="default" readonly></td>			
						<td style="width: 80px;">
						<span name="yNn">
						${dto.USER_YN    }
						</span>
						<span name="radios">
							<input type="radio" name="radioYnN" value="Y" <c:if test="${dto.USER_YN eq'Y' }">checked</c:if> >Y
							<input type="radio" name="radioYnN" value="N" <c:if test="${dto.USER_YN eq'N' }">checked</c:if>>N
						</span>
						</td>	
					</tr>				
				</table>
			</form>
		</c:forEach>
	<div id="crud">
	</div>
 </div>
</body>
</html>
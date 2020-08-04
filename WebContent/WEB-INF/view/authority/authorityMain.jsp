<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
$(document).ready(function(){
	var useCheck = "미사용";
	var groupId = "${groupId}"
	var index = 0;
	
	if(groupId != "") {
		var objJson = ${objJson};
		var mappingJson = ${mappingJson};
		
		for(var j=0; j<objJson.length;j++){
			for(var i=0;i<mappingJson.length;i++){
				if(objJson[j].OBJID == mappingJson[i].OBJID){
					$('td[name="a"]').eq(j).text("사용중");
					$("input[name=oneCheck]").eq(j).attr("checked","checked").attr("data-s","use");
					index++;
				}//if(objJson[j].OBJID == mappingJson[i].OBJID)
			}//for(var i=0;i<mappingJson.length;i++);
		}//for(var j=0;i<mappingJson.length;i++);
		if(index==objJson.length){
			$("#allCheck").attr("checked","checked");
		}//if(index==objJson.length)
	}//if(groupId != "")
		
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=oneCheck]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=oneCheck]").prop("checked",false);
        }
	});//$("#allCheck").click(function()
			
	$("#btnSave").click(function(){
		
		if(!confirm("저장하시겠습니까?")){
			return false;
		}
		
		var sData = checkData();
		var jsonData = JSON.stringify(sData);
		console.log(jsonData);
		
		$.ajax({
		    url	     : "./authoritySave.ino", // 호출하고자 하는 URL 주소
		    type     : "POST", 				  // 호출방식 GET , POST 
		    dataType : "text",    		  //json(배열로 보내고 받는다.{}) , html , text
		    data     : jsonData,
		    contentType : "application/json; charset=UTF-8",
// 		    async:false,
		    success: function(rData){ 	  // 서버와 통신이 정상적으로 이루어졌을떄. 
		    	console.log(rData);
				if(rData=="success"){
					alert("저장성공");
				}else if(rData=="fail"){
					alert("저장실패");
				}else if(rData=="notchange"){
					alert("변경된 값이 없습니다.");
				}else if(rData=="higi_obj"){
					alert("상위항목 체크확인");
				}
		    	location.reload();
			},
		    error: function onError (error) {
		        console.log(error);
		    }
		});//$.ajax
	});//$("#btnSave").click(function()
}); //$(document).ready(function())
function checkData(){
	var useData = new Array();
	var unUseData = new Array();
// 	var sData = new Array();
	var groupId = "${groupId}";
// 	console.log(groupId);

	$("input[name=oneCheck]").each(function(i){
		var check = $(this).is(":checked");
		var data = $(this).attr("data-s");
		
		if(check&&data!="use"){
			var use = $(this).parents("tr").children().eq(1).text();
			var sUse ={"groupId" : groupId,
					   "objId" : use};
			useData.push(sUse);
			
		}else if(!check&&data=="use"){	
// 			console.log("삭제")
// 			console.log($(this))
			var unUse = $(this).parents("tr").children().eq(1).text();
			var sUnUse = {"groupId":groupId,
						"objId":unUse	};
			unUseData.push(sUnUse);
		}
	});
	var sData={"useData" : useData
			  ,"unUseData" : unUseData};
	return sData;
}//function checkData()
</script>
</head>
<body>
<H1 style="margin-top: 0px;">권한부여</H1>
<div style="width:750px;" align="right"><input type="button" id="btnSave"value="저장"/></div>
<div style="display:flex">
	<div style="border:1px solid black; width:300px; height:500px; margin:10px">
	<h2>그룹관리</h2>
		<table style="width: 300px; text-align:center;">
			<tr>
				<th>GroupId</th>
				<th>GroupName</th>
				<th>UseYnN</th>
			</tr>
			<c:forEach var="gList" items="${groupList }">
			<tr>	
				<td><a href="javascript:void(0)" onclick="sendBarData('./authorityMain.ino?groupId=${gList.GROUPID }')">${gList.GROUPID }</a></td>
				<td><a href="javascript:void(0)" onclick="sendBarData('./authorityMain.ino?groupId=${gList.GROUPID }')"">${gList.GROUPNAME }</a></td>
				<td>${gList.USEYN }</td>
			<tr>
			</c:forEach>
		</table>
		<hr style="width: 280px">
	</div>
	
	<div style="border:1px solid black; width:300px; height:500px;  margin:10px">
	<h2>객체관리</h2>
		<table style="width: 299px; text-align:center;">
			<tr>
				<th><input type="checkbox" id="allCheck"></th>
				<th style="width:58px;">ObjId</th>
				<th>ObjName</th>
				<th>Dept</th>
				<th>UseYnN</th>
			</tr>
			<c:forEach var="obList" items="${objList }">
				<tr>
					<td><input type="checkbox" name="oneCheck"/></td>
					<td>${obList.OBJID }</td>
					<td>${obList.OBJNAME }</td>
					<td>${obList.DEPT }</td>
					<td name="a">미사용</td>
				</tr>
			</c:forEach>
		</table>
		<hr style="width: 280px">
	</div>
</div>
</body>
</html>
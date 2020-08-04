<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	var main = 0;
	var comm = 0;
	var author = 0; 
	var html ="";
	var barName =["메인","공통코드","권한부여"];
$(document).ready(function(){
	var barData = ${barData};
	for(var i = 0; i < barData.length;i++){
  		if(barData[i] == 1){
  			var el = $("input[data-btn="+barName[i]+"]").prevAll().children();
  			addBar(el);
 		}
	}
	$(document).on("click", "input[type=button]", function(){
		var btnName = $(this).attr("data-btn");
		var barData = [main,comm,author];
		
		
		if(btnName=="메인"){
			location.href="./main.ino?barData="+barData;
		}else if(btnName=="공통코드"){
			location.href="./commonCode.ino?barData="+barData;
		}else if(btnName=="권한부여"){
			location.href="./authorityMain.ino?barData="+barData;
		}
	});
	$(document).on("click", "span[name=bar]", function(){
		addBar($(this));
	});
});
function sendBarData(num){
	var barData = [main,comm,author];
	var test = num.lastIndexOf(3);
	var addBarData = "&barData=";
	if(num.indexOf("?")==-1){
		addBarData = "?barData=";
	}
	location.href = num+addBarData+barData;
}
function addBar(el){
	var that = el;
	var del = that.parent().parent().find("div");
	var objName = that.text();
	if(main==0&&objName=="메인"){
		main = 1;
	}else if(main==1&&objName=="메인"){
		del.remove();
		main=0;
		comm=0;
		author=0;
	}
	if(comm==0&&objName=="공통코드"){
		comm = 1;
	}else if(comm==1&&objName=="공통코드"){
		console.log(del);
		del.remove();
		comm=0;
	}
	if(author==0&&objName=="권한부여"){
		
		author = 1;
	}else if(author==1&&objName=="권한부여"){
		console.log(del);
		del.remove();
		author=0;
	}
	
	var test = that.parent().parent()
	var str = "";
	var groupId = "${userGroup}";
	var sData = {"groupId": groupId
				,"objName": objName};
	if((main==1&&objName=="메인")||(comm==1&&objName=="공통코드")||(author==1&&objName=="권한부여")){
		$.ajax({
		    url	     : "./addBar.ino", // 호출하고자 하는 URL 주소
		    type     : "POST", 				  // 호출방식 GET , POST 
		    dataType : "json",    		  //json(배열로 보내고 받는다.{}) , html , text
		    data     : sData,
		    async	 : false,
		    success: function(rData){
	    		for(var i = 0; i <rData.length; i ++){
	    			str += "<div><li><a href='javascript:void(0)'><span name='bar'>"+rData[i].OBJNAME+"</span></a><input type='button' data-btn=\""+rData[i].OBJNAME+"\"  value='열기'></li></div>";
	    		}
	    		test.append(str);
				html = $("ul").html();
				
		    }
		
		});
	}
}
</script>
</head>
<body>

	<br><br><br><br>
	<ul>
		<li>
			<a href="javascript:void(0)"><span name="bar">메인</span></a><input type="button" data-btn="메인" value="열기">
		</li>
	</ul>
</body>
</html>
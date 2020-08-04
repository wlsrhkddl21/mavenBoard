<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<style>
.left-box {
	float: left;
}

.right-box {
	float: right;
}
</style>

<script>
var regexp = /^[0-9]*$/;
$(document).ready(function() {
	$("#searchBtn").click(function() {
		ajaxPage(1);
// 		var searchType = $("#searchType").val();
// 		var searchTxt = $("#searchTxt").val().trim();
// 		var curPage="1";
// 		var beginDate = $("#beginDate").val().trim();
// 		var endDate = $("#endDate").val().trim();
// 		console.log(regexp.test(searchTxt));
// 		if (searchType == "DCOM002") {
// 			if (!regexp.test(searchTxt)) {
// 				alert("번호만 작성하세요.");
// 				$("#searchTxt").val("").focus();
// 				return false;
// 			}
// 		}
// 		checkDate(beginDate,endDate);
// 		if(searchTxt.trim()==""){
// 			alert("검색어를 입력하세요.");
// 			$("#searchTxt").focus();
// 			return false;
// 		}
		
// 		var sData = {					  //서버로 전달해야할 인자값(파라미터) {"key" : value}
// 				"searchType":searchType
// 				,"searchTxt":searchTxt
// 			};
// 		$.ajax({
// 		    url: "./freeBoardSearch.ino", // 호출하고자 하는 URL 주소
// 		    type: "POST", 				  // 호출방식 GET , POST 
// 		    dataType: "JSON",    		  //json(배열로 보내고 받는다.{}) , html , text
// 		    data:sData,
			
// 		    success: function(data){ 	  // 서버와 통신이 정상적으로 이루어졌을떄. 
// 				console.log(data);
// 				var str ="";
// 				history.pushState(null, null, "./main.ino?curPage="+data.pagingUt.curPage+"&searchType="+data.searchType+"&searchTxt="+data.searchTxt);
// 				for(var i=0; i <data.list.length;i++){
// 					str+="<div style='width: 50px; float: left;'>"+data.list[i].NUM+"</div>"
// 					str+="<div style='width: 300px; float: left;'>"
// 					str+="<a href='./freeBoardDetail.ino?num="+data.list[i].NUM+"'>"+data.list[i].TITLE+"</a>"
// 					str+="</div>"
// 					str+="<div style='width: 150px; float: left;'>"+data.list[i].NAME+"</div>"
// 					str+="<div style='width: 150px; float: left;'>"+data.list[i].REGDATE+"</div>"
// 					str+="<hr style='width: 600px'>"
// 				}
// 				$("#list").empty();
// 				$("#list").append(str);
				
// 				var pageStr="";
				
// 				if(data.pagingUt.curPage > 10){
// 					pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+data.pagingUt.blockBegin+")'><button>첫페이지</button></a>";
// 				}
// 				if(data.pagingUt.curPage>1){
// 					pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+curPage-1+")'><button>이전</button></a>";
// 				}
// 				for(var i=data.pagingUt.blockBegin; i <data.pagingUt.blockEnd+1;i++){
// 					switch (i) {
// 					case data.pagingUt.curPage:
// 						pageStr+="<span style='color:red'>"+ i +"&nbsp;</span>";
// 						break;
// 					default:
// 						pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+i+")'>"+ i +"&nbsp;</a>";
// 						break;
// 					}
// 				}
// 				if(data.pagingUt.curPage < data.pagingUt.blockEnd){
// 				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+(data.pagingUt.curPage+1)+")'><button>다음</button></a>";
// 				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+data.pagingUt.totalPage+")'><button>마지막페이지</button></a>";
// 				}
// 				$("#pageBlock").empty();
// 				$("#pageBlock").append(pageStr);
// 			    },
// 		    error: function (request, status, error){	// 서버와 통신이 정상적으로 이루어지지 않았을때     
// 				console.log(error);
// 		    }
// 		});
	});
});

function checkDate(beginDate,endDate){
	
}

function ajaxPage(page){
	var curPage=page;
// 	var regexp = /^[0-9]*$/;
	var searchType = $("#searchType").val();
	var searchTxt = $("#searchTxt").val();
	if (searchType == "DCOM002") {
		if (!regexp.test(searchTxt)) {
			alert("번호만 작성하세요.");
			$("#searchTxt").val("").focus();
			return false;
		}
	}
	if(searchTxt.trim()==""){
		alert("검색어를 입력하세요.");
		$("#searchTxt").focus();
		return false;
	}
	var sData = {					  //서버로 전달해야할 인자값(파라미터) {"key" : value}
			"searchType":searchType
			,"searchTxt":searchTxt
			,"curPage":curPage
		};
	var url = "./freeBoardSearch.ino";
	$.ajax({
	    url	     : url, // 호출하고자 하는 URL 주소
	    type     : "POST", 				  // 호출방식 GET , POST 
	    dataType : "JSON",    		  //json(배열로 보내고 받는다.{}) , html , text
	    data     :sData,
		
	    success: function(data){ 	  // 서버와 통신이 정상적으로 이루어졌을떄. 
			console.log(data);
			var str ="";
			
			history.pushState(null, null, "./main.ino?curPage="+data.pagingUt.curPage+"&searchType="+data.searchType+"&searchTxt="+data.searchTxt);

			for(var i=0; i <data.list.length;i++){
				str+="<div style='width: 50px; float: left;'>"+data.list[i].NUM+"</div>"
				str+="<div style='width: 300px; float: left;'>"
				str+="<a href='./freeBoardDetail.ino?num="+data.list[i].NUM+"'>"+data.list[i].TITLE+"</a>"
				str+="</div>"
				str+="<div style='width: 150px; float: left;'>"+data.list[i].NAME+"</div>"
				str+="<div style='width: 150px; float: left;'>"+data.list[i].REGDATE+"</div>"
				str+="<hr style='width: 600px'>"
			}	
			$("#list").empty();
			$("#list").append(str);
			
			var pageStr="";
			
			if(data.pagingUt.curPage > 1){
				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+1+")'><button>첫페이지</button></a>";
				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+(data.pagingUt.curPage-1)+")'><button>이전</button></a>";
			}
			for(var i=data.pagingUt.blockBegin; i <data.pagingUt.blockEnd+1;i++){
				switch (i) {
				case data.pagingUt.curPage:
					pageStr+="<span style='color:red'>"+ i +"&nbsp;</span>";
					break;
				default:
					pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+i+")'>"+ i +"&nbsp;</a>";
					break;
				}
			}
			if(data.pagingUt.curPage < data.pagingUt.totalPage){
				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+(data.pagingUt.curPage+1)+")'><button>다음</button></a>";
				pageStr+="<a href='javascript:void(0)' onclick='ajaxPage("+data.pagingUt.totalPage+")'><button>마지막페이지</button></a>";
			}
			if(data.pagingUt.curPage>1){
			}
			$("#pageBlock").empty();
			$("#pageBlock").append(pageStr);
	    },
		
	    error: function (request, status, error){	// 서버와 통신이 정상적으로 이루어지지 않았을때     
			console.log(error);
	    }
	});
}
function checkKey(){
	if(window.event.keyCode===13){
		ajaxPage(1);
	}else{
		return false;
	}
}
$(window).on('popstate', function(event) {
    window.location = location.href;
});

</script>
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
		<div>
			<div class='left-box' style="padding-left: 17px; display: inline-block;">
				<select name="searchType" id="searchType">
					<c:forEach items="${codeMap }" var="com001">
							<option value="${com001.DCODE}" >${com001.DCODE_NAME }</option>
					</c:forEach>
				</select>
				
				<select name="searchYear" id="searchYear">
					<c:forEach items="${codeMap1 }" var="com004">
							<option value="${com004.DCODE}" >${com004.DCODE_NAME }</option>
					</c:forEach>
				</select>
				  
				<input type="text" onkeyup="checkKey()" name="searchTxt" id="searchTxt"<c:if test="${map.searchTxt != 'default' }">value="${map.searchTxt}"</c:if>>
				<input type="button" id="searchBtn" value="검색">
			</div>
			
			<div class='right-box' style="padding-right: 33px; display: inline-block;">
				<a href="./freeBoardInsert.ino">글쓰기</a>
			</div>
			<div class='left-box' style="padding-left: 17px; display: inline-block;">
				시작일:<input type="text" id="beginDate">
				종료일:<input type="text" id="endDate">
			</div>
		</div>
	<hr style="width: 600px">
	<div id="list">
	<c:forEach items="${freeBoardList }" var="dto">
		<div style="width: 50px; float: left;">${dto.NUM }</div>
		<div style="width: 300px; float: left;">
			<a href="./freeBoardDetail.ino?num=${dto.NUM }">${dto.TITLE }</a>
		</div>
		<div style="width: 150px; float: left;">${dto.NAME }</div>
		<div style="width: 150px; float: left;">${dto.REGDATE }</div>
		<hr style="width: 600px">
	</c:forEach>
	</div>

	<div id="pageBlock">
		<c:if test="${pagingUt.curPage > 1 }">
			<a href="./main.ino?curPage=1&searchType=${map.searchType}&searchTxt=${map.searchTxt}"><button>첫페이지</button></a>
			<a href="./main.ino?curPage=${pagingUt.curPage-1 }&searchType=${map.searchType}&searchTxt=${map.searchTxt}"><button>이전</button></a>
		</c:if>
		<c:forEach var="num"  begin="${pagingUt.blockBegin }" end="${pagingUt.blockEnd }">
		<c:choose>
			<c:when test="${num == pagingUt.curPage }">
				<span style="color:red">${num }</span>
			</c:when>
			<c:otherwise>
				<a href="./main.ino?curPage=${num }&searchType=${map.searchType}&searchTxt=${map.searchTxt}">${num}</a>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${pagingUt.curPage != pagingUt.totalBlock }">
			<a href="./main.ino?curPage=${pagingUt.curPage+1 }&searchType=${map.searchType}&searchTxt=${map.searchTxt}"><button>다음</button></a>
			<a href="./main.ino?curPage=${pagingUt.totalPage }&searchType=${map.searchType}&searchTxt=${map.searchTxt}"><button>마지막페이지</button></a>
		</c:if>
		
	</div>

</body>
</html>
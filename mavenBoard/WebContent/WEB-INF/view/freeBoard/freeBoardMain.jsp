<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
.left-box {
	float: left;
}

.right-box {
	float: right;
}
input::placeholder {
  color: #d3d3ab;
  font-style: italic;
}
</style>

<script>
var regexp = /^[0-9]*$/;
var searchType ="";
var searchTxt = "";
var beginDate = "";
var endDate = "";

$(document).ready(function() {
	if("${map.beginDate}"!=""&&"${map.endDate}"!=""){
		$("#beginDate").val(makeDate("${map.beginDate}"));
		$("#endDate").val(makeDate("${map.endDate}"));
	}
	
	$("#searchBtn").click(function() {
		setDate();
		ajaxPage(1);
	});
	
	$("#beginDate").keyup(function(){
		if(window.event.keyCode!=8){
			var date = $(this).val();
			if(date.length==10){
				if(!isDate(date)){
					$("#beginDate").val("").focus();
					return false;
				};
				$("#endDate").focus();
			}
			if(!autoComplate(date)){
				$(this).val("");
			}else{
				$(this).val(autoComplate(date));
			}
		}
	});
	$("#endDate").keyup(function(){
		if(window.event.keyCode!=8){
			var date = $(this).val();
			if(!autoComplate(date)){
				$(this).val("");
			}else{
				$(this).val(autoComplate(date));
			}
			if(date.length==10){
				if(!isDate(date)){
					$("#endDate").val("").focus();
					return false;
				}
				$("#searchTxt").focus();
			}
		}
	});
});
function autoComplate(date){
	var str=""
		if(date.length == 4){
			if(!regexp.test(date)){
				alert("숫자만 입력하세요!!!!!");
				return false;
			}else{
				date=date+"-";
			}
		}else if(date.length==7){
		str = date.substr(5,6);
		console.log(str);
			if(!regexp.test(str)){
				alert("숫자만 입력하세요!!!!!");
				return false;
			}else{
				date=date+"-";
			}
		}
	return date;
}

function setDate(){
	searchType = $("#searchType").val();
	searchTxt = $("#searchTxt").val();
	beginDate = $("#beginDate").val();
	endDate = $("#endDate").val();
}
function isDate(txtDate) {
    var currVal = txtDate;
    var rxDatePattern = /^(\d{4})-(\d{2})-(\d{2})$/; //Declare Regex                  
    var dtArray = currVal.match(rxDatePattern); // is format OK?
    if (dtArray == null){
    	alert("yyyy-mm-dd형태로 입력하세요.");
        return false;
    }
    
    var dtYear = dtArray[1];
    var dtMonth = dtArray[2];
    var dtDay = dtArray[3];
    
    if (dtMonth < 1 || dtMonth > 12){
    	alert("월은 1~12까지 가능합니다.");
        return false;
    }else if (dtDay < 1 || dtDay > 31){
    	alert("해당월의 일수를 확인하세요.");
        return false;
	}else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31){
		alert("해당월에는 31일이 없습니다.");
        return false;
    }else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap)){
        	alert("해당월의 일수를 확인하세요.")
        	$(this).focus();
            return false;
        }
    }else if (dtYear < 2000){
    	alert("2000년 이후로 검색 가능합니다.");
    	return false;
    }
    return true;
}
function ajaxPage(page){
	var curPage=page;
	
	if(beginDate!=""&&endDate!=""){
		if(!isDate(beginDate)){
			$("#beginDate").focus().val("");
			return false;
		}else if(!isDate(endDate)){
			$("#endDate").focus().val("");
			return false;
		}else if(beginDate > endDate){
			alert("시작일과 종료일을 확인해주세요.");
			$("#beginDate").focus();
			return false;
		}

	}else if((beginDate==""&&endDate!="")||(endDate==""&&beginDate!="")){
		alert("시작일와 종료일 모두 입력해야됩니다.");
		$("#beginDate").focus();
		return false;
	}else if(beginDate==""&&endDate==""){
		if(searchTxt.trim()==""){
			alert("검색어를 입력하세요.");
			$("#searchTxt").focus();
			return false;
		}
	}
	if (searchType == "DCOM002") {
		if (!regexp.test(searchTxt)) {
			alert("번호만 작성하세요.");
			$("#searchTxt").val("").focus();
			return false;
		}
	}
	
	var sData = {					  //서버로 전달해야할 인자값(파라미터) {"key" : value}
			"searchType":searchType
			,"searchTxt":searchTxt
			,"curPage":curPage
			,"beginDate":beginDate
			,"endDate":endDate
		};
	var url = "./freeBoardSearch.ino";
	$.ajax({
	    url	     : url, // 호출하고자 하는 URL 주소
	    type     : "POST", 				  // 호출방식 GET , POST 
	    dataType : "JSON",    		  //json(배열로 보내고 받는다.{}) , html , text
	    data     :sData,
		
	    success: function(data){ 	  // 서버와 통신이 정상적으로 이루어졌을떄. 
			var str ="";
			history.pushState(null, null, "./main.ino?curPage="+data.pagingUt.curPage+"&searchType="+data.searchType+"&searchTxt="+data.searchTxt+"&beginDate="+data.beginDate+"&endDate="+data.endDate);

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
		setDate();
		ajaxPage(1);
	}else{
		return false;
	}
}
function makeDate(date){
	console.log("date:"+date);
	var year = date.substr(0,4);
	var mon = date.substr(4,2);
	var day = date.substr(6,2);
	console.log("mon:"+mon);
	return year+"-"+mon+"-"+day
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
				  
				<input type="text" onkeyup="checkKey()" name="searchTxt" id="searchTxt"<c:if test="${map.searchTxt != '' }">value="${map.searchTxt}"</c:if>>
				<input type="button" id="searchBtn" value="검색">
			</div>
			
			<div class='right-box' style="padding-right: 33px; display: inline-block;">
				<a href="./freeBoardInsert.ino">글쓰기</a>
			</div>
			<div class='left-box' style="padding-left: 17px; display: inline-block;">
				시작일:<input type="text" id="beginDate" maxLength="10" placeholder="YYYY-MM-DD" >			
				종료일:<input type="text" id="endDate" maxLength="10" placeholder="YYYY-MM-DD" >
			</div>
		</div>
	<hr style="width: 600px">
	<div id="list">
	<c:forEach items="${map.list }" var="dto">
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
		<c:if test="${map.pagingUt.curPage > 1 }">
			<a href="./main.ino?curPage=1&searchType=${map.searchType}&searchTxt=${map.searchTxt}&beginDate=${map.beginDate}&endDate=${map.endDate}"><button>첫페이지</button></a>
			<a href="./main.ino?curPage=${map.pagingUt.curPage-1 }&searchType=${map.searchType}&searchTxt=${map.searchTxt}&beginDate=${map.beginDate}&endDate=${map.endDate}"><button>이전</button></a>
		</c:if>
		<c:forEach var="num"  begin="${map.pagingUt.blockBegin }" end="${map.pagingUt.blockEnd }">
		<c:choose>
			<c:when test="${num == map.pagingUt.curPage }">
				<span style="color:red">${num }</span>
			</c:when>
			<c:otherwise>
				<a href="./main.ino?curPage=${num }&searchType=${map.searchType}&searchTxt=${map.searchTxt}&beginDate=${map.beginDate}&endDate=${map.endDate}">${num}</a>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${map.pagingUt.curPage != map.pagingUt.totalBlock }">
			<a href="./main.ino?curPage=${map.pagingUt.curPage+1 }&searchType=${map.searchType}&searchTxt=${map.searchTxt}&beginDate=${map.beginDate}&endDate=${map.endDate}"><button>다음</button></a>
			<a href="./main.ino?curPage=${map.pagingUt.totalPage }&searchType=${map.searchType}&searchTxt=${map.searchTxt}&beginDate=${map.beginDate}&endDate=${map.endDate}"><button>마지막페이지</button></a>
		</c:if>
		
	</div>

</body>
</html>
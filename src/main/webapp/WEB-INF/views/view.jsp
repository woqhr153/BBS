<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/app">Home</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
          <%
          	if(session.getAttribute("loginid") ==null) {%>
          		<a href="/app/login" class="btn btn-success">로그인</a>
            	<a href="/app/newbie" class="btn btn-primary">회원가입</a>
          <%
          	} else{
          %>	
          	<div style="color:white">
          		${loginid}님 환영합니다 
          		<a href="/app/logout" class="btn btn-primary " style="margin-left:10px">로그아웃</a>
          	</div>
			
			<%
			} 
			%>
            
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Hello, world!</h1>
        </div>
    </div>
    <div class="container">
		<div class="row">
			<table class="table table-striped" style="height:auto;text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">상세보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2" id="title">${board.title}</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2" id="writer">${board.writer}</td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2" id="created">${board.created}</td>
					</tr>
					
					<tr>
						<td>내용</td>
						<td style="white-space:pre-line;height:335px;text-align: left;" id="content">${board.content}</td>
					</tr>
					
				</tbody>
			</table>


			<a href="/app" class="btn btn-primary pull-right">목록</a>
			
          	 <%
          	if(session.getAttribute("loginid") !=null) {%>
          		<input type="button" id="delete" class="btn btn-primary pull-right" value="삭제" style="margin-right:10px">
				<input type="button" id="update"  class="btn btn-primary pull-right" value="수정" style="margin-right:10px">
	          <%
	          	}
         	 %>
			</div>
	</div>
<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
<script>
	$(document)
	/* .ready(function() {
		$.post("http://localhost:8081/app/getBoardView",{bbs_id:${bbs_id}},function(result){
 			console.log(result)
 			$.each(result,function(ndx,value){
 				$('#title').text(value['title']);
 				$('#writer').text(value['writer']);
 				$('#content').text(value['content']);
 				$('#created').text(value['created']);
 				
 				
 			}) 
 			
 		},'json')
	}) */
	.on('click','#update',function() {
		if('${loginid}' =='${board.writer}') {
			location.href='/app/update?bbs_id='+${board.bbs_id}
		} else {
			alert('작성자가 아닙니다')
			return false
		}
		
	})
	.on('click','#delete',function() {
		if('${loginid}'=='${board.writer}'){
			$.post("http://localhost:8081/app/doDelete",{bbs_id:${board.bbs_id}},function(result){
	 			console.log(result)			
	 			
	 		},'json')
			location.href='/app'
		} else {
			alert('작성자가 아닙니다')
		}
		
	})
	

</script>
</body>
</html>
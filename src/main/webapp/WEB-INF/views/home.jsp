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
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center; width:5%;">번호</th>
						<th style="background-color: #eeeeee; text-align: center; width:60%;">제목</th>
						<th style="background-color: #eeeeee; text-align: center; width:15%;" >작성자</th>
						<th style="background-color: #eeeeee; text-align: center; width:10%;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center; width:10%;">수정일</th>
					</tr>
				</thead>
				<tbody id="boardList">
					
				</tbody>
			</table>
			<a href="/app/write" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
	<script>
		$(document).ready(function () {
	 		$.post("http://localhost:8080/app/getBoardList",{},function(result){
	 			console.log(result)
	 			 $.each(result,function(ndx,value){
	 				str='<tr><td>'+value['bbs_id']+'</td><td>'+value['title']+'</td><td>'+value['writer']+'</td><td>'+value['created']+'</td><td>'+value['updated']+'</td></tr>';
	 				$('#boardList').append(str);
	 				console.log(str);
	 			}) 
	 			
	 		},'json')
	 	})
	 	.on('click','#boardList tr',function(){
	 		s=$(this).find('td:eq(0)').text()
	 		location.href='/app/view?bbs_id='+s
	 	})
	 	.on('click','#login',function() {
	 		let pstr= $.trim($('input[name=user_id]').val())
	 		$('input[name=user_id]').val(pstr)
	 		pstr= $.trim($('input[name=pw]').val())
	 		$('input[name=pw]').val(pstr)
	 		if($('input[name=user_id]').val()==''||$('input[name=pw]').val()=='') {
	 			alert('아이디와 비밀번호를 입력해주세요')
	 			return false
	 		} else {
	 			$("form").submit()
	 		}
	 	})
	</script>
</body>
</html>
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">작성하기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<form method=POST action="/app/doWrite">
								<div class="form-group">
							    <input type="text" name="title" class="form-control"placeholder="제목을 입력하세요">
							  	</div>
						  		<div class="form-group">
							    <textarea class="form-control" name="content" rows="15" cols="20" wrap="hard" placeholder="내용을 입력하세요"></textarea>
							  	</div>
						  	</form>
					  	</td>
					</tr>
					
				</tbody>
			</table>			
			<a href="/app?page=${page}&search_type=${search_type}&search_keyword=${search_keyword}" class="btn btn-primary pull-right" >목록</a>
			<input type="button" id="write" class="btn btn-primary pull-right" value="등록" style="margin-right:10px">			
		</div>
	</div>
	<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
	<script>
		$(document)
		.on('click','#write',function() {
			let pstr= $.trim($('input[name=title]').val())
			$('input[name=title]').val(pstr)
			pstr= $.trim($('textarea[name=content]').val())
			$('textarea[name=content]').val(pstr)
			
			if($('input[name=title]').val()==''){
				alert('제목을 입력해주세요')
				return false
			} 
			if($('input[name=title]').val()==''){
				alert('내용을 입력해주세요')
				return false
			}
			$('form').submit()
		})
	</script>
</body>
</html>
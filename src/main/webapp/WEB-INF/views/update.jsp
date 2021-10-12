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
							<form method=POST action="/app/doUpdate">
								<div class="form-group">
							    <input type="text" id="title" name="title" class="form-control"placeholder="제목을 입력하세요" value="${board.title}">
							    
							  	</div>
						  		<div class="form-group">
							    <textarea class="form-control" id="content" name="content" rows="15" cols="20" wrap="hard" placeholder="내용을 입력하세요">${board.content}</textarea>
							  	</div>
						  	</form>
					  	</td>
					</tr>
					
				</tbody>
			</table>			
			<input type="button" id="cancle" class="btn btn-primary pull-right" value="취소">
			<input type="button" id="update" class="btn btn-primary pull-right" value="수정" style="margin-right:10px">			
		</div>
	</div>
	<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
	<script>
		$(document)

		.on('click','#cancle',function() {
			location.href='/app/view?bbs_id='+${board.bbs_id}+'&page=${page}&search_type=${search_type}&search_keyword=${search_keyword}'
		})
		.on('click','#update',function() {
			let pstr= $.trim($('#title').val())
			$('#title').val(pstr)
			pstr= $.trim($('#content').val())
			$('#content').val(pstr)
			
			if($('#title').val()==''){
				alert('제목을 입력해주세요')
				return false
			} 
			if($('#content').val()==''){
				alert('내용을 입력해주세요')
				return false
			}
			$.post("http://localhost:8080/app/doUpdate",{bbs_id:${board.bbs_id},title:$('#title').val(),content:$('#content').val()},function(result){
	 			console.log(result)
	 			
	 			},'json')
	 			location.href='/app/view?bbs_id='+${board.bbs_id}+'&page=${page}&search_type=${search_type}&search_keyword=${search_keyword}'
			})
		
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<style>
	@media all and (min-width : 801px) {
		#head{
		margin-top:10px !important
		}
	}
	@media all and (min-width : 1066px) {
		#head{
		margin-top:10px !important
		}
	}
</style>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
         <div class="navbar-header">
          <button type="button" id="navbar-toggle" class="navbar-toggle collapsed" data-toggle="dropdown" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
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
        <h1 id="head" style="margin-top:50px;">Hello, world!</h1>
        </div>
    </div>
	<div class="container">
		<div class="col-lg-4"></div>
		<div  style="width:100%">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="/app/signin">
					<h3 style="text-align: center;">회원가입</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="user_id" id="user_id" maxlength="20">
					</div>
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="user_name" id="user_name" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="전화번호" name="tel" id="tel" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="pw" id="pw" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인" id="check_pw" maxlength="20">
					</div>
					
				</form>
				
				<input type="button" id="signin"class="btn btn-primary pull-right" value="회원가입">
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
	<script>	
		$(document)
		.on('click','#signin',function() {
			if($('#user_name').val()=='') {
				alert('이름을 입력해주세요')
				return false
			}
			if($('#user_id').val()=='') {
				alert('아이디를 입력해주세요')
				return false
			}
			if($('#pw').val()=='') {
				alert('비밀번호를 입력해주세요')
				return false
			}
			if($('#tel').val()=='') {
				alert('전화번호를 입력해주세요')
				return false
			}
			if($('#pw').val() != $('#check_pw').val()) {
				alert('비밀번호와 비밀번호 확인이 다릅니다')
				return false
			}
			$("form").submit()
		})
	</script>
</body>
</html>
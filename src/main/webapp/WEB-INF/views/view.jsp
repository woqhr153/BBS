<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
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


			<a href="/app?page=${page}&search_type=${search_type}&search_keyword=${search_keyword}" class="btn btn-primary pull-right">목록</a>
			
          	<%
          	if(session.getAttribute("loginid") !=null) {
          	%>
          		<input type="button" id="delete" class="btn btn-primary pull-right" value="삭제" style="margin-right:10px">
				<input type="button" id="update"  class="btn btn-primary pull-right" value="수정" style="margin-right:10px">
	         <%
	          	}
         	 %>		
				<div class="form-group">
				<%
					if(session.getAttribute("loginid") !=null) {
				%>
					<textarea style="margin-top:100px;" class="form-control" name="content" rows="5" cols="20" wrap="hard" placeholder="내용을 입력하세요"></textarea>
					
				</div>
				<input type="button" id="doReply"  class="btn btn-primary pull-right" value="등록" >	
				<%
					} else {
				%>
					<textarea style="margin-top:100px;" class="form-control"rows="5" cols="20" wrap="hard" placeholder="댓글을 작성하시려면 로그인하세요"></textarea>
				<%
					} 
				%>

		       	     
		     <table class="table table-hover" style=" margin-top:70px">
				<thead>
					<tr>
						<th colspan=5 style="text-align: center; background-color: #eeeeee; text-align: center; width:5%;">댓글리스트</th>
					
					</tr>
				</thead>
				<tbody id="replyList">
				
					<c:forEach items="${replyList}" var="list">
						<tr>
							<td id="${list.reply_id}">
								<div style="font-size:18px">작성자: ${list.writer}</div>
								<div id="content${list.reply_id}" style="padding:15px; white-space:pre-line;">${list.content}</div>
								
								<div class="pull-right" style="font-size:8px; color: gray">
								<%
									if(session.getAttribute("loginid") !=null) {
								%>
								<input type="button" id="update${list.reply_id}" class="btn-sm btn-link" value=수정>
								<input type="button" id="delete${list.reply_id}" class="btn-sm btn-link" value=삭제>								
								<%
									}
								%>
									<span>등록일 ${list.created}  </span>
									<span>  수정일 ${list.updated}</span>
								</div>
							</td>
						</tr>
						<%
							if(session.getAttribute("loginid") !=null) {
						%>
							<script>
							$(document)
							.on('click','#update${list.reply_id}',function() {
								if('${loginid}' =='${list.writer}') {
									str = '<textarea id="text${list.reply_id}" class="form-control" rows="5" cols="20" placeholder="내용을 입력해주세요"></textarea>'
									str += '<input type="button" id="cancle${list.reply_id}" class="btn-sm btn-primary pull-right" style="margin:5px;" value="취소">'
									str += '<input type="button" id="insert${list.reply_id}" class="btn-sm btn-primary pull-right" style="margin:5px;" value="수정">'
									$('#${list.reply_id}').append(str)
									$('#text${list.reply_id}').val($('#content${list.reply_id}').text())
									$('#update${list.reply_id}').hide()
								} else {
									alert('작성자가 아닙니다')
								}
							})
							.on('click','#delete${list.reply_id}',function(){
								reply_id = ${list.reply_id}
								if('${loginid}' =='${list.writer}') {
									conf = confirm('댓글을 삭제하시겠습니까?')
									if(conf==true){
										$.post("http://localhost:8080/app/deleteReply",{reply_id:reply_id, content:$('#text${list.reply_id}').val()},function(result){
											console.log(result)	
								 		},'json')
								 		location.reload(); 
									}
								} else {
									alert('작성자가 아닙니다')
								}
							})
							
							
							.on('click','#insert${list.reply_id}',function(){	
								reply_id = ${list.reply_id}
								conf = confirm('댓글을 수정하시겠습니까?')
								if(conf==true){
									$.post("http://localhost:8080/app/updateReply",{reply_id:reply_id,content:$('#text${list.reply_id}').val()},function(result){
							 			console.log(result)						 			
							 		},'json')						 		
							 		location.reload(); 
								}
							})
							.on('click','#cancle${list.reply_id}',function(){
								conf = confirm('댓글 수정을 취소하시겠습니까?')
								if(conf==true){
									$('#text${list.reply_id}').remove();
									$('#insert${list.reply_id}').remove();
									$('#cancle${list.reply_id}').remove();
									str='<input type="button" id="update${list.reply_id}" class="btn-sm btn-link" value=수정>'
									$('#update${list.reply_id}').show();
								}
							})
							
						</script>
						<%
							}				
						%>
					</c:forEach>
				
				</tbody>
			</table> 
			</div>
	</div>
	

<script>
	$(document)

	.on('click','#update',function() {
		if('${loginid}' =='${board.writer}') {
			location.href='/app/update?bbs_id='+${board.bbs_id}+'&page=${page}&search_type=${search_type}&search_keyword=${search_keyword}'
		} else {
			alert('작성자가 아닙니다')
			
		}
		
	})
	
	.on('click','#delete',function() {
		if('${loginid}'=='${board.writer}'){
			conf = confirm('게시물을 삭제하시겠습니까?')
			if(conf==true){
				bbs_id = ${board.bbs_id}
				$.post("http://localhost:8080/app/doDelete",{bbs_id:bbs_id},function(result){
		 			console.log(result)			
		 			
		 		},'json')
		 		location.href='/app?bbs_id='+bbs_id+'&page=${page}&search_type=${search_type}&search_keyword=${search_keyword}'
			}			
		} else {
			alert('작성자가 아닙니다');
		}
	})
	
	
	 
	.on('click','#doReply',function() {
		conf = confirm('댓글을 등록하시겠습니까?')
		if(conf==true){
			bbs_id = ${board.bbs_id}
			let s = $('textarea[name=content]').val()
			if(s=='') {
				alert('내용을 입력해주세요')		
			}
			$.post("http://localhost:8080/app/insertReply",{bbs_id:bbs_id,content:s},function(result){
	 			console.log(result)				 			
	 		},'json')
	 		location.reload();
		}
	})
</script>


</body>
</html>
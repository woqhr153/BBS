<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
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
			<form name="form_search" action="/app" method="GET" class="form-horizontal">
                  
                  <div class="input-group-append float-left pull-right" style="width: inherit; margin-bottom:15px;">
                    <button type="submit" class="btn btn-default">
                      <i class="fas fa-search"></i>
                    </button>
                  </div>
                  <input type="text" value="${paging.search_keyword}" name="search_keyword" class="form-control float-left pull-right" placeholder="Search" style="width: inherit;">
                  
                  <select name="search_type" class="form-control float-left pull-right" style="width: inherit;">
                    <option value="all" ${paging.search_type eq 'all' ? 'selected' : ''}>전체</option>
                    <option value="title" ${paging.search_type eq 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${paging.search_type eq 'content' ? 'selected' : ''}>내용</option>
                    <option value="writer" ${paging.search_type eq 'writer' ? 'selected' : ''}>작성자</option>
                  </select>  
                  
                  <%-- <input type="hidden" value="${paging.board_type}" name="board_type">   --%>                              
                </form>
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
				<c:forEach items="${boardList}" var="list">
				<tr>
					<td>${list.bbs_id}</td>
					<td><div  style="width:700px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.title}</div></td>
					<td>${list.writer}</td>
					<td>${list.created}</td>
					<td>${list.updated}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			 <div class="col-12 text-center">
          
          <ul class="pagination justify-content-center">
          <c:if test="${paging.prev }">

              <li class="paginate_button page-item previous" >
                <a href="/app?page=${paging.startPage-1}&search_type=${paging.search_type}&search_keyword=${paging.search_keyword}" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&laquo;</a>
              </li>
              </c:if>
              <!-- 사용기준: 향상된for(주로사용-시스템부담이 작아짐), 일반for문(시작,끝값이 정해진 로직에서 사용) -->
              <c:forEach begin="${paging.startPage}" end="${paging.endPage}" step="1" var="idx">
              <li class="paginate_button page-item ${paging.page==idx?'active':''}">
                <a href="/app?page=${idx}&search_type=${paging.search_type}&search_keyword=${paging.search_keyword}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">${idx}</a>
              </li>
              </c:forEach>
              <c:if test="${paging.next && paging.endPage >0 }">

              <li class="paginate_button page-item next">
                <a href="/app?page=${paging.endPage+1}&search_type=${paging.search_type}&search_keyword=${paging.search_keyword}" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&raquo;</a>
              </li>
              </c:if>
          </ul>
          
        </div>
			

		</div>
		<%
          	if(session.getAttribute("loginid") !=null) {%>
          		<a href="/app/write?page=${paging.page}&search_type=${paging.search_type}&search_keyword=${paging.search_keyword}" class="btn btn-primary pull-right" style="margin-bottom:30px">글쓰기</a>
	        <%
	          	} 
	        %>
	</div>
	<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
	<script>
		$(document)
		/* .ready(function () {
	 		$.post("http://localhost:8080/app/getBoardList",{},function(result){
	 			console.log(result)
	 			 $.each(result,function(ndx,value){
	 				str='<tr><td>'+value['bbs_id']+'</td><td>'+value['title']+'</td><td>'+value['writer']+'</td><td>'+value['created']+'</td><td>'+value['updated']+'</td></tr>';
	 				$('#boardList').append(str);
	 				console.log(str);
	 			}) 
	 			
	 		},'json')
	 	}) */
	 	.on('click','#boardList tr',function(){
	 		s=$(this).find('td:eq(0)').text()
	 		location.href='/app/view?bbs_id='+s+'&page=${paging.page}&search_type=${paging.search_type}&search_keyword=${paging.search_keyword}'
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
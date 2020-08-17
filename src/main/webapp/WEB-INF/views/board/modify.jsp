<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl core -->
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl formatting -->

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	게시글 수정
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           
                           	<form role="form" action="/board/modify" method ="post">
                            
                            <input type='hidden' name ='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                            <input type='hidden' name ='amount' value='<c:out value="${cri.amount}"/>'>
                            <input type="hidden" name="type" value="${cri.type}">
           					<input type="hidden" name="keyword" value="${cri.keyword}">
                            
                            <div class="form-group">
                            	<label>Bno</label> <input class="form-control" name = "bno"
     											    value = '<c:out value="${board.bno}"/>' readonly="readonly" />
                            </div>
                            
                            <div class="form-group">
                            	<label>Title</label> <input class="form-control" name = "title"
     											    value = '<c:out value="${board.title}"/>' />
                            </div>
                            
                            <div class="form-group">
                            	<label>Content</label> 
                            	<textarea class="form-control" name = "content" 
                            	 rows="3"> <c:out value="${board.content}"/>
                            	</textarea>
                            </div>
                            
                            <div class="form-group">
                            	<label>Writer</label> <input class="form-control" name = "writer"
     											    value = '<c:out value="${board.writer}"/>' readonly="readonly" />
                            </div>
                            
                            <div class="form-group" style="display:none;">
                            	<label>regDate</label> 
                            	<input class="form-control" name = "regDate" 
     						     value = '<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regDate}"/>' 
     						     readonly="readonly" />
                            </div>
                            
                            <div class="form-group" style="display:none;">
                            	<label>Update Date</label> 
                            	<input class="form-control" name = "updateDate" 
     						     value = '<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate}"/>' 
     						     readonly="readonly" />
                            </div>
                            
                            <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                            <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                            <button type="submit" data-oper='list' class="btn btn-info">리스트</button>
                             
                            </form>
                        </div>
                        <!-- / end panel-body -->
                    </div>
                    <!-- end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <script type="text/javascript">
 			$(document).ready(function(){
 				var formObj = $("form");
 				
 				$('button').on("click", function(e){
 					e.preventDefault();
 					
 					var operation = $(this).data("oper");
 					
 					console.log("modify 페이지 Operation : " + operation);
 					
 					if(operation === 'remove'){
 						formObj.attr("action", "/board/remove");
 					}
 					else if(operation === 'list'){
 						// Move to list.jsp
 						//self.location = "/board/list";
 						formObj.attr("action", "/board/list").attr("method","get");
 						var pageNumTag = $("input[name='pageNum']").clone();
 						var amountTag = $("input[name='amount']").clone();
 						var typeTag = $("input[name='type']").clone();
 						var keywordTag = $("input[name='keyword']").clone();
 						
 						formObj.empty();
 						formObj.append(pageNumTag);
 						formObj.append(amountTag);
 						formObj.append(typeTag);
 						formObj.append(keywordTag);
 					}
 					
 					formObj.submit();
 				});
 				
 			});
 			</script>
 
<%@include file="../includes/footer.jsp" %>

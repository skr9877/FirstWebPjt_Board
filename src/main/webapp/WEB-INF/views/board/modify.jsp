<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl core -->
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl formatting -->

<%@include file="../includes/header.jsp" %>
			<style>
			.uploadResult{
				width:100%;
				background-color:gray;
			}
			.uploadResult ul{
				display:flex;
				flex-flow:row;
				justify-content:center;
				align-items:center;
			}
			.uploadResult ul li{
				list-style:none;
				padding:10px;
				align-content:center;
				text-align:center;
			}
			.uploadResult ul li img{
				width:100px;
			}
			.uploadResult ul li span{
				color:white;
			}
			.bigPictureWrapper{
				position:absolute;
				display:none;
				justify-content:center;
				align-items:center;
				top:0%;
				width:100%;
				height:100%;
				background-color:gray;
				z-index:100;
				background:rgba(255,255,255,0.5);
			}
			.bigPicture{
				position:relative;
				display:flex;
				justify-content:center;
				align-items:center;
			}
			.bigPicture img{
				width:600px;
			}
			</style>
			
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
            
            <!-- 파일 리스트 VIEW -->
			<div class="row">
				<div class="col-lg-12">
					<!-- /.panel -->
					<div class="panel panel-default">
						
						<div class="panel-heading">파 일</div>
						
						<!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div class="form-group uploadDiv">
                            	<input type="file" name='uploadFile' multiple>
                       	    </div>
                        	
                        	<div class='uploadResult'>
                        		<ul>
                        		</ul>
                        	</div>
                        </div>
                        <!-- panel-body -->
					</div>
					<!-- end of panel -->
				</div>
				<!-- end of col -->
			</div>
			<!-- end row -->
            
            <!-- 버튼 제어 -->
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
 			
 			<!-- 파일 수정 혹은 삭제 -->
 			<script>
 			$(document).ready(function(){
 				(function(){
 					var bno = '<c:out value="${board.bno}"/>';
 					var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
 					var maxSize = 5242880; // 5MB
 					
 					// function 혹은 Event 구현 부
 					$(".uploadResult").on("click", "button", function(e){
	 					if(confirm("이 파일을 삭제하시겠습니까? ")){
	 						var targetLi = $(this).closest("li");
	 						targetLi.remove();
	 					}
 					}); // end of button	
 					
 					function checkExtension(fileName, fileSize){ // file size 체크
 						if(fileSize > maxSize){
 							alert("파일 사이즈 초과");
 							return false;
 						}
 						
 						if(regex.test(fileName)){
 							alert("해당 종류의 파일을 업로드 할 수 없습니다.");
 							return false;
 						}
 						
 						return true;
 					}
 					
 					function showUploadResult(uploadResultArr){ // 데이터 보여주기
 						if(!uploadResultArr || uploadResultArr.length == 0) return;
 						
 						var uploadUL = $(".uploadResult ul");
 						
 						var str = "";
 						
 						$(uploadResultArr).each(function(i, obj){
 							
 							if(obj.fileType){
 								var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
 								
 								str += "<li data-path='" + obj.uploadPath +"'";
 								str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'";
 								str += "><div>";
 								str += "<span> " + obj.fileName + "</span>";
 								str += "<button type='button' data-file=\'" + fileCallPath; 
 								str += "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 								str += "<img src='/display?fileName=" + fileCallPath + "'>";
 								str += "</div></li>";
 							}
 							else{
 								var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
 								
 								var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
 								
 								str += "<li data-path='" + obj.uploadPath +"'";
 								str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'";
 								str += "><div>";
 								str += "<span> " + obj.fileName + "</span>";
 								str += "<button type='button' data-file=\'" + fileCallPath;
 								str += "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 								str += "<img src='/resources/img/attach.png'></a>";
 								str += "</div></li>";
 							}
 						});
 						
 						uploadUL.append(str);
 					}
 					
 					// 파일 선택 버튼 클릭시 추가
 					$("input[type='file']").change(function(e){ // 파일 선택 버튼
 						var formData = new FormData();
 						var inputFile = $("input[name='uploadFile']");
 						var files = inputFile[0].files;
 						
 						for(var i = 0; i < files.length; ++i){
 							if(!checkExtension(files[i].name, files[i].size)){
 								return false;
 							}
 							
 							console.log(files[i]);
 							
 							formData.append("uploadFile",files[i]);
 						}
 						
 						$.ajax({
 							url: '/uploadAjaxAction',
 							processData : false,
 							contentType : false,
 							data : formData,
 							type : 'POST',
 							dataType : 'json',
 							success : function(result){
 								//alert("업로드 완료");
 								
 								showUploadResult(result); // 업로드 한 파일 보여주기
 								
 								//$(".uploadDiv").html(cloneObj.html()); // 파일 업로드시 업로드 할 리스트 지워줌
 								
 							}
 						}); // end of ajax	
 						
 					});
 					
 					// 게시글의 첨부파일 가져오기
 					$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
 						//console.log(arr);
 						
 						var str = "";
 						
 						$(arr).each(function(i, obj){
 							if(obj.fileType){
 								var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
 								
 								str += "<li data-path='" + obj.uploadPath +"'";
 								str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'";
 								str += "><div>";
 								str += "<span> " + obj.fileName + "</span>";
 								str += "<button type='button' data-file=\'" + fileCallPath; 
 								str += "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 								str += "<img src='/display?fileName=" + fileCallPath + "'>";
 								str += "</div></li>";
 							}
 							else{
 								var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
 								
 								var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
 								
 								str += "<li data-path='" + obj.uploadPath +"'";
 								str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'";
 								str += "><div>";
 								str += "<span> " + obj.fileName + "</span>";
 								str += "<button type='button' data-file=\'" + fileCallPath;
 								str += "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 								str += "<img src='/resources/img/attach.png'></a>";
 								str += "</div></li>";
 							}
 						});
 						
 						$(".uploadResult ul").html(str);
 						
 					}); // end of getJSON
 				})(); // end of function
 				

 			});
 			</script>
 
<%@include file="../includes/footer.jsp" %>

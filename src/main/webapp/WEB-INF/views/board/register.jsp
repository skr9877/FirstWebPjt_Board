<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl core -->
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl formatting -->

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	게시글 등록
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                            		<label>Title</label> <input class="form-control" name="title">
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Text area</label>
                            		<textarea class="form-control" rows="3" name="content"></textarea>
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>작성자</label> <input class="form-control" name="writer">
                            	</div>
                            	
                            	<button type="submit" class="btn btn-default">글 등록</button>
                            	<button type="reset" class="btn btn-default">초기화</button>
                            </form>
                        </div>
                        <!-- / end panel-body -->
                    </div>
                    <!-- end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
           <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	파일 등록
                        </div>
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
                        <!-- / end panel-body -->
                    </div>
                    <!-- end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
			<script>
			$(document).ready(function(e){
				// 변수 선언부
				var formObj = $("form[role='form']");
				var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
				var maxSize = 5242880; // 5MB
				var uploadResult = $(".uploadResult ul");
				
				// function 혹은 Event 구현 부
				
				$("button[type='submit']").on("click",function(e){  // Default button 기능 정지
					console.log("submit clicked")
					e.preventDefault();
				});
				// end of button submit
			
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
				
				$("input[type='file']").change(function(e){
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
						url: '/board/uploadAjaxAction',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						dataType : 'json',
						success : function(result){
							alert("업로드 완료");
							
							showUploadResult(result); // 업로드 한 파일 보여주기
							
							//$(".uploadDiv").html(cloneObj.html()); // 파일 업로드시 업로드 할 리스트 지워줌
							
						}
					}); // end of ajax	
					
				});
				
				$(".uploadResult").on("click","button",function(e){
					console.log( $(this).data("file"));
					console.log($(this).data("type"));
					console.log($(this));
					
					var targetFile = $(this).data("file");
					var type = $(this).data("type");
					
					var targetLi = $(this).closest("li");
					
					$.ajax({
						url: '/board/deleteFile',
						data : {fileName : targetFile, type:type},
						type : 'POST',
						dataType : 'text',
						success : function(result){
							alert(result);
							targetLi.remove();
						}
					}); // end of ajax
				});
				
				function showUploadResult(uploadResultArr){
					if(!uploadResultArr || uploadResultArr.length == 0) return;
					
					var uploadUL = $(".uploadResult ul");
					
					var str = "";
					
					// 수정 필요
					$(uploadResultArr).each(function(i, obj){
						
						if(obj.fileType){
							var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
							
							str += "<li><div>";
							str += "<span> " + obj.fileName + "</span>";
							str += "<button type='button' data-file=\'" + fileCallPath; 
							str += "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
							str += "<img src='/board/display?fileName=" + fileCallPath + "'>";
							str += "</div></li>";
						}
						else{
							var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
							
							var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
							
							str += "<li><div>";
							str += "<span> " + obj.fileName + "</span>";
							str += "<button type='button' data-file=\'" + fileCallPath;
							str += "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
							str += "<img src='/resources/img/attach.png'></a>";
							str += "</div></li>";
						}
					});
					
					uploadUL.append(str);
				}
			
				
			});
			</script>
 
<%@include file="../includes/footer.jsp" %>

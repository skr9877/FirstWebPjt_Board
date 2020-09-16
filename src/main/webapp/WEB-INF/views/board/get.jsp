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
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	게시글 확인
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            
                            <div class="form-group">
                            	<label>Bno</label> <input class="form-control" name = "bno"
     											    value = '<c:out value="${board.bno}"/>' readonly="readonly" />
                            </div>
                            
                            <div class="form-group">
                            	<label>Title</label> <input class="form-control" name = "title"
     											    value = '<c:out value="${board.title}"/>' readonly="readonly" />
                            </div>
                            
                            <div class="form-group">
                            	<label>Content</label> 
                            	<textarea class="form-control" name = "content" 
                            	 rows="3" readonly="readonly"> <c:out value="${board.content}"/>
                            	</textarea>
                            </div>
                            
                            <div class="form-group">
                            	<label>Writer</label> <input class="form-control" name = "writer"
     											    value = '<c:out value="${board.writer}"/>' readonly="readonly" />
                            </div>
                            
                            <button data-oper='modify' class="btn btn-default">수정</button>
                            <button data-oper='list' class="btn btn-default">리스트</button>
                            
                            <form id="operForm" action="/board/modify" method="get">
                            	<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'/>
                            	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'/>
                            	<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'/>
                            	<input type="hidden" name="type" value="${cri.type}">
           					    <input type="hidden" name="keyword" value="${cri.keyword}">
                            </form>
                        </div>
                        <!-- / end panel-body -->
                    </div>
                    <!-- end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
			
			<div class='bigPictureWrapper'>
				<div class='bigPicture'>
				</div>
			</div>
			
			<!-- 파일 리스트 VIEW -->
			<div class="row">
				<div class="col-lg-12">
					<!-- /.panel -->
					<div class="panel panel-default">
						
						<div class="panel-heading">파 일</div>
						
						<!-- /.panel-heading -->
                        <div class="panel-body">
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
			
			<!-- 댓글 VIEW -->
			<div class="row">
				<div class="col-lg-12">
			
					<!-- /.panel -->
					<div class="panel panel-default">
						
						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i> 댓글
							<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
						</div>
						
						<!-- /.panel-heading -->
                        <div class="panel-body">
                        	<ul class="chat">
                        		<!-- Jquery로 댓글 작성 -->
                        	</ul>
                        	<!--  ./end ul -->
                        </div>
                        <!-- chat panel -->
                        
                        <div class="panel-footer"></div>
					</div>
				</div>
				<!-- end row -->
			</div>

			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">댓글 모달</h4>
						</div>
						<div class="modal-body">
							<div class="modal-body">
								<div class="form-group">
									<label>댓글</label>
									<input class="form-control" name='reply' value='New Reply!!!!'>
								</div>
								<div class="form-group">
									<label>작성자</label>
									<input class="form-control" name='replyer' value='replyer'>
								</div>
								<div class="form-group">
									<label>댓글 작성일</label>
									<input class="form-control" name='replyDate' value=''>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
							<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
							<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
							<button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->

			<!-- 댓글 기능 스크립트 -->
			<script type="text/javascript" src="/resources/js/reply.js?ver=1"></script>
			<!-- 댓글 스크립트 구현 -->
			<script>
				$(document).ready(function() {

				var bnoValue = '<c:out value="${board.bno}"/>';
				var replyUL = $(".chat");

				showList(1);
			
				// 댓글 보여주기 기능
				function showList(page) {replyService.getList({bno : bnoValue,page : page || 1},
										function(replyCnt, list) {
											if(page == -1){
												pageNum = Math.ceil(replyCnt/10.0);
												showList(pageNum);
												return;
											}
					
											var str = "";

											if (list == null || list.length == 0) {
												return;
											}

											for (var i = 0, len = list.length || 0; i < len; ++i) {
													str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
													str += "  <div> <div class='header'> <strong class='primary-font'>" + list[i].replyer + "</strong>";
													str += "  <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>"
													str += "  <p>" + list[i].reply + "</p></div></li>"
											}

											replyUL.html(str);
											
											showReplyPage(replyCnt);
									}); // end of function
				} // end showList
				
				var modal = $(".modal");
				var modalInputReply = modal.find("input[name ='reply']");
				var modalInputReplyer = modal.find("input[name ='replyer']");
				var modalInputReplyDate = modal.find("input[name ='replyDate']");
				
				var modalModBtn = $("#modalModBtn");
				var modalRemoveBtn = $("#modalRemoveBtn");
				var modalRegisterBtn = $("#modalRegisterBtn");
				
				// 댓글추가 선택시 모달 띄우기
				$("#addReplyBtn").on("click", function(e){
					modal.find("input").val("");
					modalInputReplyDate.closest("div").hide();
					modal.find("button[id != 'modalCloseBtn']").hide();
					
					modalRegisterBtn.show();
					
					$(".modal").modal("show");
					
				});
				
				// 서비스 등록 버튼 시 등록 및 list보여주기
				modalRegisterBtn.on("click", function(e){
					var reply = {reply : modalInputReply.val(), replyer : modalInputReplyer.val(), bno:bnoValue};
					
					replyService.add(reply, function(result){
						alert(result);
						
						modal.find("input").val("");
						modal.modal("hide");
						
						//showList(1);
						showList(-1);
					});
				});
				
				modalModBtn.on("click", function(e){
					var reply = {rno:modal.data("rno"), reply:modalInputReply.val(), replyer:modalInputReplyer.val()};
					
					replyService.update(reply, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});
				
				modalRemoveBtn.on("click", function(e){
					var rno = modal.data("rno");
					
					replyService.remove(rno, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});
				
				// 댓글 클릭시 모달 띄워주기
				replyUL.on("click","li",function(e){
					var rno = $(this).data("rno");
					
					replyService.get(rno, function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
						modal.data("rno",reply.rno);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
					});
				});
				
				// 댓글기능
				var pageNum = 1;
				var replyPageFooter = $(".panel-footer");
				
				function showReplyPage(replyCnt) {
					//console.log(replyCnt)
					
					var endNum = Math.ceil(pageNum / 10.0) * 10;
					var startNum = endNum - 9;
					
					var prev = startNum != 1;
					var next = false;
					
					if(endNum * 10 >= replyCnt){
						endNum = Math.ceil(replyCnt/10.0)
					}
					
					if(endNum * 10 < replyCnt){
						next = true;
					}
					
					var str = "<ul class='pagination pull-right'>";
					
					if(prev){
						str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>이전</a></li>"
					}
					
					for(var i = startNum; i <= endNum; ++i){
						var active = pageNum == i? "active" : "";
						
						str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>"
					}
					
					if(next){
						str += "<li class='page-item " + active + " '><a class='page-link' href='" + (endNum + 1) + "'>다음</a></li>"
					}
					
					str += "</ul></div>"
					
					//console.log(str);
					
					replyPageFooter.html(str);
				}
				
				replyPageFooter.on("click","li a",function(e){
					e.preventDefault();
					
					var targetPageNum = $(this).attr("href");
					
					pageNum = targetPageNum;
					
					console.log(pageNum);
					
					showList(pageNum);
				});
				
			});		
			</script>
			
			<script>
			$(document).ready(function() {
				
			
			});
			</script>
			
			<!--  board 기능 script -->
			<script type="text/javascript">
 			$(document).ready(function(){
 				var operForm = $("#operForm");
 				
 				$("button[data-oper='modify']").on("click", function(e){
 					operForm.attr("action", "/board/modify").submit();
 				});
 				
				$("button[data-oper='list']").on("click", function(e){
 					operForm.find("#bno").remove();
 					operForm.attr("action","/board/list").submit();
 					
 				});
 				
 			});
 			</script>
 			
 			<!--  파일 기능 script -->
			<script type="text/javascript">
			$(document).ready(function(){
				var bno = '<c:out value="${board.bno}"/>'
				
				// event listener
				$(".uploadResult").on("click","li",function(e){
					var liObj = $(this);
					
					var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
					
					if(liObj.data("type")){
						showImage(path.replace(new RegExp(/\\/g), "/"));
					}else{
						self.location="/download?fileName=" + path;
					}
				}); // end of uploadResult click
				
				$(".bigPictureWrapper").on("click",function(e){
					$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
					
					setTimeout(function(){
						$(".bigPicture").hide();
					}, 1000);
				});
				
				// getJson
				$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
					//console.log(arr);
					
					var str = "";
					
					$(arr).each(function(i, obj){
						if(obj.fileType){
							var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
							
							str += "<li data-path='" + obj.uploadPath +"'";
							str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'><div>";
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
							str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'><div>";
							str += "<span> " + obj.fileName + "</span>";
							str += "<button type='button' data-file=\'" + fileCallPath;
							str += "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
							str += "<img src='/resources/img/attach.png'></a>";
							str += "</div></li>";
						}
					});
					
					$(".uploadResult ul").html(str);
					
				}); // end of getJSON
				
				// function
				function showImage(fileCallPath){
					alert(fileCallPath);
					
					$(".bigPictureWrapper").css("display", "flex").show();
					
					$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>")
					.animate({width:'100%', height:'100%'}, 1000);
				}
				
				
			}); // end of function
			</script>
			<%@include file="../includes/footer.jsp" %>

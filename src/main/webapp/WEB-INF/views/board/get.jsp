<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl core -->
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl formatting -->
<%@ taglib uri= "http://www.springframework.org/security/tags" prefix="sec" %>

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
							
							<!-- 작성자와 같은 id 이면 modify 가능 -->                            
                            <sec:authentication property="principal" var="pinfo"/>
                            <sec:authorize access="isAuthenticated()">
                            	<c:if test="${pinfo.username eq board.writer}"> 
                            		<button data-oper='modify' class="btn btn-default">수정</button>
                            	</c:if>
                            </sec:authorize>
                            
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
							
							<sec:authorize access="isAuthenticated()">
								<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
							</sec:authorize>
							
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
									<input class="form-control" name='replyer' value='replyer' readonly>
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
				function showList(page) {
					replyService.getList({bno : bnoValue,page : page || 1}, function(replyCnt, list) {
											if(page == -1){
												pageNum = Math.ceil(replyCnt/10.0);
												showList(pageNum);
												return;
											}
					
											var str = "";

											if (list == null || list.length == 0) {
												replyUL.html(str);
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
				
				var replyer = null;
				
				<sec:authorize access="isAuthenticated()">
					replyer = '<sec:authentication property="principal.username"/>';
				</sec:authorize>
				
				var csrfHeaderName = "${_csrf.headerName}";
				var csrfTokenValue = "${_csrf.token}";
				
				//Ajax Spring Security 헤더
				$(document).ajaxSend(function(e,xhr,options){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				});
				
				// 댓글추가 선택시 모달 띄우기
				$("#addReplyBtn").on("click", function(e){
					modal.find("input").val("");
					modal.find("input[name='replyer']").val(replyer);
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
					var originalReplyer = modalInputReplyer.val();
					
					var reply = {rno:modal.data("rno"), reply:modalInputReply.val(), replyer:originalReplyer};
					
					if(!replyer){
						alert("로그인 후 수정이 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					if(replyer != originalReplyer){
						alert("자신이 작성한 댓글만 수정 가능 합니다.");
						modal.modal("hide");
						return;
					}
					
					replyService.update(reply, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});
				
				modalRemoveBtn.on("click", function(e){
					var rno = modal.data("rno");
					
					if(!replyer){
						alert("로그인 후 삭제가 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					var originalReplyer = modalInputReplyer.val();
					
					if(replyer != originalReplyer){
						alert("자신이 작성한 댓글만 삭제 가능 합니다.");
						modal.modal("hide");
						return;
					}
					
					replyService.remove(rno, originalReplyer, function(result){
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
						$(".bigPictureWrapper").hide();
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
							str += "<br>";
							str += "<img src='/display?fileName=" + fileCallPath + "'>";
							str += "</div></li>";
						}
						else{
							var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
							
							var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
							
							str += "<li data-path='" + obj.uploadPath +"'";
							str += " data-uuid='"+ obj.uuid +"' data-filename='"+ obj.fileName+"' data-type='"+ obj.fileType +"'><div>";
							str += "<span> " + obj.fileName + "</span>";
							str += "<br>";
							str += "<img src='/resources/img/attach.png'></a>";
							str += "</div></li>";
						}
					});
					
					$(".uploadResult ul").html(str);
					
				}); // end of getJSON
				
				// function
				function showImage(fileCallPath){
					//alert(fileCallPath);
					
					$(".bigPictureWrapper").css("display", "flex").show();
					
					$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>")
					.animate({width:'100%', height:'100%'}, 1000);
				}
				
				
			}); // end of function
			</script>
			<%@include file="../includes/footer.jsp" %>

# FirstWebPjt_Board
Spring 게시판 프로젝트

1. 사용 기술 
- 프론트엔드 : JSP(AJAX, JSTL), JQUERY, HTML, CSS
- 백엔드 : JAVA(SPRING), REST API

2. 구현 기능
- 게시글 CRUD
- 댓글 기능 구현 완료(RestApi, Ajax)
- Local FILE IN, OUT 구현 및 관련 화면 구현
 . ajax로 rest api 호출 및 json데이터를 받아서 화면 구현
 . $(this).closest("li") 로 가장 가까운 li 반환, remove로 제거
- RDB에 파일 경로 CRUD
 . 파일경로 RDB에 저장
 . RDB에 저장된 파일경로를 쿼리해와서 로컬에 저장된 파일 출력
 . 게시글 삭제 시 foreign key로 엮인 파일 삭제
 . 게시글 수정 시 파일 수정
- Quartz라이브러리를 통한 Scheduling으로 DB상에 저장되있지 않은 파일 제거(게시물에 대한 파일 관리, sysdate - 1)
- 스프링 security 적용
  . xml 기반 security-context.xml 추가
  . bycrptPassword Encoder 사용
  . UserDetailService 구현
  . POST, DELETE, PUT, PATCH등 진행시 csrf 값 헤더 정보에 포함
  . 게시물, 댓글 crud 시 spring security 기반 로그인 validation

3. 데이터베이스 관계도(작성 예정)

4. 진행 예정
  . 기존 스케줄링으로 sysdate - 1로 관리되고있던 지워진 파일 삭제관련 관리를 Flag처리를 하여 DB기반 경로로 관리 예정, 적용 사유 매일 로컬서버를 실행하지 않음

<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="uploadfeedcontainer">
   <input id="recent" type="hidden" value="${ article.articleNo }">
   <div class="w3-container w3-section w3-border firstrow">
      <div style="float: left;">
         <i class="glyphicon glyphicon-user"></i>&nbsp;${article.id }
      </div>
      <fmt:formatDate var="dateString" value="${article.regDate}"
         type="date" pattern="yyyy년MM월dd일 HH:mm:ss" />
      <div style="float: right;">${ dateString }</div>
      <br /> <br /> ${article.mainImage}
   </div>

   <div class="w3-container w3-section w3-border thirdrow">
      <div>
         <input class="articleNo" type="hidden" value="${article.articleNo}">

		<!--추천기능 -->
	         <a style="float: left;" id="recommendButton1_${article.articleNo}"
	            data-articleno="${article.articleNo}"> 
	            <!-- 추천 유무  -->
	            <c:if test="${zero eq null}">
	               <img style="float: left;" class="heart_${article.articleNo}"
	                  src="/ssola2/resources/images/emptyheart.png" data-toggle="tooltip"
	            title="좋아요:)!">
	            </c:if> <c:if test="${zero eq '0'}">
	               <img style="float: left;" class="heart_${article.articleNo}"
	                  src="/ssola2/resources/images/fullheart.png" data-toggle="tooltip" 
	                  title="좋아요 취소하게?힝..ㅠ" >
	            </c:if> <!--좋아요 --> 
	            <span class = "count" data-count="${recommend.count}" style="float: left;" id="count_${article.articleNo}">${recommend.count}</span>
	         </a>
         
        <c:if test="${loginuser.id != null }"> 
         <a href="/ssola2/detail.action?articleNo=${article.articleNo}"
            data-toggle="tooltip" title="댓글 작성하러!"> <img
            src="/ssola2/resources/images/comment.png">
         </a> 
         </c:if>
         <c:if test="${loginuser.id == null }" >
          <img data-toggle="tooltip" title="로그인 하세요!"
            src="/ssola2/resources/images/comment.png"> 
         </c:if>
         <a style="float: right;"
            href="/ssola2/mypage/scrapInfo.action?articleNo=${article.articleNo}"
            data-toggle="tooltip" title="스크랩 클릭!"> <img
            src="/ssola2/resources/images/scrap.png">
         </a>
      </div>

   </div>
</div>
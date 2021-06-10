<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String hashtag = request.getParameter("hashtag");
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<script src="https://kit.fontawesome.com/5e5186ce3e.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<link href="/css/search/modal.css" rel="stylesheet" type="text/css">
<link href="/css/search/hashtagresult.css" rel="stylesheet" type="text/css">
<title>HashHershe</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	//좋아요순, 최신순 화면 출력
	$("#favoriteBtn").on('click', function(){
		$("#thumbsupView").css("display", "block");
		$("#recentView").css("display", "none");
	});
	
	$("#recentUpdateBtn").on('click', function(){
		$("#thumbsupView").css("display", "none");
		$("#recentView").css("display", "block");
	});
	
	var hashtagtest = $("#searchbar").val() //.split(" ")
	//var hashtagtest = getHashtag[0]
	//console.log("test"+hashtagtest)
	if(hashtagtest==null||hashtagtest==""){ //뒤로가기를 했다가 다시 앞으로 오기를 할 때 모든 게시글을 불러오는 버그를 방지
		$(".thumbsupList").html("<p class='resultNone'>검색 결과가 없습니다.</p>");
		$(".recentList").html("<p class='resultNone'>검색 결과가 없습니다.</p>");
	}
	var hashtagArr = []; //검색어의 중복을 방지하기 위한 array
//	var list = "";
		$.ajax({
			url :"/hashtagsearch",
			type : "get",
			data : {"hashtag" : hashtagtest},
			dataType : "json",
			success : function(response){
				//console.log(response);
				var list = response;

				var totalHashtag = list.length; //검색결과 총 갯수
				$("#searchbar").val("")
				$("#searchbar").attr("placeholder", hashtagtest+" "+totalHashtag+"개 게시물")
				
				//좋아요순으로 정렬
				$(".thumbsupList").text("");
				var thumbsupList = list.sort(function(a, b){
					return b.thumbsup - a.thumbsup;
				});
				for(var i=0; i<thumbsupList.length; i++){
					var imageName = thumbsupList[i].imagepath.split("/");
					var postNumber = thumbsupList[i].postNum
					$(".thumbsupList").append
						("<div class=imageFrame><img class='listImage' src='/upload/"+imageName[imageName.length-1]+
								"' onclick='clickimage("+postNumber+")'></div>");
				} //for end	
				
				//최신순으로 정렬
				$(".recentList").text("");
				var recentList = list.sort(function(a, b){
					return new Date(b.postDate) - new Date(a.postDate);
				});
				
				for(var i=0; i<recentList.length; i++){
					var imageName = recentList[i].imagepath.split("/");
					var postNumber = recentList[i].postNum
					
					$(".recentList").append
						("<div class=imageFrame><img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'></div>");					
				} // for end
			}, // success end
			error : function(e){
					console.log(e);
				} // error end
		}); // ajax end	
}); //ready function end

var CheckThumbsup = 0; //모달창을 띄웠을 때 기존에 좋아요를 눌렀는지 체크
var CheckCommentThumbsup = 0; //댓글창에 좋아요를 눌렀는지 체크??
//var myid = "aiu10"; // 현재 로그인한 아이디를 세션에서 받아옴, 현재 테스트용 admin으로 설정
var myid = sessionStorage.getItem("user") //로그인한 아이디를 세션에서 받아오는 방법
var postNum = 0; // 클릭한 이미지의 포스트번호 저장
var totalThumbs = 0; // 총 좋아요 개수 저장
var contents = []; // 좋아요 누른 사람을 저장하는 리스트

function clickimage(postNumber){ // 이미지 클릭시 게시글 모달창으로 나타냄
	$(".modal").fadeIn();
	$("body").css("overflow-y", "hidden")
	$("html").css("overflow-y", "hidden")
	$(".modalContent").text("")
	postNum = parseInt(postNumber);
	
	$.ajax({ //전달받은 postNum 조회
		url :"/postnumsearch",
		type : "get",
		data : {"postNum" : postNum},
		dataType : "json",
		success : function(response){ //모달창에 작성
			var contents = response[0];
			var imageName = contents.imagepath.split("/")
			var hashtag = contents.hashtag.split("#")
			var commentList = []
			hashtag.shift(0)
			var postID = contents.id;
						
			var profileImagePath = FunctionGetContentProfileImage(postID); // 게시글 작성자의 프로필 이미지 불러오기	
			FunctionGetComment(postNum, commentList) // 댓글 가져오기 함수
						
			$(".modalContent").append(
				"<div class=modalHeader><i class='far fa-window-close fa-3x' id='windowClose' onclick='modalClick()'></i>"+
				"<div class='postDate'>게시일 : "+contents.postDate+"</div>"+
				"<div class='postProfileImage' onclick=location.href='/profile?id="+contents.id+"'><img class=commentImage src='"+profileImagePath+"'></div>"+ //
				"<div class='postID'>아이디 : <a href='/profile?id="+contents.id+"'>"+contents.id+"</a></div><div>")
			$(".modalContent").append(
				"<div class='modalArticle'>"+
				"<img class='contentsImage' src='/upload/"+imageName[imageName.length-1]+"' ondblclick='thumbsup()'></div>"+ // admin을 이후 세션 id값으로 변경
				"<div class='modalAside'><div class='commentsTitle'>댓글"+
				"<div class='commentsList'></div>"+
				"<div class='postComment'><input id='myComment' type='text' onkeyup='enterkey(\""+contents.postNum+"\")' placeholder='댓글을 입력하세요'>"+
	 			"<input id='commentBtn' type='button' value='작성' onclick='addComment(\""+contents.postNum+"\")'></div>"+
				"</div></div>")
			$(".modalContent").append("<p class='postContents'>내용 : "+contents.contents+"</p>")
			$(".modalContent").append("<div class='postHashtag'></div>")
			for(var i in hashtag){
				$(".modalContent").append(
						$(".postHashtag").append(
								"<a class=hashtagLink href='https://search.shopping.naver.com/search/all?query="
						+hashtag[i]+"&cat_id=&frm=NVSHATC' target='_blank'>#"+hashtag[i]+"</a>&nbsp"))
			} // for end
			FunctionThumbsupSearch(postNum) // 좋아요 불러오기
		}, //success end
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} // error end
	}); //outer ajax end
}// function end
//엔터키 입력(a - 97  0 - 48 엔터키 - 13)하면 send  함수 동일 효과
function enterkey(postNum){
	if(window.event.keyCode == 13){
		addComment(postNum);
	}
}//function end
// 모달 창 function
var modalStatus = 0; // 모달창을 클릭한 것인지, 배경을 클릭한 것인지 구분
var editmodalState = 0;
function modalClick(){
	if(modalStatus==0){
		$("body").css("overflow-y", "scroll")
		$("html").css("overflow-y", "scroll")
		$(".modal").fadeOut();
		$("#cedit").fadeIn();
		$("#cdelete").fadeIn();
		$("#updateMyComment").html("");
		$(".commentEditModal").fadeOut();
		$("#redit").fadeIn();
		$("#rdelete").fadeIn();
		$("#updateMyReply").html("");
		$(".replyEditModal").fadeOut();
	} else if(modalStatus==1) {
		modalStatus = 0;
	} // elseif end
} // modalClick end
function modalContentClick(){
	modalStatus = 1;
	if(editmodalState==0){
		$("#cedit").fadeIn();
		$("#cdelete").fadeIn();
		$("#updateMyComment").html("");
		$(".commentEditModal").fadeOut();
		$("#redit").fadeIn();
		$("#rdelete").fadeIn();
		$("#updateMyReply").html("");
		$(".replyEditModal").fadeOut();
	}
	editmodalState=0;
} // modalContentClick end


function thumbsup(){ //좋아요 누르기 / 취소하기
	var id = myid;
	if(CheckThumbsup == 0){ //좋아요가 눌려있지 않은 경우
		$.ajax({
			url : "/thumbsplus",
			type : "get",
			data : {
				"postNum" : postNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs+1;
				CheckThumbsup = parseInt(response);
				$(".postThumbsup").text(" 좋아요 : "+totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".thumbsupButton").html("<i class='fas fa-heart fa-2x'></i>")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	} 
	else { // 좋아요가 이미 눌려있는 경우
		$.ajax({
			url : "/thumbsminus",
			type : "get",
			data : {
				"postNum" : postNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs-1;
				CheckThumbsup = parseInt(response);
				$(".postThumbsup").text(" 좋아요 : "+totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".thumbsupButton").html("<i class='far fa-heart fa-2x'></i>")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	}// else end
} // function thumbsup end
//좋아요 개수, 좋아요 누른 사람 반환
function FunctionThumbsupSearch(postNum){
	$.ajax({ 
		url : "/thumbsupsearch",
		type : "get",
		data : {"postNum" : postNum},
		dataType : "json",
		success : function(response){
			contents = []
			CheckThumbsup = 0; //현재 게시물 좋아요를 눌렀는지 판단
			for(var i in response){
				contents.push(response[i]);
				//console.log(contents)
				if(response[i].id == myid){ //현재는 admin 계정으로 간주, 이후 세션 id값으로 변경
					CheckThumbsup = 1; 							
				} //if end
			}//for end
			totalThumbs = contents.length; // 좋아요 개수
			//console.log(totalThumbs)
			if(CheckThumbsup == 0){ //좋아요가 눌려져 있지 않음
				$(".modalContent").append
				("<div class='thumbsupBox'><span class='thumbsupButton' onclick='thumbsup()'>"+
				"<i class='far fa-heart fa-2x'></i></span>"+
				"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");
			} else { //좋아요가 눌려져 있음
				$(".modalContent").append
				("<div class='thumbsupBox'><span class='thumbsupButton' onclick='thumbsup()'>"+
				"<i class='fas fa-heart fa-2x'></i></span>"+
				"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");						
			}// if else end	
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} // error end 
	}); // ajax end
}
// 댓글 작성 기능
function addComment(postNum){
	var myComment = $("#myComment").val() //댓글입력창의 값을 추출
	if(myComment == null || myComment.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 작성하시겠습니까?")){
// 		var id = myid
		var postNum = postNum		
		$.ajax({
			url: "/addcomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": myComment,
				"id" : myid
			},
			dataType : "text",
			success : function(response){
				//console.log(response)
				var commentList = []
				$(".commentsList").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 작성이 완료되었습니다.")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}//addComment end
// 댓글 내용 반환 
function FunctionGetComment(postNum, commentList){
	$.ajax({ //댓글 불러옴
		url: "/getcomment",
		type: "post",
		data : {"postNum" : postNum},
		dataType : "json",
		//async: false,
		success: function(response){
			for(var i=0; i<response.length; i++){
				//console.log(response[i])
				commentList.push(response[i])
			}
			//console.log(commentList)
			if(commentList.length==0){
				$(".commentsList").html("<p class=commentEmpty>댓글이 없습니다.</p>")
			} // if end
			else { // 댓글 불러오기
				// 프로필 사진 불러오기
				for(var i=0; i<commentList.length; i++){
					FunctionGetProfileImage(commentList[i], i)
				}// for end
			}
		},//success end
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	})//ajax end
} //function end


//댓글 프로필 이미지, 내용 반환
var CheckCommentThumbsup = 0; //현재 게시물 좋아요를 눌렀는지 판단
function FunctionGetProfileImage(commentList, i){
	var profileImage = "";
	var cnt = i;
	$.ajax({ 
		url: "/getprofileimage",
		type: "post",
		data: {"id" : commentList.id},
		dataType: "text",
		async: false,
		success: function(response){					
			if(response=="0"){ //프로필 사진이 없을 때
				profileImage = '/images/basicprofileimage.jpg';
			}
			else {
				var imagePath = response.split("/")
				var imageName = imagePath[imagePath.length-1]
				profileImage = '/upload/'
				profileImage += imageName
			}//else end
			
			$.ajax({ 
				url : "/getcommentthumbsup",
				type : "post",
				data : {"commentNum" : commentList.commentNum},
				dataType : "json",
				async: false,
				success : function(response){
					contents = []
					for(var i in response){
						contents.push(response[i]);
// 						CheckCommentThumbsup = 0; 	
						if(response[i].id == myid){ //현재는 admin 계정으로 간주, 이후 세션 id값으로 변경
							CheckCommentThumbsup = 1; 							
						} //if end
					}//for end
					var totalThumbs = contents.length; // 좋아요 개수
						
						$(".commentsList").append
						("<div class=oneComment>"+
						"<span><image class='commentImage' src='"+profileImage+"' onclick=location.href='/profile?id="+commentList.id+"'></span>"+
						"<div><p style='float:left; font-weight:bold' onclick=location.href='/profile?id="+commentList.id+"'> "+commentList.id+"</p>"+
						"<p class='contents' id='contents_"+cnt+"' style='text-align:left'> "+commentList.comments+"</p>"+
						"<span><p>"+commentList.commentsDate+"</p></span>"+
						"<span class='commentUD' onclick='FunctionEditComment(\""+commentList.id+"\", "+commentList.commentNum+", "+cnt+")'>"+
						"<i class='fas fa-ellipsis-h'></i></span></div>"+
						"<span class=commentThumbsup_"+cnt+" onclick='commentThumbsup("+CheckCommentThumbsup+", "+commentList.commentNum+", "+totalThumbs+", "+cnt+")'></span>"+
						"<span class='seeReply' id='seeReply_"+cnt+"' onclick='ShowReply("+cnt+")'></span>"+
						"<span class='reply' id='reply_"+cnt+"' onclick='writeReply("+commentList.commentNum+", "+cnt+")'>답글달기</span>"+
						"<div class='replyList' id='replyList_"+cnt+"'></div>"+ //style='display:none;'
						"</div>");
						if(CheckCommentThumbsup == 0){ //좋아요가 눌려있음
							$(".commentThumbsup_"+cnt+"").html("<i class='far fa-heart'></i> 좋아요 "+totalThumbs+"개 </span>")
						} else if(CheckCommentThumbsup == 1){ // 좋야요가 눌려있지않음
							$(".commentThumbsup_"+cnt+"").html("<i class='fas fa-heart'></i> 좋아요 "+totalThumbs+"개 </span>")
						}// if else end	
					CheckCommentThumbsup = 0;
				},
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				} // error end 
			}); // ajax end	
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	})//ajax end	
	FunctionGetReply(commentList.commentNum, cnt) 
}// function end

//댓글에 좋아요 누르기
function commentThumbsup(CheckCommentThumbsup, commentNum, totalThumbs, cnt){
	var id = myid;
	var num = commentNum;
	
	if(CheckCommentThumbsup == 0){ //좋아요가 눌려있지 않은 경우
		$.ajax({
			url : "/commentthumbsplus",
			type : "get",
			data : {
				"commentNum" : commentNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs+1;
				CheckCommentThumbsup = 1; //parseInt(response);
				//console.log(CheckCommentThumbsup)
				$(".commentThumbsup_"+cnt+"").removeAttr("onclick") //클릭 속성 제거
				$(".commentThumbsup_"+cnt+"").attr("onclick", "commentThumbsup("+CheckCommentThumbsup+", "+commentNum+", "+totalThumbs+", "+cnt+")") //클릭 속성 내 Check~값 변경
				$(".commentThumbsup_"+cnt+"").html("<i class='fas fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	} 
	else if(CheckCommentThumbsup == 1){ // 좋아요가 이미 눌려있는 경우
		$.ajax({
			url : "/commentthumbsminus",
			type : "get",
			data : {
				"commentNum" : commentNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs-1;
				CheckCommentThumbsup = 0; //parseInt(response);
				$(".commentThumbsup_"+cnt+"").removeAttr("onclick") //클릭 속성 제거
				$(".commentThumbsup_"+cnt+"").attr("onclick", "commentThumbsup("+CheckCommentThumbsup+", "+commentNum+", "+totalThumbs+", "+cnt+")") //클릭 속성 내 Check~값 변경
				$(".commentThumbsup_"+cnt+"").html("<i class='far fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	}// else end
	return true;
}

// 컨텐츠 클릭시 작성자 프로필 이미지 추출
function FunctionGetContentProfileImage(postID){
	var profileImage = "";
	$.ajax({ 
		url: "/getprofileimage",
		type: "post",
		data: {"id" : postID},
		dataType: "text",
 		async: false,
		success: function(response){
			if(response=="0"){ //프로필 사진이 없을 때
				profileImage = '/images/basicprofileimage.jpg';
				return profileImage;
			}
			else {
				var imagePath = response.split("/")
				//console.log("경로 : "+ imagePath)
				var imageName = imagePath[imagePath.length-1]
				//console.log("이미지이름 : "+ imageName)
				profileImage = '/upload/'
				profileImage += imageName
			} // else end
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	}); //ajax end
	return profileImage;
}// function end

//서치 돋보기 클릭시 서치값 같이 넘김
function wordsearch(){
	var f = document.searchForm;
	f.submit();
}//function end

//댓글 달기
function FunctionCommentThumbs(){
	var myComment = $("#myComment").val() //댓글입력창의 값을 추출
	if(myComment == null || myComment.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 작성하시겠습니까?")){
		var id = myid
		var postNum = postNum		
		$.ajax({
			url: "/addcomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": myComment,
				"id" : myid
			},
			dataType : "text",
			success : function(response){
				//console.log(response)
				var commentList = []
				$(".commentsList").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 작성이 완료되었습니다.")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}

//댓글 수정 및 삭제
var cntCommentNum = 0; //넘어온 댓글 번호
var cntNum = 0; // 넘어온 댓글의 일련번호(?)
function FunctionEditComment(id, commentNum, cnt){ // 댓글 옆 ... 누르기
	if(id!=myid){
		alert("수정 및 삭제 권한이 없습니다.")
	} else {
		$(".commentEditModal").fadeIn();
		editmodalState=1;
		cntCommentNum = commentNum;
		cntNum = cnt; 
	}
}

function updateEnterkey(){
	if(window.event.keyCode == 13){
		UpdateComment();
	}
}
function gotoUpdateComment(){ // 댓글 수정창 띄우기
	if(confirm("댓글을 수정하시겠습니까?")){
		$("#cdelete").fadeOut();
		$("#updateMyComment").html(
		"<input id='updatebox' type='text' value='"+$("#contents_"+cntNum+"").text()+"' onkeyup='updateEnterkey()'>"+
		"<input id='commentBtn' type='button' value='작성' onclick='UpdateComment()'>")
		console.log(postNum)
	}
}

function UpdateComment(){ //댓글 수정하기
	var update = String($("#updatebox").val()) //댓글입력창의 값을 추출
	if(update == null || update.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 수정하시겠습니까?")){
		console.log(postNum, update, myid, cntCommentNum)
		$.ajax({
			url: "/updatecomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": update,
				"id" : myid,
				"commentNum" : cntCommentNum
			},
			dataType : "text",
			success : function(){
				var commentList = []
				$(".commentsList").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 수정이 완료되었습니다.")
				modalContentClick()			
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}

function DeleteComment(){ // 댓글 삭제하기
	console.log(myid, cntCommentNum)
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "/deletecomment",
			type: "post",
			data: {
				"id" : myid,
				"commentNum" : cntCommentNum
			},
			dataType: "text",
			success: function(){
				alert("삭제가 완료되었습니다.")
				var blankList = []
				$(".commentsList").html("")
 				FunctionGetComment(postNum, blankList)
 				modalContentClick()	
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		})//ajax end
	}//if end
}//function end

//답글 불러오기
function FunctionGetReply(commentNum, cnt){
	$.ajax({
		url: "/getreply",
		type: "post",
		data: {
			"commentNum" : commentNum,
			"postNum" : postNum
		},
		asyns: false,
		dataType: "json",
		success: function(response){
			var list = [];
			for(var i in response){
				list.push(response[i])
			}//for end
			
			if(list.length!=0){
				for(var i=0; i<list.length; i++){
					var profileImagePath = FunctionGetContentProfileImage(list[i].id)

					$("#seeReply_"+cnt+"").text("답글 "+list.length+"개");
					$("#replyList_"+cnt+"").append(
					"<div><img class=commentImage src='"+profileImagePath+"' onclick=location.href='/profile?id="+list[i].id+"'>"+
					"<p style='float:left; font-weight:bold' onclick=location.href='/profile?id="+list[i].id+"'>"+list[i].id+"</p>"+
					"<span id='replycomments_"+i+"'><p>"+list[i].comments+"</p></span>"+
					"<p>"+list[i].commentsDate+"</p>"+
					"<span class='commentUD' onclick='FunctionEditReply(\""+list[i].id+"\", "+list[i].replyNum+", "+cnt+", "+list[i].commentNum+", "+i+")'>"+
					"<i class='fas fa-ellipsis-h'></i></span></div>")
				}//for end
			}//if end
		},
		error: function(e){
			console.log(e)
		}
	});
	$("#replyList_"+cnt+"").css("display","none")
// 	commentNum: 121 / comments: "대댓글1" / commentsDate: "2021-06-10 01:22:42" / id: "aiu10"/ postNum: 37 / replyNum: 1
} //function end

// 답글(대댓글) 보이기 / 숨기기
var ReplyDivState = 0;
function ShowReply(cnt){
	if(ReplyDivState==0){
		$("#replyList_"+cnt+"").css("display", "block");	
		ReplyDivState = 1;
	} else {
		$("#replyList_"+cnt+"").css("display", "none");
		ReplyDivState = 0;
	}
}


//답글 수정 및 삭제
var cntReplyNum = 0; //넘어온 답글 번호
var cntRep = 0; // 넘어온 답글 일련번호 (cnt)
var cntRepCommentNum = 0;  // 넘어온 댓글 번호
var cntRepList = 0; // 넘어온 답글 번호
function FunctionEditReply(id, replyNum, cnt, commentNum, i){ // 댓글 옆 ... 누르기
	if(id!=myid){
		alert("수정 및 삭제 권한이 없습니다.")
	} else {
		$(".replyEditModal").fadeIn();
		editmodalState=1;
		cntReplyNum = replyNum;
		cntRep = cnt; 
		cntRepCommentNum = commentNum;
		cntRepList = i; 
	}
}

function replyUpdateEnterkey(){
	if(window.event.keyCode == 13){
		UpdateReply();
	}
}
function gotoUpdateReply(){ // 답글 수정창 띄우기
	if(confirm("답글을 수정하시겠습니까?")){
		//$("#redit").fadeOut();
		$("#rdelete").fadeOut();
		$("#updateMyReply").html(
		"<input id='updatebox' type='text' value='"+$("#replycomments_"+cntRepList+"").text()+"' onkeyup='replyUpdateEnterkey()'>"+
		"<input id='commentBtn' type='button' value='작성' onclick='UpdateReply()'>")
	}
}

function UpdateReply(){ //답글 수정하기
	var update = String($("#updatebox").val()) //답글입력창의 값을 추출
	if(update == null || update.trim() == ""){ //답글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("답글을 수정하시겠습니까?")){
		$.ajax({
			url: "/updatereply",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": update,
				"id" : myid,
				"replyNum" : cntReplyNum
			},
			dataType : "text",
			success : function(){
				$("#replyList_"+cntRep+"").text("")				
				FunctionGetReply(cntRepCommentNum, cntRep)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("답글 수정이 완료되었습니다.")
				modalContentClick()			
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}

function DeleteReply(){ // 답글 (대댓글) 삭제하기
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "/deletereply",
			type: "post",
			data: {
				"id" : myid,
				"replyNum" : cntReplyNum
			},
			dataType: "text",
			success: function(){
				alert("삭제가 완료되었습니다.")
				var blankList = []
				$(".commentsList").html("")
 				FunctionGetComment(postNum, blankList)
 				modalContentClick()	
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		})//ajax end
	}//if end
}//function end


// 답글 남기기
var writeReplyState = 0;
function writeReply(commentNum, cnt){ //commentID, 
	if(writeReplyState==0){
		$("#reply_"+cnt+"").html(
			"답글취소"+
			"<div class='replyBox'><input type='text' class='writeReply' placeholder='답글을 입력하세요' onkeyup='Replyenterkey("+commentNum+", "+cnt+")'>"+
			"<input id='replyBtn' type='button' value='작성' onclick='addReply("+commentNum+", "+cnt+")'></div>")
		$(".replyBox").on('click', function(e){
			e.preventDefault();
			e.stopPropagation();
		});	
		writeReplyState = 1;
	} else {
		$("#reply_"+cnt+"").html("답글달기")
		writeReplyState = 0;
	}
}


// 답글 남길때 엔터키 누르기
function Replyenterkey(commentNum, cnt){
	if(window.event.keyCode == 13){
		addReply(commentNum, cnt);
	}
}// function end

// 답글 추가하기
function addReply(commentNum, cnt){
	var text = $(".writeReply").val(); // 답글입력창 값 추출
	if(text == null || text.trim() == ""){ // 입력창에 값이 없을경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("답글을 작성하시겠습니까?")){
		$.ajax({
			url: "/addreply",
			type: "post",
			data:{
				"postNum": postNum,
				"commentNum": commentNum,
				"comments": text,
				"id": myid
			},
			success:function(response){
				$("#replyList_"+cnt+"").text("") // 답글창 초기화
				FunctionGetReply(commentNum, cnt) // 답글 불러오기 함수
				alert("답글 작성이 완료되었습니다.")
				$(".writeReply").val("") //답글 등록후 작성창에 내용 삭제
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		}) //ajax end
	}// if end
}



</script>
</head>
<body>
<h1>해시태그 검색 리스트</h1>
<form action="/search" method="post" name="searchForm">
<div class="bar">
	<input type="text" id=searchbar name="searchWord" value='#<%=hashtag %>'>
<!-- 	<input type="submit" value="search"> -->
	<i class="fas fa-search fa-3x" id=fa-search type="submit" id="searchbutton" onclick="wordsearch()"></i>
</div>
</form>


<div id="searchBtn">
	<button id="favoriteBtn">인기 게시물</button>
	<button id="recentUpdateBtn">최근 게시물</button>
</div>

<div id=messageWindow>		
	<div id=thumbsupView>
		<div class="thumbsupBlock">
			<div class="thumbsupList"></div>
		</div>		
	</div>
	
	<div id=recentView>
		<div class="recentBlock">
			<div class="recentList"></div>	
		</div>
	</div>
</div>

<div class="modal" onclick="modalClick()">
	<div class="modalContent" onclick="modalContentClick()">
	</div>
</div>

<div class="commentEditModal"
  style='display:none; width:400px; height:200px;
  background:rgba(244,238,238,1); border-radius:10px;
  position:fixed; top:50%; left:50%;
  margin-top:-100px; margin-left:-100px; z-index:9999; text-align:center'>
  <div id="cedit" onclick='gotoUpdateComment()' style='width:400px; height:90px; border:3px solid black'><p>댓글 수정</p></div>
  <div id="cdelete" onclick='DeleteComment()' style='width:400px; height:90px; border:3px solid black'><p>댓글 삭제</p></div>
  <div id='updateMyComment'></div> <!-- 0.5초 또는 1초 있다가 나오게 변경해야할듯 -->
</div>
	
<div class="replyEditModal"
  style='display:none; width:400px; height:200px;
  background:rgba(244,238,238,1); border-radius:10px;
  position:fixed; top:50%; left:50%;
  margin-top:-100px; margin-left:-100px; z-index:9999; text-align:center'>
  <div id="redit" onclick='gotoUpdateReply()' style='width:400px; height:90px; border:3px solid black'><p>답글 수정</p></div>
  <div id="rdelete" onclick='DeleteReply()' style='width:400px; height:90px; border:3px solid black'><p>답글 삭제</p></div>
  <div id='updateMyReply'></div> <!-- 0.5초 또는 1초 있다가 나오게 변경해야할듯 -->
</div>

<i class="fas fa-arrow-circle-up fa-3x" id="goToTopBtn" onclick="window.scrollTo(0,0)"></i>

</body>
</html>
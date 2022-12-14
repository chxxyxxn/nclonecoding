<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="com.uj.dao.*" %>
    <%@ page import="com.uj.dto.*" %>
    <%@ page import="com.yg.dao.*" %>
    <%@ page import="com.sns.dao.*"%>
	<%@ page import="com.sns.dto.*"%>
	<%@ page import="com.sns.dto.ProfileDTO" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="test.*" %>
    <%-- <%request.getRequestDispatcher("Controller?command=bookmark").forward(request, response); %> --%>
 
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@192.168.1.12:1521:xe";
String dbId = "oraclePort";
String dbPw = "1234";

Connection conn = null;
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url,dbId,dbPw);
}catch(Exception e) {
	e.printStackTrace();
}
int profileID = Integer.parseInt(request.getParameter("profile_id"));
session.setAttribute("profileId",profileID);
int memberId = (Integer)(session.getAttribute("member_id"));
PostViewDAO pDao = new PostViewDAO();
/* int memberId = pDao.alterProfile(profileID); */

%>
<%-- var memberId = "<%=(int)(session.getAttribute("member_id")) %>" --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="./js/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/55f501ae31.js"crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js" integrity="sha256-eTyxS0rkjpLEo16uXTS0uVCS4815lc40K2iVpWDvdSY=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script>

function addComment(data) {
	var profile
}

function movieModalClose(){
    $(".movie-detail").fadeOut(100);
    $("#background-btm").fadeOut(100);
};
function dramaModalClose(){
    $(".drama-detail").fadeOut(100);
    $("#background-btm").fadeOut(100);
};

window.onload = function() {
	setTimeout (function (){
		scrollTo(0,0);
	},100);
}

var global_yg;

$(function (){
	$("#sns").click(function (){
		/* int email = session.setAttribute("member_id"); */
		location.href = "jspSY/Main.jsp";
	});
	$(".logout-tab").click(function (){
		alert("???????????? ???????????????.");
		location.href="jspCY/Netflix02.jsp";
	});
	$(".account-information-top").click(function (){
		location.href="jspBR/p05.account.jsp"
	});
	$(".profile-link").click(function(){
		location.href="jspBR/p01.account.jsp"
	});
	
	$(".this_button_write").click(function (){
    	var movieDramaId = $(".notice-board").attr('movie_drama_id');
    	var memberId = "<%=profileID%>";
    	var comment = $("#user_comment").val();
    	$(".comment-all-box").scrollTop(0);
		$(".comment-all-box").empty();
    	$.ajax({
    		type: 'get',
    		url: 'CommentWriteServlet',
    		data: {"movie_drama_id" : movieDramaId , "memberId" : memberId , "comment" : comment},
    		datatype: "json",
    		error: function(r,s,e) {
    			alert("?????? ??????!!");
    		},
    		success: function(data) {
				for(var i=0; i<=data.length-1; i++) {
					console.log(i);
					var user_grade = data[i].user_grade;
					var comment_id = data[i].comment_id;
					var profile_id = data[i].profile_id;
					var user_comment = data[i].user_comment;
					var comment_date = data[i].comment_date;
					var like_hitcount = data[i].like_hitcount;
					var unlike_hitcount = data[i].unlike_hitcount;
					
					var str =
						'<div class="comment-box" commentid='+comment_id+'>'
                            +'<div>'
                                +'<form name="myform" id="myform3" method="post" action="./save">'
                                    +'<fieldset id="comment-grade">'
                                        +'<label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">'
                                        +'<label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">'
                                        +'<label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">'
                                        +'<label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">'
                                        +'<label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">'
                                    +'</fieldset>'
                                +'</form>'
                                +'<div class="user-grade">'+user_grade+'???</div>'
                            +'</div>'
                           +'<div>'
                                +'<div class="user-comment">'+user_comment+'</div>'
                            +'</div>'
                            +'<div style="margin-bottom: 10px;">'
                                +'<div class="user-id">'+profile_id+'</div>'
                                +'<div class="comment-day">'+comment_date+'</div>'
                            +'</div>'
                            +'<div>'
                                +'<div class="cm_sympathy_area">'
                                    +'<button type="button" class="area_button_upvote">'
                                       +'<span class="plus-count"><i class="fa fa-thumbs-up" aria-hidden="true">'+like_hitcount+'</i></span>'
                                    +'</button>'
                                    +'<button type="button" class="area_button_downvote">'
                                        +'<span class="mines-count"><i class="fa fa-thumbs-down" aria-hidden="true">'+unlike_hitcount+'</i></span>'
                                    +'</button>'
                                +'</div>'
                            +'</div>'
                        +'</div>';
                        
                	$(".comment-all-box").prepend(str);
				}
			}
    	});
    	
		/* $('.comment-box-original').clone().prependTo(".comment-all-box");
		$(".comment-all-box .comment-box-original").removeClass("comment-box-original").addClass("comment-box") */
		alert("????????? ?????? ???????????????.");  
	}); 
	
	
	
	
	
	$(window).scroll(function (){
		var height = $(window).scrollTop();
		//console.log(height);
		if(height == 0) {
			$("#header").stop().animate({
				backgroundColor : "rgba(0,0,0,0)"
			},700);
		} else {
			$("#header").stop().animate({
				backgroundColor : "rgba(0,0,0,1)"
			},50);
		}
	});
    // ?????? ?????? ??????????????? detail ?????????  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    $('.gray-button').click(function (){
    	var movieDramaId = $(this).attr("detailVideoId");
    	$(".list-box option:eq(0)").prop("selected", true);
    	$(".notice-board").attr('movie_drama_id', movieDramaId);
    	$(".comment-all-box").empty();
    	/* alert(movieDramaId); */
    	if(movieDramaId >=1 && movieDramaId <= 157) {
    		$('.drama-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			error: function(r,s,e){
    				alert("??????!");
    			},
    			success: function(data){
    				global_yg = data;
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".drama-detail").children(".notice-board").children().find("h2").text(title);
    				$(".drama-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    				
    				$(".drama-round-box").empty();
    					$.ajax({
    		    			type: 'get',
    		    			url: 'Controller?command=dramaRoundBoxServletAction',
    		    			data: { "movie_drama_id" : movieDramaId },    
    		    			datatype: "json",
    		    			error: function(r,s,e){
    		    				alert("????????????!!");
    		    			},
    		    			success: function(data){
    		    				global_yg = data;			
    		    				for(var i=0; i<=data.length-1; i++) {
    			    				console.log(i);
    		    					var movie_drama_id = data[i].movie_drama_id;
    		    					var episode_round = data[i].episode_round;
    		    					var episode_image = data[i].episode_image;
    		    					var episode_title = data[i].episode_title;
    		    					var episode_summary = data[i].episode_summary;
    		    					var full_video = data[i].full_video;
    		    					var play_time = data[i].play_time;
    		    					var str =
    		    						'<div class="round-bundle" moviedramaid='+ movie_drama_id +'>'
    		                                   +'<div style="height:75px; margin-top: 26px;">'
    		                                       +'<div class="drama-round">'
    		                                           +episode_round
    		                                       +'</div>'
    		                                   +'</div>'
    		                                   +'<div>'
    		                                   +'<a href='+ full_video +'>'
    		                                       	+'<img style="position:absolute;" class="round-image" src='+episode_image+'>'
    		                                       	+'<div class="round-hover-play-button">'
    		                                       		+'<svg style="position:absolute; width: 45px; height: 28px; margin-top: 10px;" fill="none" xmlns="http://www.w3.org/2000/svg" class="titleCard-playSVG">'+'<path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">'+'</path>'+'</svg>'
    		                                       	+'</div>'
    		                                   	+'</a>'
    		                                       +'<div class="titleCardList">'
    		                                           +'<span class="round-title">'
    		                                               +episode_title
    		                                           +'</span>'
    		                                           +'<span class="round-running-time">'
    		                                               +play_time
    		                                           +'</span>'
    		                                           +'<p class="round-summary">'
    		    										+episode_summary
    		                                           +'</p>'
    		                                       +'</div>'
    		                                   +'</div>'
    		                               +'</div>';
    		    					
    		    					$(".drama-round-box").prepend(str);
    		    				}
    		    				$.ajax({
    		    					type: 'get',
    		    					url: 'Controller?command=GradeServletAction',
    		    					data: {"movie_drama_id" : movieDramaId},
    		    					datatype: 'json',
    		    					error: function(r,s,e) {
    		    						alert("?????? ??????!");
    		    					},
    		    					success: function(data) {
    		    							var grade = data.grade;
    		    							var participation = data.participation;
    		    							
    		    							$(".notice-board").find(".star-grade").text(grade+"???");
    		    							$(".notice-board").find(".participation").text(participation+"??? ??????");
    		    					}
    		    				});
    		    			}
    		    		});
    				}
    		});
    	}else {
    		$('.movie-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			success: function(data){
    				
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".movie-detail").children(".notice-board").children().find("h2").text(title);
    				$(".movie-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    				
    				$.ajax({
    					type: 'get',
    					url: 'Controller?command=gradeServletAction',
    					data: {"movie_drama_id" : movieDramaId},
    					datatype: 'json',
    					error: function(r,s,e) {
    						alert("?????? ??????!");
    					},
    					success: function(data) {
    							var grade = data.grade;
    							var participation = data.participation;
    							
    							$(".notice-board").find(".star-grade").text(grade+"???");
    							$(".notice-board").find(".participation").text(participation+"??? ??????");
    					}
    				});
    			},
    			error: function(r,s,e){
    				alert("??????!");
    			}
    		});
    	}
    	
        /* $('.movie-detail').fadeIn(100);
        $('#background-btm').fadeIn(100); */
    });
    $('.close-icon').click(function (){
        movieModalClose();
    });
    
    //????????? ???????????? ?????????
    $("#account-menu").mouseenter(function() {
        $(".caret").fadeIn(150);
    });
    $(".account-drop-down").mouseleave(function() {
        $(".caret").fadeOut(150);
    });
    
 	//?????? top 10 ????????? ?????? 
 	var px_to_show;
 	var b_complete_animate_hover_preview_container = true; 
    $('.movie-rank').mouseenter(function() {
    	
    	$(".hover-priview-container").fadeIn(500);
    	
    	var idx = $(".movie-rank").index(this);
    	var px_to_show;
    	if(idx<5) {
    		px_to_show = 50 + idx*280;
    	} else if(idx>6) {
    		return; 
    	} else {
    		px_to_show = idx*275;
    	}
    	
    	$(".hover-priview-container").css('left',px_to_show+'px');
    	$(".hover-priview-container").css('display','block');
    	$(".hover-priview-container").animate({
    		opacity:1
    	});
    });
    
    $(".hover-priview-container").mouseleave(function() {
        $(".hover-priview-container").fadeOut(300);
        
    });
    
    //????????? top 10 priview ?????????
    $(".drama-rank").mouseenter(function() {
        $(".drama-hover-priview-container").fadeIn(500);
    	var idx = $(".drama-rank").index(this);
    	var px_to_show;
    	if(idx<5) {
    		px_to_show = idx*280;
    	} else if(idx>6) {
    		return; 
    	} else {
    		px_to_show = idx*265 ;
    	}
    	
    	$(".drama-hover-priview-container").css('left',px_to_show+'px');
    	$(".drama-hover-priview-container").css('display','block');
    	$(".drama-hover-priview-container").animate({
    		opacity:1
    	});
    });
    $(".drama-hover-priview-container").mouseleave(function() {
        $(".drama-hover-priview-container").fadeOut(300);
    });

    //priview box ?????? ???????????? ????????? movie-detail ?????????
    $('.buttonControls').click(function (){
    	$('html').scrollTop(0);
        $('.movie-detail').fadeIn(100);
        $('#background-btm').fadeIn(100);
    });
    $('.close-icon').click(function (){
        movieModalClose()
    });

    //priview box ?????? ???????????? ????????? drama-detail ?????????
    $('.drama-buttonControls').click(function (){
        /* $('html').scrollTop(0); */
        $('.drama-detail').fadeIn(100);
        $('#background-btm').fadeIn(100);
    });
    $('.close-icon').click(function (){
        dramaModalClose()
    });

    /* $('.detail-information-overlay').mousewheel(function (e){
        alert("????????????!");
        e.preventDefault();
        e.stopPropagation();
    });
    $('.notice-board').mousewheel(function (e){
        alert("???????????????!");
        e.preventDefault();
        e.stopPropagation();
    }); */

    //?????? ??????
    
    
    $(".focus-visible").on("keyup",function(key){
    	if(key.keyCode==13) {
    		
    	}
    });
    
    $(".drama-rank").click(function (){
    	var movieDramaId = $(this).find(".boxart-image").attr("movieDramaId");
    	$(".list-box option:eq(0)").prop("selected", true);
    	$(".comment-all-box").empty();
    	$(".notice-board").attr('movie_drama_id', movieDramaId); 
    	$('html').scrollTop(0);
        $('.drama-detail').fadeIn(100);
        $('#background-btm').fadeIn(100); 
        $.ajax({
			type: 'get',
			url: 'YGServlet',
			data: { "movie_drama_id" : movieDramaId },    
			datatype: "json",
			error: function(r,s,e){
				alert("??????!");
			},
			success: function(data){
				global_yg = data;
				var title = data.title;
				var release_day = data.release_day;
				var age = data.age;
				var director = data.director;
				var actor = data.actor;
				var genre = data.genre;
				var summary = data.summary;
				var priview_image = data.priview_image;
				var title_image = data.title_image;
				var first_video = data.first_video;
				var string_age = data.string_age;
				var priview = data.priview;
				$(".movie-detail-information-text").children().find('b').text(title);
				$(".movie-explanation > .year").text(release_day);
				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
				$(".movie-explanation > .movie-contents").text(summary);
				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
				$(".detail-information-overlay-image > img").attr('src',title_image);
				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
				$(".drama-detail").children(".notice-board").children().find("h2").text(title);
				$(".drama-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
				
				$(".drama-round-box").empty();
					$.ajax({
		    			type: 'get',
		    			url: 'Controller?command=dramaRoundBoxServletAction',
		    			data: { "movie_drama_id" : movieDramaId },    
		    			datatype: "json",
		    			error: function(r,s,e){
		    				alert("????????????!!");
		    			},
		    			success: function(data){
		    				global_yg = data;			
		    				for(var i=0; i<=data.length-1; i++) {
			    				console.log(i);
		    					var movie_drama_id = data[i].movie_drama_id;
		    					var episode_round = data[i].episode_round;
		    					var episode_image = data[i].episode_image;
		    					var episode_title = data[i].episode_title;
		    					var episode_summary = data[i].episode_summary;
		    					var full_video = data[i].full_video;
		    					var play_time = data[i].play_time;
		    					var str =
		    						'<div class="round-bundle" moviedramaid='+ movie_drama_id +'>'
		                                   +'<div style="height:75px; margin-top: 26px;">'
		                                       +'<div class="drama-round">'
		                                           +episode_round
		                                       +'</div>'
		                                   +'</div>'
		                                   +'<div>'
		                                   +'<a href='+ full_video +'>'
		                                       	+'<img style="position:absolute;" class="round-image" src='+episode_image+'>'
		                                       	+'<div class="round-hover-play-button">'
		                                       		+'<svg style="position:absolute; width: 45px; height: 28px; margin-top: 10px;" fill="none" xmlns="http://www.w3.org/2000/svg" class="titleCard-playSVG">'+'<path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">'+'</path>'+'</svg>'
		                                       	+'</div>'
		                                   	+'</a>'
		                                       +'<div class="titleCardList">'
		                                           +'<span class="round-title">'
		                                               +episode_title
		                                           +'</span>'
		                                           +'<span class="round-running-time">'
		                                               +play_time
		                                           +'</span>'
		                                           +'<p class="round-summary">'
		    										+episode_summary
		                                           +'</p>'
		                                       +'</div>'
		                                   +'</div>'
		                               +'</div>';
		                        
		    					
		    					$(".drama-round-box").prepend(str);
		    					
		    					$.ajax({
		    						type: 'get',
		    						url: 'Controller?command=gradeServletAction',
		    						data: {"movie_drama_id" : movieDramaId},
		    						datatype: 'json',
		    						error: function(r,s,e) {
		    							alert("?????? ??????!");
		    						},
		    						success: function(data) {
		    								var grade = data.grade;
		    								var participation = data.participation;
		    								
		    								$(".notice-board").find(".star-grade").text(grade+"???");
		    								$(".notice-board").find(".participation").text(participation+"??? ??????");
		    						}
		    					});
		    				}
		    			}
		    		});
				}
		});
    });
    
    $(".movie-rank").click(function (){
    	var movieDramaId = $(this).find(".boxart-image").attr("movieDramaId");
    	$(".list-box option:eq(0)").prop("selected", true);
    	$(".notice-board").attr('movie_drama_id', movieDramaId);
    	$(".comment-all-box").empty();
    	$('html').scrollTop(0);
        $('.movie-detail').fadeIn(100);
        $('#background-btm').fadeIn(100); 
        
        $(".movie-detail-information-text").children().find('b').text('');
		$(".movie-explanation > .year").text('');
		$(".movie-explanation > .age-image > img").attr('src',''); 
		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text('');
		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text('');
		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text('');
		$(".movie-detail-personnel1:first-child > .personnel1").text('');
		$(".movie-detail-personnel1:last-child > .personnel1").text('');
		$(".movie-explanation > .movie-contents").text('');
		$(".detail-information-container > .detail-information-main-image").attr('src','');
		$(".detail-information-overlay-image > img").attr('src','');
		$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', ''); 
		$.ajax({
			type: 'get',
			url: 'YGServlet',
			data: { "movie_drama_id" : movieDramaId },    
			datatype: "json",
			success: function(data){
				
				var title = data.title;
				var release_day = data.release_day;
				var age = data.age;
				var director = data.director;
				var actor = data.actor;
				var genre = data.genre;
				var summary = data.summary;
				var priview_image = data.priview_image;
				var title_image = data.title_image;
				var first_video = data.first_video;
				var string_age = data.string_age;
				var priview = data.priview;
				$(".movie-detail-information-text").children().find('b').text(title);
				$(".movie-explanation > .year").text(release_day);
				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
				$(".movie-explanation > .movie-contents").text(summary);
				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
				$(".detail-information-overlay-image > img").attr('src',title_image);
				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
				$(".movie-detail").children(".notice-board").children().find("h2").text(title);
				$(".movie-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
				
				$.ajax({
					type: 'get',
					url: 'Controller?command=gradeServletAction',
					data: {"movie_drama_id" : movieDramaId},
					datatype: 'json',
					error: function(r,s,e) {
						alert("?????? ??????!");
					},
					success: function(data) {
							var grade = data.grade;
							var participation = data.participation;
							
							$(".notice-board").find(".star-grade").text(grade+"???");
							$(".notice-board").find(".participation").text(participation+"??? ??????");
					}
				});
			},
			error: function(r,s,e){
				alert("??????!");
			}
		});
    });
    
    $(document).on("click",".area_button_upvote",function (){
    	var commentId = $(this).parent().parent().parent().attr("commentId");
    	var memberId = "<%=profileID%>"
    	var movieDramaId = $(".notice-board").attr('movie_drama_id');
    	
    	$.ajax({
    		type:'get',
    		url:'LikeServlet',
    		data:{"commentId": commentId , "member_id": memberId},
    		datatype:"json",
    		success: function(data) {
    			$(".comment-box").each(function(index, item){
    				/* console.log($(item).attr("commentId"));  */
    				if($(item).attr("commentId") == commentId) {
    					if(data.like == "1") {
	    					/* alert("?????????!!"); */
	    					alert("????????? ????????????.");
	    					var likeUp = $(item).find(".fa-thumbs-up");
	    					/* console.log(likeUp.html()); */ 
	    					likeUp = parseInt(likeUp.html()) + 1;
	    					/* alert(likeUp);  */
	    					$(item).find(".fa-thumbs-up").text(likeUp);
    					}else if(data.like=="-1"){
   	    					/* alert("?????????!!"); */
   	    					alert("????????? ??????.");
   	    					var likeDown = $(item).find(".fa-thumbs-up");
   	    					/* console.log(likeUp.html()); */ 
   	    					likeDown = parseInt(likeDown.html()) - 1;
   	    					/* alert(likeUp);  */
   	    					$(item).find(".fa-thumbs-up").text(likeDown);
    					}
    				}
    			});
    		},
    	});
    });  
    
    $(document).on("click",".area_button_downvote",function (){
    	var commentId = $(this).parent().parent().parent().attr("commentId");
    	var memberId = "<%=profileID %>"
    	/* alert(commentId); */ 
    	$.ajax({
    		type:'get',
    		url:'UnLikeServlet',
    		data:{"commentId": commentId , "member_id": memberId},
    		datatype:"json",
    		success: function(data) {
    			$(".comment-box").each(function(index, item){
    				/* console.log($(item).attr("commentId"));  */
    				if($(item).attr("commentId") == commentId) {
    					if(data.unlike == "1") {
	    					/* alert("?????????!!"); */
	    					/* alert("????????? ????????????."); */
	    					var unLikeUp = $(item).find(".fa-thumbs-down");
	    					/* console.log(likeUp.html()); */ 
	    					unLikeUp = parseInt(unLikeUp.html()) + 1;
	    					/* alert(likeUp);  */
	    					$(item).find(".fa-thumbs-down").text(unLikeUp);
    					}else if(data.unlike == "-1"){
   	    					/* alert("?????????!!"); */
   	    					/* alert("????????? ??????."); */
   	    					var unLikeDown = $(item).find(".fa-thumbs-down");
   	    					/* console.log(likeUp.html()); */ 
   	    					unLikeDown = parseInt(unLikeDown.html()) - 1;
   	    					/* alert(likeUp);  */
   	    					$(item).find(".fa-thumbs-down").text(unLikeDown);
    					}
    				}
    			});
    		},
    	});
    }); 
    
    //???????????????
    var pageNum = 1;
    var g_b;
    function request_one_page() {
    	if(pageNum == 1) {
 		   $(".movie-scroll").empty();
 		   $(".drama-scroll").empty();
     	}   
    	
    	$.ajax({
    		type: 'get',
    		url: 'Controller?command=movieScrollServletAction',
    		data:{"page":pageNum},
    		datatype: "json",
    		error:function(r,s,e) {
    			alert("??????!");
    		},
    		success: function(d) {
    			g_b = d;
    			for(var i=0; i<=8; i++) {
    				console.log(i);
    				var movie_drama_id = d[i].movie_drama_id;
    				var poster_image = d[i].poster_image;
    				var str = 
                    	'<div class="normal-image1" moviedramaid='+movie_drama_id+'>'
    					+'<img class="gubun-image" gubun="drama" src='+poster_image+'>'
    					+'</div>';
                	$(".movie-scroll").append(str);
    			}
    			pageNum += 1;
    			
    			$.ajax({
    	    		type: 'get',
    	    		url: 'Controller?command=dramaScrollServletAction',
    	    		data:{"page":pageNum},
    	    		datatype: "json",
    	    		error:function(r,s,e) {
    	    			alert("??????!");
    	    		},
    	    		success: function(d) {
    	    			g_b = d;
    	    			for(var i=0; i<=8; i++) {
    	    				/* console.log(i); */
    	    				var movie_drama_id = d[i].movie_drama_id;
    	    				var poster_image = d[i].poster_image;
    	    				var str = 
    	                    	'<div class="normal-image1" moviedramaid='+movie_drama_id+'>'
    	    					+'<img class="gubun-image" gubun="drama" src='+poster_image+'>'
    	    					+'</div>';
    	                	$(".drama-scroll").append(str);
    	    			}
    	    			pageNum += 1;
    	    			
    	    		}
    	    	});
    		}
    	});
    }
    $(function (){
    	$(window).scroll(function (){
    		if($(window).scrollTop() == $(document).height()-$(window).height()) {
    			request_one_page();
    		}
    	});
    });
    request_one_page(); 
    
    $(".normal-image").click(function (){
    	var movieDramaId = $(this).attr("movieDramaId");
    	alert(movieDramaId);
    	$(".list-box option:eq(0)").prop("selected", true);
    	$(".comment-all-box").empty();
    	$(".notice-board").attr('movie_drama_id', movieDramaId); 
    	
    	if(movieDramaId >= 158 && movieDramaId <= 402) {
    		$('html').scrollTop(0);
            $('.movie-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $(".movie-detail-information-text").children().find('b').text('');
    		$(".movie-explanation > .year").text('');
    		$(".movie-explanation > .age-image > img").attr('src',''); 
    		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text('');
			$(".movie-detail-personnel1:first-child > .personnel1").text('');
    		$(".movie-detail-personnel1:last-child > .personnel1").text('');
    		$(".movie-explanation > .movie-contents").text('');
    		$(".detail-information-container > .detail-information-main-image").attr('src','');
    		$(".detail-information-overlay-image > img").attr('src','');
    		$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', ''); 
    		$.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			success: function(data){
    				
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".movie-detail").children(".notice-board").children().find("h2").text(title);
    				$(".movie-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    				
    				$.ajax({
    					type: 'get',
    					url: 'Controller?command=gradeServletAction',
    					data: {"movie_drama_id" : movieDramaId},
    					datatype: 'json',
    					error: function(r,s,e) {
    						alert("?????? ??????!");
    					},
    					success: function(data) {
    							var grade = data.grade;
    							var participation = data.participation;
    							
    							$(".notice-board").find(".star-grade").text(grade+"???");
    							$(".notice-board").find(".participation").text(participation+"??? ??????");
    					}
    				});
    			},
    			error: function(r,s,e){
    				alert("??????!");
    			}
    		});
    	} else {
    		$('html').scrollTop(0);
            $('.drama-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $(".movie-detail-information-text").children().find('b').text('');
    		$(".movie-explanation > .year").text('');
    		$(".movie-explanation > .age-image > img").attr('src',''); 
    		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text('');
			$(".movie-detail-personnel1:first-child > .personnel1").text('');
    		$(".movie-detail-personnel1:last-child > .personnel1").text('');
    		$(".movie-explanation > .movie-contents").text('');
    		$(".detail-information-container > .detail-information-main-image").attr('src','');
    		$(".detail-information-overlay-image > img").attr('src','');
    		$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', ''); 
    		$.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			success: function(data){
    				
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".drama-detail").children(".notice-board").children().find("h2").text(title);
    				$(".drama-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    				
    				$(".drama-round-box").empty();
    				$.ajax({
		    			type: 'get',
		    			url: 'Controller?command=dramaRoundBoxServletAction',
		    			data: { "movie_drama_id" : movieDramaId },    
		    			datatype: "json",
		    			error: function(r,s,e){
		    				alert("????????????!!");
		    			},
		    			success: function(data){
		    				global_yg = data;			
		    				for(var i=0; i<=data.length-1; i++) {
			    				console.log(i);
		    					var movie_drama_id = data[i].movie_drama_id;
		    					var episode_round = data[i].episode_round;
		    					var episode_image = data[i].episode_image;
		    					var episode_title = data[i].episode_title;
		    					var episode_summary = data[i].episode_summary;
		    					var full_video = data[i].full_video;
		    					var play_time = data[i].play_time;
		    					var str =
		    						'<div class="round-bundle" moviedramaid='+ movie_drama_id +'>'
		                                   +'<div style="height:75px; margin-top: 26px;">'
		                                       +'<div class="drama-round">'
		                                           +episode_round
		                                       +'</div>'
		                                   +'</div>'
		                                   +'<div>'
		                                   +'<a href='+ full_video +'>'
		                                       	+'<img style="position:absolute;" class="round-image" src='+episode_image+'>'
		                                       	+'<div class="round-hover-play-button">'
		                                       		+'<svg style="position:absolute; width: 45px; height: 28px; margin-top: 10px;" fill="none" xmlns="http://www.w3.org/2000/svg" class="titleCard-playSVG">'+'<path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">'+'</path>'+'</svg>'
		                                       	+'</div>'
		                                   	+'</a>'
		                                       +'<div class="titleCardList">'
		                                           +'<span class="round-title">'
		                                               +episode_title
		                                           +'</span>'
		                                           +'<span class="round-running-time">'
		                                               +play_time
		                                           +'</span>'
		                                           +'<p class="round-summary">'
		    										+episode_summary
		                                           +'</p>'
		                                       +'</div>'
		                                   +'</div>'
		                               +'</div>';
		    					$(".drama-round-box").prepend(str);
		    				}
		    				$.ajax({
		    					type: 'get',
		    					url: 'Controller?command=gradeServletAction',
		    					data: {"movie_drama_id" : movieDramaId},
		    					datatype: 'json',
		    					error: function(r,s,e) {
		    						alert("?????? ??????!");
		    					},
		    					success: function(data) {
		    							var grade = data.grade;
		    							var participation = data.participation;
		    							
		    							$(".notice-board").find(".star-grade").text(grade+"???");
		    							$(".notice-board").find(".participation").text(participation+"??? ??????");
		    					}
		    				});
		    			}
		    		});
    			},
    			error: function(r,s,e){
    				alert("??????!");
    			}
    		});
    	}
    });
    
    $(document).on("click",".normal-image1",function (){
    	var movieDramaId = $(this).attr("movieDramaId");
    	var gubun = $(this).children().attr("gubun");
    	$(".list-box option:eq(0)").prop("selected", true);
    	$(".comment-all-box").empty();
    	$(".notice-board").attr('movie_drama_id', movieDramaId); 
		
    	if(gubun == "movie") {
    		$('html').scrollTop(0);
            $('.movie-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $(".movie-detail-information-text").children().find('b').text('');
    		$(".movie-explanation > .year").text('');
    		$(".movie-explanation > .age-image > img").attr('src',''); 
    		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text('');
			$(".movie-detail-personnel1:first-child > .personnel1").text('');
    		$(".movie-detail-personnel1:last-child > .personnel1").text('');
    		$(".movie-explanation > .movie-contents").text('');
    		$(".detail-information-container > .detail-information-main-image").attr('src','');
    		$(".detail-information-overlay-image > img").attr('src','');
    		$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', ''); 
    		$.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			success: function(data){
    				
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".movie-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".movie-detail").children(".notice-board").children().find("h2").text(title);
    				$(".movie-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    			
    				$.ajax({
    					type: 'get',
    					url: 'Controller?command=gradeServletAction',
    					data: {"movie_drama_id" : movieDramaId},
    					datatype: 'json',
    					error: function(r,s,e) {
    						alert("?????? ??????!");
    					},
    					success: function(data) {
    							var grade = data.grade;
    							var participation = data.participation;
    							
    							$(".notice-board").find(".star-grade").text(grade+"???");
    							$(".notice-board").find(".participation").text(participation+"??? ??????");
    					}
    				});
    			},
    			error: function(r,s,e){
    				alert("??????!");
    			}
    		});
    	}else {
    		$('html').scrollTop(0);
            $('.drama-detail').fadeIn(100);
            $('#background-btm').fadeIn(100); 
            
            $(".movie-detail-information-text").children().find('b').text('');
    		$(".movie-explanation > .year").text('');
    		$(".movie-explanation > .age-image > img").attr('src',''); 
    		$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text('');
			$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text('');
			$(".movie-detail-personnel1:first-child > .personnel1").text('');
    		$(".movie-detail-personnel1:last-child > .personnel1").text('');
    		$(".movie-explanation > .movie-contents").text('');
    		$(".detail-information-container > .detail-information-main-image").attr('src','');
    		$(".detail-information-overlay-image > img").attr('src','');
    		$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', ''); 
    		$.ajax({
    			type: 'get',
    			url: 'YGServlet',
    			data: { "movie_drama_id" : movieDramaId },    
    			datatype: "json",
    			success: function(data){
    				
    				var title = data.title;
    				var release_day = data.release_day;
    				var age = data.age;
    				var director = data.director;
    				var actor = data.actor;
    				var genre = data.genre;
    				var summary = data.summary;
    				var priview_image = data.priview_image;
    				var title_image = data.title_image;
    				var first_video = data.first_video;
    				var string_age = data.string_age;
    				var priview = data.priview;
    				$(".movie-detail-information-text").children().find('b').text(title);
    				$(".movie-explanation > .year").text(release_day);
    				$(".movie-explanation > .age-image > img").attr('src','./images/'+ age +'.jpeg');
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".trailer-video").find("img").attr('src',priview_image);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(0).find(".personnel").text(director);				
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(1).find(".personnel").text(actor);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(2).find(".personnel").text(genre);
    				$(".drama-detail").children(".detail-information-overlay").children(".movie-explanation-container").children(".movie-detail-information-text").children("div").eq(3).find(".personnel").text(age + "" + string_age);
    				$(".movie-detail-personnel1:first-child > .personnel1").text(actor);
    				$(".movie-detail-personnel1:last-child > .personnel1").text(genre);
    				$(".movie-explanation > .movie-contents").text(summary);
    				$(".detail-information-container > .detail-information-main-image").attr('src',priview_image);
    				$(".detail-information-overlay-image > img").attr('src',title_image);
    				$(".detail-information-overlay-buttoms > a.overlay-play-button").attr('href', first_video);
    				$(".drama-detail").children(".notice-board").children().find("h2").text(title);
    				$(".drama-detail").children(".notice-board").children(".sub-title").find(".video-year").text(release_day);
    				
    				$(".drama-round-box").empty();
    				$.ajax({
		    			type: 'get',
		    			url: 'Controller?command=dramaRoundBoxServletAction',
		    			data: { "movie_drama_id" : movieDramaId },    
		    			datatype: "json",
		    			error: function(r,s,e){
		    				alert("????????????!!");
		    			},
		    			success: function(data){
		    				global_yg = data;			
		    				for(var i=0; i<=data.length-1; i++) {
			    				console.log(i);
		    					var movie_drama_id = data[i].movie_drama_id;
		    					var episode_round = data[i].episode_round;
		    					var episode_image = data[i].episode_image;
		    					var episode_title = data[i].episode_title;
		    					var episode_summary = data[i].episode_summary;
		    					var full_video = data[i].full_video;
		    					var play_time = data[i].play_time;
		    					var str =
		    						'<div class="round-bundle" moviedramaid='+ movie_drama_id +'>'
		                                   +'<div style="height:75px; margin-top: 26px;">'
		                                       +'<div class="drama-round">'
		                                           +episode_round
		                                       +'</div>'
		                                   +'</div>'
		                                   +'<div>'
		                                   +'<a href='+ full_video +'>'
		                                       	+'<img style="position:absolute;" class="round-image" src='+episode_image+'>'
		                                       	+'<div class="round-hover-play-button">'
		                                       		+'<svg style="position:absolute; width: 45px; height: 28px; margin-top: 10px;" fill="none" xmlns="http://www.w3.org/2000/svg" class="titleCard-playSVG">'+'<path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">'+'</path>'+'</svg>'
		                                       	+'</div>'
		                                   	+'</a>'
		                                       +'<div class="titleCardList">'
		                                           +'<span class="round-title">'
		                                               +episode_title
		                                           +'</span>'
		                                           +'<span class="round-running-time">'
		                                               +play_time
		                                           +'</span>'
		                                           +'<p class="round-summary">'
		    										+episode_summary
		                                           +'</p>'
		                                       +'</div>'
		                                   +'</div>'
		                               +'</div>';
		    					$(".drama-round-box").prepend(str);
		    				}
		    				$.ajax({
		    					type: 'get',
		    					url: 'Controller?command=gradeServletAction',
		    					data: {"movie_drama_id" : movieDramaId},
		    					datatype: 'json',
		    					error: function(r,s,e) {
		    						alert("?????? ??????!");
		    					},
		    					success: function(data) {
		    							var grade = data.grade;
		    							var participation = data.participation;
		    							
		    							$(".notice-board").find(".star-grade").text(grade+"???");
		    							$(".notice-board").find(".participation").text(participation+"??? ??????");
		    					}
		    				});
		    			}
		    		});
    			},
    			error: function(r,s,e){
    				alert("??????!");
    			}
    		});
    	}
    });
    $(".list-box").on("change",function (){
    	var movieDramaId = $(".notice-board").attr('movie_drama_id');
		/* alert(this.value); */
		if(this.value == "?????????") {
			/* alert("?????????!"); */ 
			$(".comment-all-box").scrollTop(0);
			$(".comment-all-box").empty();
			$.ajax({
				type: 'get',
				url: 'Controller?command=GradeBoardRecentServletAction',
				data: { "movie_drama_id" : movieDramaId },    
				datatype: "json",
				success: function(data) {
					for(var i=0; i<=data.length-1; i++) {
						console.log(i);
						var user_grade = data[i].user_grade;
						var comment_id = data[i].comment_id;
						var profile_id = data[i].profile_id;
						var user_comment = data[i].user_comment;
						var comment_date = data[i].comment_date;
						var like_hitcount = data[i].like_hitcount;
						var unlike_hitcount = data[i].unlike_hitcount;
						
						var str =
							'<div class="comment-box" commentid='+comment_id+'>'
                                +'<div>'
                                    +'<form name="myform" id="myform3" method="post" action="./save">'
                                        +'<fieldset id="comment-grade">'
                                            +'<label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">'
                                            +'<label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">'
                                            +'<label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">'
                                            +'<label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">'
                                            +'<label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">'
                                        +'</fieldset>'
                                    +'</form>'
                                    +'<div class="user-grade">'+user_grade+'???</div>'
                                +'</div>'
                               +'<div>'
                                    +'<div class="user-comment">'+user_comment+'</div>'
                                +'</div>'
                                +'<div style="margin-bottom: 10px;">'
                                    +'<div class="user-id">'+profile_id+'</div>'
                                    +'<div class="comment-day">'+comment_date+'</div>'
                                +'</div>'
                                +'<div>'
                                    +'<div class="cm_sympathy_area">'
                                        +'<button type="button" class="area_button_upvote">'
                                           +'<span class="plus-count"><i class="fa fa-thumbs-up" aria-hidden="true">'+like_hitcount+'</i></span>'
                                        +'</button>'
                                        +'<button type="button" class="area_button_downvote">'
                                            +'<span class="mines-count"><i class="fa fa-thumbs-down" aria-hidden="true">'+unlike_hitcount+'</i></span>'
                                        +'</button>'
                                    +'</div>'
                                +'</div>'
                            +'</div>';
                            
                    	$(".comment-all-box").prepend(str);
					}
				},
				error:function(r,s,e) {
					alert("??????????????? ??????!");
				}
			});
		} else if(this.value == "?????????") {
			/* alert("?????????!"); */
			$(".comment-all-box").scrollTop(0);
			$(".comment-all-box").empty();
			$.ajax({
				type: 'get',
				url: 'Controller?command=userCommentDataSympathyServletAction',
				data: { "movie_drama_id" : movieDramaId },    
				datatype: "json",
				success: function(data) {
					for(var i=0; i<=data.length-1; i++) {
						console.log(i);
						var user_grade = data[i].user_grade;
						var comment_id = data[i].comment_id;
						var profile_id = data[i].profile_id;
						var user_comment = data[i].user_comment;
						var comment_date = data[i].comment_date;
						var like_hitcount = data[i].like_hitcount;
						var unlike_hitcount = data[i].unlike_hitcount;
						
						var str =
							'<div class="comment-box" commentid='+comment_id+'>'
                                +'<div>'
                                    +'<form name="myform" id="myform3" method="post" action="./save">'
                                        +'<fieldset id="comment-grade">'
                                            +'<label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">'
                                            +'<label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">'
                                            +'<label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">'
                                            +'<label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">'
                                            +'<label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">'
                                        +'</fieldset>'
                                    +'</form>'
                                    +'<div class="user-grade">'+user_grade+'???</div>'
                                +'</div>'
                               +'<div>'
                                    +'<div class="user-comment">'+user_comment+'</div>'
                                +'</div>'
                                +'<div style="margin-bottom: 10px;">'
                                    +'<div class="user-id">'+profile_id+'</div>'
                                    +'<div class="comment-day">'+comment_date+'</div>'
                                +'</div>'
                                +'<div>'
                                    +'<div class="cm_sympathy_area">'
                                        +'<button type="button" class="area_button_upvote">'
                                           +'<span class="plus-count"><i class="fa fa-thumbs-up" aria-hidden="true">'+like_hitcount+'</i></span>'
                                        +'</button>'
                                        +'<button type="button" class="area_button_downvote">'
                                            +'<span class="mines-count"><i class="fa fa-thumbs-down" aria-hidden="true">'+unlike_hitcount+'</i></span>'
                                        +'</button>'
                                    +'</div>'
                                +'</div>'
                            +'</div>';
                            
                    	$(".comment-all-box").prepend(str);
					}
				},
				error:function(r,s,e) {
					alert("??????????????? ??????!");
				}
			});
		} else {
			var memberId = "<%=profileID %>"
			$(".comment-all-box").scrollTop(0);
			$(".comment-all-box").empty();
			$.ajax({
				type: 'get',
				url: 'Controller?command=gradeBoardMyCommentServletAction',
				data: { "movie_drama_id" : movieDramaId , "member_id" : memberId},    
				datatype: "json",
				success: function(data) {
					global_yg = data;
					for(var i=0; i<=data.length-1; i++) {
						console.log(i);
						var user_grade = data[i].user_grade;
						var comment_id = data[i].comment_id;
						var profile_id = data[i].profile_id;
						var user_comment = data[i].user_comment;
						var comment_date = data[i].comment_date;
						var like_hitcount = data[i].like_hitcount;
						var unlike_hitcount = data[i].unlike_hitcount;
						
						var str =
							'<div class="comment-box" commentid='+comment_id+'>'
                                +'<div>'
                                    +'<form name="myform" id="myform3" method="post" action="./save">'
                                        +'<fieldset id="comment-grade">'
                                            +'<label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">'
                                            +'<label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">'
                                            +'<label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">'
                                            +'<label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">'
                                            +'<label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">'
                                        +'</fieldset>'
                                    +'</form>'
                                    +'<div class="user-grade">'+user_grade+'???</div>'
                                    +'<div class="delite-icon" style="display:inline-block; float:right; cursor:pointer;">'
                                    	+'<svg style="outline:none; color: white;" width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon1 Hawkins-Icon-Standard" data-uia="previewModal-closebtn" role="button" aria-label="close" tabindex="0">'
                                    		+'<path fill-rule="evenodd" clip-rule="evenodd" d="M2.29297 3.70706L10.5859 12L2.29297 20.2928L3.70718 21.7071L12.0001 13.4142L20.293 21.7071L21.7072 20.2928L13.4143 12L21.7072 3.70706L20.293 2.29285L12.0001 10.5857L3.70718 2.29285L2.29297 3.70706Z" fill="currentColor">'
                                    	+'</path></svg>'
                                    +'</div>'
                                +'</div>'
                               +'<div>'
                                    +'<div class="user-comment">'+user_comment+'</div>'
                                +'</div>'
                                +'<div style="margin-bottom: 10px;">'
                                    +'<div class="user-id">'+profile_id+'</div>'
                                    +'<div class="comment-day">'+comment_date+'</div>'
                                +'</div>'
                                +'<div>'
                                    +'<div class="cm_sympathy_area">'
                                        +'<button type="button" class="area_button_upvote">'
                                           +'<span class="plus-count"><i class="fa fa-thumbs-up" aria-hidden="true">'+like_hitcount+'</i></span>'
                                        +'</button>'
                                        +'<button type="button" class="area_button_downvote">'
                                            +'<span class="mines-count"><i class="fa fa-thumbs-down" aria-hidden="true">'+unlike_hitcount+'</i></span>'
                                        +'</button>'
                                    +'</div>'
                                +'</div>'
                            +'</div>';
                            
                    	$(".comment-all-box").prepend(str);
					}
				},
				error:function(r,s,e) {
					alert("?????? ??? ??? ??????!");
				}
			});
		}
	});
    
    $(document).on("click",".delite-icon",function (){
    	var commentId = $(this).parents().parents().attr("commentid");
    	var movieDramaId = $(".notice-board").attr('movie_drama_id');
    	var memberId = "<%=profileID%>"
    	
    	$(".comment-all-box").scrollTop(0);
    	
    	$.ajax({
			type: 'get',
			url: 'DeliteServlet',
			data: {"comment_id" : commentId, "movie_drama_id" : movieDramaId, "member_id" : memberId},    
			datatype: "json",
			success: function(data) {
				$(".comment-all-box").empty();
				for(var i=0; i<=data.length-1; i++) {
				var user_grade = data[i].user_grade;
				var comment_id = data[i].comment_id;
				var profile_id = data[i].profile_id;
				var user_comment = data[i].user_comment;
				var comment_date = data[i].comment_date;
				var like_hitcount = data[i].like_hitcount;
				var unlike_hitcount = data[i].unlike_hitcount;
				
				var str =
					'<div class="comment-box" commentid='+comment_id+'>'
                    +'<div>'
                        +'<form name="myform" id="myform3" method="post" action="./save">'
                            +'<fieldset id="comment-grade">'
                                +'<label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">'
                                +'<label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">'
                                +'<label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">'
                                +'<label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">'
                                +'<label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">'
                            +'</fieldset>'
                        +'</form>'
                        +'<div class="user-grade">'+user_grade+'???</div>'
                        +'<div class="delite-icon" style="display:inline-block; float:right; cursor:pointer;">'
                        	+'<svg style="outline:none; color: white;" width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon1 Hawkins-Icon-Standard" data-uia="previewModal-closebtn" role="button" aria-label="close" tabindex="0">'
                        		+'<path fill-rule="evenodd" clip-rule="evenodd" d="M2.29297 3.70706L10.5859 12L2.29297 20.2928L3.70718 21.7071L12.0001 13.4142L20.293 21.7071L21.7072 20.2928L13.4143 12L21.7072 3.70706L20.293 2.29285L12.0001 10.5857L3.70718 2.29285L2.29297 3.70706Z" fill="currentColor">'
                        	+'</path></svg>'
                        +'</div>'
                    +'</div>'
                   +'<div>'
                        +'<div class="user-comment">'+user_comment+'</div>'
                    +'</div>'
                    +'<div style="margin-bottom: 10px;">'
                        +'<div class="user-id">'+profile_id+'</div>'
                        +'<div class="comment-day">'+comment_date+'</div>'
                    +'</div>'
                    +'<div>'
                        +'<div class="cm_sympathy_area">'
                            +'<button type="button" class="area_button_upvote">'
                               +'<span class="plus-count"><i class="fa fa-thumbs-up" aria-hidden="true">'+like_hitcount+'</i></span>'
                            +'</button>'
                            +'<button type="button" class="area_button_downvote">'
                                +'<span class="mines-count"><i class="fa fa-thumbs-down" aria-hidden="true">'+unlike_hitcount+'</i></span>'
                            +'</button>'
                        +'</div>'
                    +'</div>'
                +'</div>';
                    
            	$(".comment-all-box").prepend(str);
				}
			},
			error:function(r,s,e) {
				alert("?????? ??? ??? ?????? ??????!");
			}
		});
    	alert("?????????????????????."); 
    });
    
    
    $("#new-content-button").click(function (){
    	/* int email = (int)(session.getAttribute("member_id")); */
    	
    	alert("????????? ?????????.");
    });
});
</script>
<%
	
%>
<style>
body,
html {
 width: 100vw;
 height: 100vh;
 margin: 0;
}
a {
text-decoration: none;
}
.home {
 /*position: relative;*/
 /* overlay??? home(??????) ???????????? ???????????????. relative??? ????????? body????????? ????????????*/
 position: relative;
}
.area_button_upvote {
width: 60px;
height: 30px;
border-radius: 10px;
}
.area_button_downvote {
width: 60px;
height: 30px;
border-radius: 10px;
}

img {
 display: block;
 cursor: pointer;
 /* vertical-align: bottom; */
}

.main-img {
 width: 1777px;
 height: 880px;
}

.main-img:before {
 bottom: 0;
 width: 30%;
}

.overlay {
 position: absolute;
 /* position:absolute??? overlay??? video ?????? ?????? ??? ?????? ?????? */
 top: 0;
 left: 0;
 width: 1777px;
 background-image: linear-gradient(to bottom,rgba(20,20,20,0) 0,rgba(20,20,20,.15) 60%,rgba(20,20,20,.35) 67%,rgba(20,20,20,.58) 80%,#141414 87%,#141414 100%),linear-gradient(77deg,rgba(0,0,0,.6) 0,rgba(0,0,0,0) 38%);
}

#header {
 /* display: flex; */
 background-color: transparent;
 width: 1777px;
 /* padding: 20px 50px; */
 height: 68px;
}

#header.header--dark {
 background-color: black;
}

.header-list {
 display: flex;
 padding-top: 16px;
 padding-left: 50px;
}

.logo {
 color: red;
 margin-right: 26px;
 line-height: 36px;
 padding-top: 5px;
}

.logo-image {
 width: 94px;
}

.nav {
 display: flex;
 color: white;
 padding-left: 15px;
 line-height: 35px; /* ??? ?????? ?????? */
}

.nav-item {
 padding: 0 10px;
}

.menu {
 display: flex;
 margin-left: auto;
 margin-right: 75px;
 color: white;
 line-height: 20px;
}

.tab {
 display: flex;
 margin-left: 10px;
 /* background-color: black; */
}

.login-profile-image {
 border-radius: 4px;
}

.profile-menu {
 margin-top: 5px;
 margin-left: 10px;
 display: inline-block;
 cursor: pointer;
 position: absolute;
}

/* .search {
 display: none;
 width: 275px;
 height: 35px;
 border: solid 0.5px white;
 background-color: black;
} */
.searchTab {
 color: white;
 font-size: 1.2em;
 border: none;
 display: inline-block;
 cursor: pointer;
 background: 0 0;
 padding: 0 5px;
 /* transform: rotate(-14deg); */
}

.titls-searchTab {
 color: white;
 font-size: 1.2em;
 border: none;
 display: inline-block;
 cursor: pointer;
 background: 0 0;
 padding: 2px 13px 5px 8px;
 /* transform: rotate(-14deg); */
}

.search-cuver {
 background-color: black;
 padding-top: 10px;
 width: 220px;
 border: none;
 border-right: 0px;
 border-top: 0px;
 boder-left: 0px;
 boder-bottom: 0px;
 outline: none;
 color: white;
 font-size: 16px;
 position: relative;
}

.close {
 color: white;
 /* color: black; */
 display: inline;
 /* position: absolute; */
 font-size: 23px;
 cursor: pointer;
 padding-left: 210px;
}

.notifications-item {
 color: white;
 font-size: 1.2em;
 border: none;
 cursor: pointer;
 background: 0 0;
 padding: 0 20px;
}

.account-menu-item {
 color: white;
 font-size: 1.5em;
 border: none;
 cursor: pointer;
 border: none;
 background: 0 0;
 /* padding: 8px 0 0 20px; */
 padding-left: 2px;
 display: inline-block;
}

.sub-profile-image {
 display: flex;
 border-radius: 3px;
}

.profile-name {
 display: flex;
 cursor: pointer;
 padding-left: 10px;
 font-size: 13px;
}

span.profile-name:hover {
 text-decoration: underline;
 cursor: pointer;
}

.profile-link {
 display: flex;
 padding-top: 15px;
 padding-left: 7px;
}

.sub-menu-link-icon {
 display: flex;
}

.caret {
 position: absolute;
 margin-top: 39px;
 /* margin-right: 60px; */
 /* width: 180px; */
 /* height: 370px; */
 color: white;
 border: none;
 cursor: pointer;
 background-color: black;
 margin-left: 232px;
 display: none;
}

.account-drop-down {
 position: absolute;
}

.ptrack-content {
 padding: 7px 6px 1px 8px;
}
.ptrack-content1 {
 padding: 0 6px 1px 8px;
 background-color: black;
}

.profiles {
 padding: 0;
 display: block;
}

.sub-menu-item-top {
 line-height: 32px;
 padding-top: 17px;
 cursor: pointer;
 display: flex;
}

.sub-menu-item {
 line-height: 32px;
 /* padding: 5px 10px; */
 /* display: block; */
 /* display: inline; */
 padding-top: 10px;
 cursor: default;
 display: flex;
}

.banner {
 color: white;
 top: 0;
 bottom: 35%;
 left: 4%;
 width: 44%;
 z-index: 10;
}

.titleImage {
 padding-top: 210px;
 padding-botton: 25px;
 width: 80%;
 /* height: auto; */
 margin-left:50px;
}

.summary {
 margin-bottom: 0;
 padding: 15px 135px 5px 0;
 margin-left:50px;
 font-size: 1vw;
}

.buttons {
 display: flex;
 margin-right: 5px;
 padding-top: 30px;
 margin-left:50px;
}

.white-button {
 color: black;
 background-color: white;
 padding: 14px 31px;
 border-radius: 4px;
 font-size: 20px;
 text-decoration: none;
 font-weight: bold;
}

a.white-button:hover {
 background-color: white;
 opacity: 0.7;
}

.gray-button {
 color: white;
 background-color: rgba(109, 109, 110, 0.7);
 padding: 14px 31px;
 border-radius: 4px;
 font-size: 20px;
 margin-left: 10px;
 text-decoration: none;
 font-weight: bold;
 margin-top: -13px;
 cursor: pointer;
}

div.gray-button:hover {
 background-color: rgba(109, 109, 110, 0.7);
 opacity: 0.7;
}

.extra {
 margin-top: -10px;
 position: absolute;
 display: flex;
 right: 0;
 width: 120px;
 height: 75px;
}

.replay-button {
 /* display: inline-block; */
 margin-top: 11px;
 color: white;
 border: 1px solid white;
 border-radius: 50%;
 padding: 5px 17px;
 margin-right: 10px;
 background-color: white;
 background-color: rgba(255, 255, 255, 0);
 width: 10%;
 height: 35px;
}

.fa-lg {
 margin-left: -8px;
}

.rating {
 background-color: rgba(51, 51, 51, 0.6);
 border-left: 3px solid white;
 padding-left: 10px;
 width: 100%;
}

.tabbed-primary-navigation {
 margin: 0;
 padding: 0;
 display: flex;
}

.menu-trigger {
 display: flex;
}

li {
 list-style-type: none;
}

.current-active {
 font-size: 14px;
 color: #e5e5e5;
 cursor: pointer;
 -webkit-transition: color .4s;
}

a.current-active:hover {
 color: gray;
 animation-delay: 5s
}

.movie > img {
 width: 341px;
}

@media screen and (min-width: 885px) {
 .navigation-menu {
  display: none;
  padding-top: 10px;
  padding-left: 18px;
 }
}

@media screen and (max-width: 885px) {
 .navigation-tab {
  display: block;
  display: none;
 }
}

.navigation-tab {
 padding-left: 20px;
 padding-top: 10px;
}
.top-movie {
 color: white;
}

.list > img {
 border-radius: 0.2vw;
}

.contents {
 width: 1777px;
 height: 300px;
 padding-top: 70px;
 margin-left: 50px;
}

/*mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm*/


/* .contents-list {
 z-index: 3;
 position: absolute;
} */


/*mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm*/
.svg-icon {
 width: 140px;
 height: 200px;
 cursor: pointer;
}

.boxart-image {
 width: 140px;
 height: 200px;
 cursor: pointer;
}

.hover-priview-container {
 position: absolute;
 z-index: 3;
 margin-top: -25px;
 /* display: none; */
 opacity: 0;
 z-index: 3;
}
.drama-hover-priview-container {
 position: absolute;
 z-index: 2;
 margin-top: -25px;
 /* display: none; */ 
 z-index: 3;
 margin-top: 54px;
 margin-left: 50px;
}

.priview-box {
}

.hover-priview {
 background-color: #181818;
 /* opacity: 0.7; */
 width: 358px;
 height: 198px;
 position: static;
 cursor: pointer;
 border-top-left-radius: 4px;
 border-top-right-radius: 4px;
}

.hover-priview-img {
 border-top-left-radius: 4px;
 border-top-right-radius: 4px;
}

.button-container {
}

.box-information {
 background-color: #181818;
 /* opacity: 0.7; */
 width: 318px;
 height: 60px;
 position: static;
 /* border-bottom-left-radius: 4px;
 border-bottom-right-radius: 4px; */
 padding: 20px 20px 0 20px;
}
.primary-button {
 display: inline-block;
 color: white;
 width: 40px;
 height: 40px;
 border-radius: 50%;
 cursor: pointer;
 margin-right: 4px;
 background-color: white;
}
.primary-button:hover {
 background-color: gray;
}
.ltr {
 display: inline-block;
 color: white;
 width: 40px;
 height: 40px;
 border-radius: 50%;
 border: solid 2px gray;
 margin-right: 173px;
 cursor: pointer;
}
.ltr:hover {
 border: 2px solid white;
}
.buttonControls {
 display: inline-block;
 color: white;
 width: 40px;
 height: 40px;
 border-radius: 50%;
 border: solid 2px gray;
 cursor: pointer;
}
.buttonControls:hover {
 border: 2px solid white;
}
.drama-buttonControls {
 display: inline-block;
 color: white;
 width: 40px;
 height: 40px;
 border-radius: 50%;
 border: solid 2px gray;
 cursor: pointer;
}
.drama-buttonControls:hover {
 border: 2px solid white;
}

.age-contatiner {
}

.age-information {
 background-color: #181818;
 /* opacity: 0.7; */
 width: 318px;
 height: 40px;
 position: static;
 /* border-bottom-left-radius: 4px;
       border-bottom-right-radius: 4px; */
 padding: 10px 20px 10px 20px;
}

.age {
 width: 40px;
 height: 40px;
 display: inline-block;
}

.age > img {
 width: 100%;
 height: 100%;
}

.running-time {
 font-size: 20px;
 color: white;
 padding-left: 10px;
 padding-bottom: 5px;
}

.genre-information {
 background-color: #181818;
 /* opacity: 0.7; */
 width: 318px;
 height: 40px;
 position: static;
 border-bottom-left-radius: 4px;
 border-bottom-right-radius: 4px;
 padding: 10px 20px 10px 20px;
}

.genre {
 color: white;
 font-size: 20px;
}

.main {
 width: 1780px;
 height: 275px;
 background: #141414;
}

.main-contents {
 /* position: absolute;*/
}

.top-drama {
 margin-top: 101px;
 color: white;
 margin-left: 50px;
}

.top-drama-list {
 margin-left : 50px;
}

.main-s {
 width: 1777px;
 height: 265px;
 position: relative;
 background: #141414;
}

.main-viewing-contents {
 position: absolute;
 background: #141414;
 width: 1777px;
}

.viewing-contends {
 margin-top: 65px;
 color: white;
 margin-left:50px;
}

.viewing-list {
 display: flex;
 cursor:pointer;
}

.normal-image {
 padding-right: 10px;
}
#viewing-contents {
/* margin-left:50px; */
}
.normal-image1 {
 padding-right: 10px;
 float: left;
 margin-bottom: 90px;
}

.normal-image > img {
 width: 271px;
 height: 155px;
}
.normal-image1 > img {
width: 265px;
height: 155px;
}

.main-th {
 width: 1777px;
 height: 265px;
 position: relative;
 background: #141414;
}

.main-dib-contents {
 position: absolute;
}

.dib-contents {
 margin-top: 65px;
 color: white;
 margin-left: 50px;
}

.dib-list {
 display: flex;
 margin-left:50px;
 cursor:pointer;
}

.main-fourth {
 width: 1677px;
 height: 265px;
 background-color: black;
 position: relative;
 padding: 0 50px;
}
.main-fifth {
 width: 1777px;
 height: auto;
 position: relative;
 float: left;
 padding: 0 50px 40px 50px;
 position: absolute;
 background: #141414;
}
.main-sixth {
 width: 1777px;
    height: auto;
    position: relative;
    float: left;
    padding: 0 0 40px 0;
    margin-left: 910px;
    background: #141414;
}

.main-all-contents {
 position: absolute;
}

.all-contents {
 margin-top: 65px;
 color: white;
}
 .comment-all-box::-webkit-scrollbar {
    width: 10px;
  }
  .comment-all-box::-webkit-scrollbar-thumb {
    background-color: #2f3542;
    border-radius: 10px;
  }
  .comment-all-box::-webkit-scrollbar-track {
    background-color: grey;
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
  }
 .drama-round-box::-webkit-scrollbar {
    width: 10px;
  }
  .drama-round-box::-webkit-scrollbar-thumb {
    background-color: #2f3542;
    border-radius: 10px;
  }
  .drama-round-box::-webkit-scrollbar-track {
    background-color: grey;
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
  }
.all-list {
 display: flex;
}

.lower {
 width: 1777px;
 height: auto;
 background: #141414;
}

.lower-icon {
 margin: 0 345px;
 padding: 0 55px;
}

.sns-icon {
 padding-left: 12px;
 font-size: 25px;
 display: flex;
 /* margin-bottom: 1em; */
}

.facebook-icon {
 margin-right: 35px;
}

.instagram-icon {
 margin-right: 35px;
}

.twitter-icon {
 margin-right: 35px;
}

.youtube-icon {
 margin-right: 35px;
}

.icons {
 color: white;
}

a.icons:hover {
 color: gray;
}

table {
 font-size: 13px;
}

tr {
}

.lower-table-td {
 padding: 12.5px 180px 12.5px 0;
 /* margin-bottom: 16px;*/
 color: gray;
}

.lower-table {
 padding: 5px 0;
}

a.lower-icon-hover:hover {
 text-decoration: underline;
 cursor: pointer;
}

.lower-hover {
 border: solid 1px gray;
 padding: 8.5px 6.5px;
}

a.lower-hover:hover {
 color: white;
 cursor: pointer;
}

.lower-table-s {
 margin-top: 15px;
 margin-bottom: 22px;
}

.lower-table-s-td {
 color: gray;
}

.lower-text-contain {
 margin-top: 32px;
}

.lower-text {
 color: gray;
 font-size: 11px;
}

.account-container {
 background-color: black;
 width: 160px;
 height: 90px;
 padding: 0 10px 0 10px;
 border-top: solid 1px gray;
 display: flex;
}

.account {
 padding: 0;
 display: block;
 padding-left: 7px;
}

.account-information-top {
 line-height: 32px;
 cursor: pointer;
 display: flex;
}

.account-information {
 line-height: 32px;
 cursor: default;
 display: flex;
}

.logout-container {
 background-color: black;
 width: 160px;
 height: 45px;
 padding: 0 10px 0 10px;
 border-top: solid 1px gray;
 display: flex;
 padding-left: 10px;
}

.logout-tab {
 display: flex;
 cursor: pointer;
 padding-left: 20px;
 padding-top: 14px;
 font-size: 13px;
 cursor: pointer;
}

span.logout-tab:hover {
 text-decoration: underline;
}

.movie-detail {
 display: none;
 z-index: 4;
}
.drama-detail {
 display: none;
 z-index: 4;
}

.detail-information {
 position: absolute;
 z-index: 4;
}

.detail-information-container {
 width: 830px;
 height: 490px;
 padding-left: 50px;
 padding-top: 30px;
}

.detail-information-main-image {
 border-top-right-radius: 5px;
 border-top-left-radius: 5px;
 background: linear-gradient(
  to bottom,
  rgba(0, 0, 0, 0.8) 0,
  rgba(0, 0, 0, 0) 60%,
  rgba(0, 0, 0, 0.8) 100%
 );
}

.detail-information-overlay {
 position: absolute;
 z-index: 4;
 margin-top: 220px;
}

.detail-information-overlay-image {
 width: 347px;
 height: 138px;
 padding: 30px 0 0 100px;
}

.overlay-play-button {
 display: inline-block;
 height: 61px;
}

.play-button-image {
 width: 122px;
 height: 44px;
 padding-left: 100px;
 padding-top: 25px;
}
.play-button-image:hover {
 color: white;
 opacity: 0.7;
}

.overlay-dib-button {
 display: inline-block;
 width: 45px;
 height: 45px;
 border-radius: 50%;
 background-color: rgba(42, 42, 42, 0.6);
 border-color: rgba(255, 255, 255, 0.5);
 color: white;
 cursor: pointer;
 margin-left: 5px;
}
.overlay-dib-button:hover {
 border: 2px solid white;
}

.movie-explanation-container {
 background-color: #181818;
 position: static;
 width: 740px;
 height: 1805px;
 margin-left: 50px;
 margin-top: 53px;
 padding: 0 45px;
 border-bottom-left-radius: 5px;
 border-bottom-right-radius: 5px;
}

.movie-explanation-set-left {
}

.movie-explanation {
 display: inline-block;
 color: white;
 width: 470px;
 float: left;
}

.year {
 display: inline-block;
 margin-right: 10px;
}

.age-image {
 display: inline-block;
 margin-right: 10px;
 margin-top: 17px;
}

.runing-time {
 display: inline-block;
}

.movie-contents {
 margin-top: 23px;
}

.movie-actor-genre {
 display: inline-block;
 color: white;
 margin-left: 33px;
 margin-top: 15px;
}

.movie-genre {
 margin-top: 20px;
 margin-bottom: 20px;
}

.watched-contents-text {
 margin-top: 100px;
 color: white;
}

.watched-video {
 display: inline-block;
}

.watched-video1 {
 margin-top: 20px;
 display: inline-block;
}

.watched-video-image {
 border-top-left-radius: 5px;
 border-top-right-radius: 5px;
}

.watched-video-box {
 padding: 20px;
 background-color: #2f2f2f;
 display: flex;
 height: 55px;
 width: 196px;
}

.watched-video-age {
 width: 35px;
 height: 35px;
 margin-right: 10px;
 margin-top: 7px;
}

.watched-video-dib {
 height: 50px;
 margin-left: 62px;
}

.watched-video-explanation-box {
 height: 160px;
 width: 196px;
 background-color: #2f2f2f;
 padding: 0 20px 0 20px;
 border-bottom-left-radius: 5px;
 border-bottom-right-radius: 5px;
}

.watched-video-explanation {
 color: white;
}

.trailer-text {
 color: white;
 margin-top: 60px;
}

.trailer-video {
 display: inline-block;
 height: 193px;
 cursor: pointer;
}
.trailer-video:hover > .titleCard {
 display: block;
}

.priview-image {
width:341px;
height:192px;
}
.titleCard {
 width: 70px;
 height: 70px;
 background-color: black;
 position: absolute;
 background-color: rgba(0, 0, 0, 0.6);
 margin-top: -130px;
 margin-left: 136px;
 border-radius: 50%;
 border: solid 1px white;
 display: none;
}
.titleCard-playSVG {
 color: white;
 margin-top: 10px;
 margin-left: 12px;
}

.trailer-video2 {
 width: 340px;
 height: 193px;
 display: inline-block;
 margin-left: 54px;
 cursor: pointer;
}
.trailer-video2:hover > .titleCard {
 display: block;
}

.trailer-text1 {
 color: white;
}

.movie-detail-information-text {
 margin-top: 50px;
 color: white;
}

.movie-detail-personnel {
 color: #777;
 font-size: 14px;
 margin-bottom: 10px;
}

.personnel {
 color: white;
 font-size: 14px;
}

.movie-detail-personnel1 {
 color: #777;
 margin-bottom: 10px;
 width:235px;
}

.personnel1 {
 color: white;
}

.notice-board {
 width: 810px;
 height: 2264px;
 background-color: black;
 position: absolute;
 float: right;
 margin-left: 897px;
 z-index: 4;
 margin-top: 30px;
 border-radius: 5px;
 padding: 10px;
 border: solid 1px gray;
}

.notice-board-img {
}

.title-area {
 color: white;
 margin-left: 10px;
 padding-left: 10px;
}

.title-text {
 display: inline-block;
}

.close-icon {
 display: inline-block;
 float: right;
 width: 36px;
 height: 36px;
 margin: 10px 15px 0 0;
 cursor: pointer;
}

.Hawkins-Icon1 {
 padding: 8px 10px 10px 8px;
}

.sub-title {
 color: white;
 margin-left: 10px;
}

.video-type {
 border-right: solid 1px white;
 padding: 0 10px 0 10px;
}

.video-title {
 border-right: solid 1px white;
 padding: 0 10px 0 10px;
}

.video-year {
 padding: 0 10px 0 10px;
}

.cm-content-wrap {
 border: solid 1px gray;
 background-color: #121212;
 border-radius: 5px;
 margin-top: 20px;
 width: 810px;
 height: 350px;
}

.grade-text {
 padding: 16px 0 16px 0;
 color: white;
 text-align: center;
 border-bottom: solid 1px gray;
 font-size: 22px;
}

.user-grade-sum-box {
 background-color: #121212;
 width: 383px;
 height: 244px;
 display: inline-block;
 border-radius: 5px;
 border: solid 1px gray;
 float: left;
 margin-left: 15px;
 margin-top: 23px;
}

.age-satisfaction-box {
 float: right;
 background-color: #121212;
 display: inline-block;
 width: 383px;
 height: 244px;
 border-radius: 5px;
 border: solid 1px gray;
 margin-right: 15px;
 margin-top: 23px;
}

#myform fieldset {
 display: inline-block; /* ?????? ?????? ??????????????? ?????? ????????? ????????? ?????????.*/
 border: 0; /* ????????? ????????? ?????? */
}

#myform input[type="radio"] {
 display: none; /* ??????????????? ?????? */
}

#myform label {
 font-size: 3em; /* ????????? ?????? */
 color: transparent; /* ?????? ????????? ?????? ?????? */
 text-shadow: 0 0 0 #f0f0f0; /* ??? ????????? ?????? ?????? */
}

.cm-content-area {
 background-color: #121212;
 border: solid 1px gray;
 border-radius: 5px;
 margin-top: 15px;
 width: 810px;
 height: 1788px;
}

#netizens-grade fieldset {
 display: inline-block; /* ?????? ?????? ??????????????? ?????? ????????? ????????? ?????????.*/
 border: 0; /* ????????? ????????? ?????? */
}

#netizens-grade input[type="radio"] {
 display: none; /* ??????????????? ?????? */
}

#netizens-grade label {
 font-size: 3em; /* ????????? ?????? */
 color: transparent; /* ?????? ????????? ?????? ?????? */
 text-shadow: 0 0 0 #f0f0f0; /* ??? ????????? ?????? ?????? */
}

#netizens-grade label:hover {
 text-shadow: 0 0 0 #a00;
}

#netizens-grade label:hover ~ label {
 text-shadow: 0 0 0 #a00; /* ????????? ?????? ???????????? ???????????? */
}

#netizens-grade fieldset {
 display: inline-block; /* ?????? ?????? ??????????????? ?????? ????????? ????????? ?????????.*/
 direction: rtl; /* ????????? ?????? ?????? */
 border: 0; /* ????????? ????????? ?????? */
}

.cm_form_intro_box {
 padding: 20px 0;
 border-bottom: solid 1px gray;
}

.area_input_box {
 display: inline-block;
}

.this_input_write {
 width: 700px;
 height: 35px;
 margin-left: 15px;
 font-size: 17px;
 outline: none;
}

.this_button_write {
 display: inline-block;
 height: 35px;
 width: 68px;
}

.nav-element {
 -webkit-text-size-adjust: 100%;
 color: #fff;
 -webkit-font-smoothing: antialiased;
 user-select: none;
 cursor: default;
 word-break: keep-all;
 font-family: "Netflix Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
 line-height: 1.4;
 font-size: 14px;
 letter-spacing: 0 !important;
 margin-right: 15px;
 background-color: black;
 width: 275px;
 border: solid 1px white;
}

#searchInput {
 background-color: black;
 width: 225px;
 color: white;
}
.searchIcon {
 display: flex;
 position: absolute;
 margin-left: 220px;
 margin-top: -29px;
}

.list-select-box {
 display: inline-block;
 cursor: pointer;
}

.fa-chevron-down {
 display: inline-block;
 cursor: pointer;
}

.list-box {
 width: auto;
 height: 40px;
 border: solid 1px white;
 border-radius: 5px;
 background-color:black;
 color : white;
 font-size : 15px;
 margin: 15px;
 outline : none;
}

.list-list1 {
 padding: 10px 0;
 text-align: center;
 border-bottom: solid 1px gray;
}

.list-list2 {
 padding: 10px 0;
 text-align: center;
}

.list-list1:hover {
 background-color: gray;
 cursor: pointer;
}

.list-list2:hover {
 background-color: gray;
 cursor: pointer;
}

.comment-all-box {
 overflow-y: scroll;
 overflow-x: hidden;
 height:1403px;
}
.comment-box {
 width: 780px;
 /* height: 200px; */
 height: auto;
 border: solid 1px gray;
 margin: 0 14px 14px 14px;
}

#myform3 {
 display: inline-block;
 height: 45px;
}

#myform3 fieldset {
 display: inline-block; 
 border: 0; 
}

#myform3 input[type="radio"] {
 display: none; 
}

#myform3 label {
 font-size: 3em; 
 color: transparent; 
 text-shadow: 0 0 0 #f0f0f0; 
}

#comment-grade > label {
 font-size: 15px;
}

#comment-grade {
 margin: 10px 0 20px 0;
}

.user-grade {
 color: white;
 font-size: 15px;
 display: inline-block;
}

.user-comment {
 color: white;
 margin-left: 10px;
 height: auto;
 margin-bottom: 10px;
}

.user-id {
 color: white;
 margin-left: 10px;
 display: inline-block;
 border-right: solid 1px gray;
 padding-right: 15px;
}

.comment-day {
 color: white;
 margin-left: 10px;
 display: inline-block;
}

.cm_sympathy_area {
 margin-left: 10px;
 margin-bottom: 20px;
}

.graph-box {
 width: 383px;
 height: 190px;
}
#background-btm {
 background-color: rgba(0, 0, 0, 0.6);
 height: 100%;
 width: 100%;
 position: fixed;
 top: 0;
 left: 0;
 z-index: 4;
}
.swiper-button-prev {
 color: white;
 left: 5px;
}
.swiper-button-next {
 color: white;
 right: 5px;
}
.drama-round-box {
 width: 785px;
 height: 810px;
 border-bottom: 2px solid #404040;
 border-top: 1px solid #404040;
 overflow-y:scroll;
 overflow-x:hidden;
 position:relative;
}
.round-bundle {
 width: 740px;
 height: 104px;
 border-bottom: 1px solid #404040;
 display: flex;
 margin-top: 30px;
}

.drama-round {
 color: #d2d2d2;
 font-size: 1.5em;
 display: inline-block;
 padding: 0 15px;
}
.round-image {
	width: 133px;
	height: 75px;
	border-radius: 4px;
}
.round-image:hover ~ .round-hover-play-button {
    	display:block;
} 
.round-hover-play-button {
width: 45px;
    height: 45px;
    background-color: rgba(30,30,20,.5);
    border: 1px solid white;
    position: absolute;
    border-radius: 50%;
    margin-left: 41px;
    margin-top: 16px;
    display: none;
}

.titleCardList {
 flex: 0 0 70%;
 font-size: 1em;
 width: 550px;
 margin-left: 130px;
}
.round-title {
 color: #fff;
 font-size: 1em;
 font-weight: 700;
 margin-left: 16px;
}
.round-running-time {
 color: #fff;
 font-size: 1em;
 font-weight: 700;
 float: right;
}
.round-summary {
 padding: 0 1em 1em;
 margin: 0;
 color: #d2d2d2;
 padding: 1em 0 0 1em;
}
.swiper-button-next-box {
	width: 42px;
    height: 155px;
    background: rgba(20,20,20,.5);
    position: absolute;
    z-index: 2;
    margin-left: 1686px;
}
.swiper-button-prev-box {
    width: 40px;
    height: 155px;
    background: rgba(20,20,20,.5);
    position: absolute;
    z-index: 2;
    left: -50px;
}

.swiper-button-box {
 display:none;
} 
.contents-list:hover .swiper-button-box {
 display:block;
}
.main:hover .swiper-button-box {
 display:block;
}
.swiper-button-all-box {
 display:none;
} 
.viewing-list:hover .swiper-button-all-box {
 display:block;
}
.dib-list:hover .swiper-button-all-box {
 display:block;
}
</style>
<title>????????????</title>
</head>
<body>
    <div class="window">
    	<div id="background-btm" style="display: none;"></div>
        <div class="home">
		  <div>
            <div class="movie-detail">
                <div class="detail-information">
                    <div class="detail-information-container">
                    
                        <img class="detail-information-main-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABavNZ4hIlIR-4zgMvmXH1TodAyEzYoNNmyVLQoZnKxCrCMbOpCW2BbUdJQI7GD6tpnAFIsxaRusmRA1XV2zAxdZ3VDtK7jQYMgsL.webp?r=f13https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABavNZ4hIlIR-4zgMvmXH1TodAyEzYoNNmyVLQoZnKxCrCMbOpCW2BbUdJQI7GD6tpnAFIsxaRusmRA1XV2zAxdZ3VDtK7jQYMgsL.webp?r=f13" width="100%" height="100%">
                    </div>
                </div>
                <div class="detail-information-overlay">
                    <div class="detail-information-overlay-image">
                        <img src="https://occ-0-4342-993.1.nflxso.net/dnm/api/v6/tx1O544a9T7n8Z_G12qaboulQQE/AAAABT111c9ZNZBrT4W5WerPFx3kI7cEr2Oab0IwpF4MgB4KNiIN2iM-WBN6Iml9gSnayaCbWliUFpnQCLaMv3cjo0wz-RsjssRu1mIoF5KWre3wD8OE2yPVq7Q2bSC97YdGG_ZJZtvaL0wszkH-6h-b1-w2aTRenXHJkPHo0TGLFCQD.webp?r=ddc" width="100%" height="100%">
                    </div>
                    <div class="detail-information-overlay-buttoms">
                        <a class="overlay-play-button" href="https://www.netflix.com/watch/81094067?trackId=255824129&tctx=0%2C0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2Cunknown%2C%2Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782%7C1%2C%2C">
                            <img class="play-button-image" src="./images/playbutton.png">
                        </a>
                        <button class="overlay-dib-button">
                            <i class="fal fa-plus fa-3x"></i>
                        </button>
                    </div>
                    <div class="movie-explanation-container">
                        <div class="movie-explanation-box">
                            <div class="movie-explanation-set-left">
                                <div class="movie-explanation">
                                    <h3 class="year">2021</h3>
                                    <div class="age-image"><img src="./images/12.jpeg" width="30px" height="30px"></div>
                                    <h3 class="runing-time">2?????? 16???</h3>
                                    <div class="movie-contents">
                                        ???????????? ???????????? ????????? ??????. ?????? ??????????????? ??????. 2092???, ?????? ??? ?????? ????????? ???. ????????? ????????? ????????? ????????? ?????? ?????????. ?????? ??????, ????????? ????????? ????????????!
                                    </div>
                                </div>
                            </div>
                            <div class="movie-explanation-set-right">
                                <div class="movie-actor-genre">
                                    <div class="movie-detail-personnel1">?????? : <span class="personnel1">?????????, ?????????, ?????????,</span></div>
                                    <div class="movie-detail-personnel1">?????? : <span class="personnel1">SF ??????, ?????? & ????????????</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="watched-contents-text">
                            <h2>?????? ????????? ?????????</h2>
                        </div>
                        <div class="watched-video">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABZoIjkUHvp_hQ1xjxLkugLNXwzLImgal-Nqcpt1d1dE2ohm_nuR4gwRHqY2EWbcP2fIFCncTf7hxP_BwDswLDb_kalfEljlWc3r8MI1obVpPKVM8-rxj8AjJ1kBfVsTu80NA.jpg?r=13e" width="236px" height="136px" style="margin-right: 11.5px;">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/18Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2020</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">????????? ?????? ????????? ?????????. ?????? ????????? ?????? ??????, ????????? ???????????? ??????????????? ??????. ????????? ???????????? ??????, ????????? ?????? ????????? ??????????????? ????????? ????????? ????????????.</div>
                            </div>
                        </div>
                        <div class="watched-video">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABbNlxVVrWUEzSlxfDPJzg6IMPNpSFHsgAlMzfTxZEmjjGAWuGAedJy-NUi-ukiOJ8M4503aAtL4P3XQRZloyvCICrNQbl1_PJ7yhWv6B7zreK4X9uOyAQVXR4v8bvoOoVxCP.jpg?r=dc6" width="236px" height="136px" style="margin-right: 11.5px;">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/15Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2020</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">??????????????? ??????????????? ????????? ??????. ????????? ???????????? ????????? ??????! ???????????? ?????????, ?????? ????????? ????????????. ?????? ???????????? ?????? ????????? ????????? ????????? ????????? ?????????.</div>
                            </div>
                        </div>
                        <div class="watched-video">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABQLI7Z80VQUTOMItLtllKiWoSyLHns9JszKddSUirC10i8XAsabElcSKGJjBJbwM9QyJHND2XY6xCe7T49_2Z7HgIyvyyoEWwAse9FQbDHMLtR6QbXUxeyfoYzVPX8x0qomQ.jpg?r=7a7" width="236px" height="136px">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/15Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2021</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">????????? ???????????? ?????????????????? ???????????? ????????? ??????. ??????????????? ???????????? ???????????? ????????? ????????? ?????? ????????? ?????? ?????? ??? ????????? ????????? ?????????. ???????????? ?????? ????????? ???????????????.</div>
                            </div>
                        </div>
                        <div class="watched-video1">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABeegt8cWOjo9mmP0Tj-1w_trgjvA972-G3AitlLPIxw7Xgf_e0jB3jK5tmwDHls_0itJGSTiy98Zu6I891DLJ2G6uxjVzujMX7c.webp?r=a59" width="236px" height="136px" style="margin-right: 11.5px;">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/12Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2004</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">????????????????????? ????????? ????????????, ????????? ???????????? ?????? ????????? ???????????? ????????? ?????? ????????? ???????????? ????????? ????????? ???????????? ????????? ????????? ????????????.</div>
                            </div>
                        </div>
                        <div class="watched-video1">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABXBhezlcvw1PUEzqFkSW5CDR2DIJINXIlzG3UFIJy299aFFlWnXvTqbPGsZYI6nkUsHNdo8Lh8Fy7xqDOxhkE4YoTxa7kAw4AHg.webp?r=dac" width="236px" height="136px" style="margin-right: 11.5px;">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/18Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2013</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">???????????? ????????? ?????? ????????? ????????? ??????, ????????? ????????? ????????? ?????? ?????? ??? ???????????????. 2154?????? ???????????? ???????????? ??????????????? ????????? ??????.</div>
                            </div>
                        </div>
                        <div class="watched-video1">
                            <img class="watched-video-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABQalmi3yC_mf1f3s8N1MjYghtn5SDCbFMHF4aDINmMbUn7UYnpt2V8SL0QUI39oFGXZw1ryWCPMMtFJGpE_uDmlrpAksr4qUjB8.webp?r=62b" width="236px" height="136px">
                            <div class="watched-video-box">
                                <img class="watched-video-age" src="./images/15Gray.png">
                                <h3 style="color: white; margin-top: 15px;">2015</h3>
                                <img class="watched-video-dib" src="./images/dibGray.png" style="background-color: #2f2f2f;">
                            </div>
                            <div class="watched-video-explanation-box">
                                <div class="watched-video-explanation">??????????????? ???????????? ????????? ?????? ?????? ????????? ??????. ???????????? ?????? ???????????? ???????????? ???????????? ?????? ????????? ???????????? ????????? ????????? ????????? ????????????.</div>
                            </div>
                        </div>
                        <div class="trailer-text">
                            <h2>????????? ??? ?????? ??????</h2>
                        </div>
                        <div class="trailer-video">
                            <img class="priview-image" style="width:341px; height:192px;" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABU7H-KttkzXtzLu6CpMcKCWjnp31niMLILrPM0hLuGHEwpnWjHqY6uBYUycbCs1B7OCYh4VAmu4NMXcMvMohF9qsZQG0LGXflNpBDBg6CKI9lA4NR4dXkX2S.webp?r=212">
                            <div class="titleCard">
                                <svg style="margin-left: 15px; margin-top: 15px" class="titleCard-playSVG" width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor"></path></svg>
                            </div>
                            <h3 class="trailer-text1">?????????</h3>
                        </div>
                        <!-- <div class="trailer-video2">
                            <img class="priview-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABbXbe0un-PsodD81bw7ln-oVF7kShyKOqWUnyjfLzqyQEtCN9HCHVgnxjO5fQouZItsUIai5r4NBwQ94EcPO2-7YjGGk_ROYBcYbuKXAi9yLouiiStTrPdlX.webp?r=456" style="border-radius: 5px;">
                            <div class="titleCard">
                                <svg style="margin-left: 15px; margin-top: 15px" class="titleCard-playSVG" width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor"></path></svg>
                            </div>
                            <h3 class="trailer-text1">?????????2</h3>
                        </div> -->
                        <div class="movie-detail-information-text">
                            <h2><b>?????????</b> ?????? ??????</h2>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">?????????</span></div>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">?????????, ?????????, ?????????, ?????????, ????????? ????????????, ?????????</span></div>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">?????????, ?????????, ????????????</span></div>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">SF ??????, ?????? & ????????????</span></div>
                            <div class="movie-detail-personnel">?????? ?????? : <span class="personnel">????????????</span></div>
                            <div class="movie-detail-personnel">???????????? : <span class="personnel">12??????????????????</span></div>
                        </div>
                    </div>
                </div>
                <div class="notice-board">
                    <div class="title-area">
                        <div class="title-text"><h2>?????????</h2></div>
                        <div class="close-icon"><svg style="outline:none; color: white;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon1 Hawkins-Icon-Standard" data-uia="previewModal-closebtn" role="button" aria-label="close" tabindex="0"><path fill-rule="evenodd" clip-rule="evenodd" d="M2.29297 3.70706L10.5859 12L2.29297 20.2928L3.70718 21.7071L12.0001 13.4142L20.293 21.7071L21.7072 20.2928L13.4143 12L21.7072 3.70706L20.293 2.29285L12.0001 10.5857L3.70718 2.29285L2.29297 3.70706Z" fill="currentColor"></path></svg></div>
                    </div>
                    <div class="sub-title">
                        <span class="video-type">??????</span>
                        <span class="video-year">2020</span>
                    </div>
                    <div class="cm-content-wrap">
                        <div class="grade-text">
                            ??????
                        </div>
                        <div class="grade-box">
                            <div class="user-grade-sum-box">
                                <h3 style="text-align: center; color: white;">????????? ??????</h3>
                                <div class="star-grade" style="font-size: 3.6rem;margin-top:50px; text-align: center; color: white;"></div>
                                <!-- <form style="text-align: center;" name="myform" id="myform" method="post" action="./save">
                                    <fieldset>
                                        <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">
                                        <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">
                                        <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">
                                        <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">
                                        <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">
                                    </fieldset>
                                </form> -->
                                <div class="participation" style="margin-top:50px; color: white; text-align: center;"></div>
                            </div>
                            <div class="age-satisfaction-box">
                                <h3 style="color: white; text-align: center; border-bottom: solid 1px gray; padding-bottom: 10px;">????????? ?????????</h3>
                                <div class="graph-box">
                                    <div style="width: 363px; height: 175px;">
                                        <canvas id="myChart"></canvas>
                                    </div>
                                    <script type="text/javascript">
                                        var context = document.getElementById('myChart').getContext('2d');
                                        var myChart = new Chart(context,
                                                {
                                                    type : 'bar', // ????????? ??????
                                                    data : { // ????????? ????????? ?????????
                                                        labels : [
                                                        //x ???
                                                        '10???', '20???', '30???', '40???', '50???'],
                                                        datasets : [ { //?????????
                                                            label : '', //?????? ??????
                                                            fill : false, // line ????????? ???, ??? ????????? ???????????? ???????????????
                                                            data : [ 21, 19, 25, 20, 23 //x??? label??? ???????????? ????????? ???
                                                            ],
                                                            backgroundColor : [
                                                            //??????
                                                            'rgba(255, 99, 132, 0.2)',
                                                                    'rgba(54, 162, 235, 0.2)',
                                                                    'rgba(255, 206, 86, 0.2)',
                                                                    'rgba(75, 192, 192, 0.2)',
                                                                    'rgba(255, 159, 64, 0.2)' ],
                                                            borderColor : [
                                                            //????????? ??????
                                                            'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',
                                                                    'rgba(255, 206, 86, 1)',
                                                                    'rgba(75, 192, 192, 1)',
                                                                    'rgba(255, 159, 64, 1)' ],
                                                            borderWidth : 1
                                                        //????????? ??????
                                                        } /* ,
                                                                                {
                                                                                    label: 'test2',
                                                                                    fill: false,
                                                                                    data: [
                                                                                        8, 34, 12, 24
                                                                                    ],
                                                                                    backgroundColor: 'rgb(157, 109, 12)',
                                                                                    borderColor: 'rgb(157, 109, 12)'
                                                                                } */
                                                        ]
                                                    },
                                                    options : {
                                                        scales : {
                                                            yAxes : [ {
                                                                ticks : {
                                                                    beginAtZero : true
                                                                }
                                                            } ]
                                                        }
                                                    }
                                                });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cm-content-area">
                        <div class="netizens-text" style="font-size: 22px; color: white; padding: 20px 0; text-align: center; border-bottom: solid 1px gray;">
                            ????????? / ?????????
                        </div>
                        <div style="font-size: 22px; color: white; padding: 40px 0 20px 0; text-align: center;">????????? ??????????????????.</div>
                        <form style="text-align: center;" name="myform" id="netizens-grade" method="post" action="./save">
                            <fieldset class="starpoint-box">
                                <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1" class="star-radio">
                                <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2" class="star-radio">
                                <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3" class="star-radio">
                                <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4" class="star-radio">
                                <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5" class="star-radio">
                            </fieldset>
                        </form>
                        <div class="cm_form_intro_box"> 
	                            <div class="area_input_box"> 
	                                <input id="user_comment" type="text" class="this_input_write" placeholder="???????????? ??????????????????."> 
	                            </div> 
	                            <button type="submit" class="this_button_write">??????</button> 
                        </div>
                        <div class="list-container">
                            <div class="list-container">
                            <!-- <h3 class="list-select-box" style="color: white; margin-left: 15px;">?????????</h3> -->
                           	<!--<i style="color: white;" class="fa fa-chevron-down"></i>  -->
                           	
                        	<select class="list-box">
                        		<option class="select" selected>??????</option>
                            	<option class="new">?????????</option>
                           	 	<option class="sympathy">?????????</option>
                           	 	<option class="myComment">?????? ????????? ???</option>
                        	</select>
                        </div>
                        </div>
                        
                        <div class="comment-all-box">
                        <%-- <%
                        ArrayList<CommentBoxDto> cDto = (ArrayList<CommentBoxDto>)request.getAttribute("cDto");
                        for(CommentBoxDto commentBox : cDto) {
                        %> 
                            <div class="comment-box" commentId="">
                                <div>
                                    <form name="myform" id="myform3" method="post" action="./save">
                                        <fieldset id="comment-grade">
                                            <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">
                                            <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">
                                            <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">
                                            <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">
                                            <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">
                                        </fieldset>
                                    </form>
                                    <div class="user-grade">0</div>
                                </div>
                                <div>
                                    <div class="user-comment"></div>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <div class="user-id"></div>
                                    <div class="comment-day"></div>
                                </div>
                                <div>
                                    <div class="cm_sympathy_area" >
                                        <button type="button" class="area_button_upvote">
                                            <span class="plus-count"><i class="fa fa-thumbs-up"></i></span>
                                        </button>
                                        <button type="button" class="area_button_downvote">
                                            <span class="mines-count"><i class="fa fa-thumbs-down"></i></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                			<%-- <%
                        	}
                        	%>  --%>
                        </div>
                        <!-- <div style="display:none;">
	                        <div class="comment-box-original">
                                <div>
                                    <form name="myform" id="myform3" method="post" action="./save">
                                        <fieldset id="comment-grade">
                                            <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">
                                            <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">
                                            <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">
                                            <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">
                                            <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">
                                        </fieldset>
                                    </form>
                                    <div class="user-grade">0</div>
                                </div>
                                <div>
                                    <div class="user-comment">???</div>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <div class="user-id">YG</div>
                                    <div class="comment-day">2022-06-17</div>
                                </div>
                                <div>
                                    <div class="cm_sympathy_area">
                                        <button type="button" class="area_button_upvote">
                                            <span class="plus-count"><i class="fas fa-thumbs-up">0</i></span>
                                        </button>
                                        <button type="button" class="area_button_downvote">
                                            <span class="mines-count"><i class="fas fa-thumbs-down">0<</i></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                    	</div> -->
                    </div>    
                </div>
            </div>
            <div class="drama-detail">
                <div class="detail-information">
                    <div class="detail-information-container">
                        <img class="detail-information-main-image" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABdNrCCpzFOFMCgYUi-2mdo-MHIKetZmEyG-wmbN36GLopUiQIkaKtt971hPfSwqHOHAqoyAwUJ0OIZ_Cz-lfkw18I2IDH23PQbp9JGLakLY8yUQlbLx6SPTnwA.webp?r=ccb" width="100%" height="100%">
                    </div>
                </div>
                <div class="detail-information-overlay">
                    <div class="detail-information-overlay-image">
                        <img src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/tx1O544a9T7n8Z_G12qaboulQQE/AAAABWy-j8WQFXYA5UwfDQoM1-2QEe4jfMyE02lNP8z7tOCu3hurT6_vBURObMFdSnOduOoIxiKiepL34xv0rNxU1ic-wsCkY7lo8GNBxhbKqkY.webp?r=88d" width="100%" height="100%">
                    </div>
                    <div class="detail-information-overlay-buttoms">
                        <a class="overlay-play-button" href="https://www.netflix.com/watch/81094067?trackId=255824129&tctx=0%2C0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2Cunknown%2C%2Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782%7C1%2C%2C">
                            <img class="play-button-image" src="./images/playbutton.png">
                        </a>
                        <button class="overlay-dib-button">
                            <i class="fal fa-plus fa-3x"></i>
                        </button>
                    </div>
                    <div class="movie-explanation-container">
                        <div class="movie-explanation-box">
                            <div class="movie-explanation-set-left">
                                <div class="movie-explanation">
                                    <h3 class="year">2022</h3>
                                    <div class="age-image"><img src="./images/15.jpeg" width="30px" height="30px"></div>
                                    <h3 class="runing-time">?????? 1???</h3>
                                    <div class="movie-contents">
                                        IMF ??????????????? ???????????? ?????? ????????? ??? ????????? ?????? ?????????. ????????? ????????? ??????????????? ????????? ?????????. ?????? ?????????, ???????????? ???????????? ?????? ????????? ?????? ?????? ??? ??????.
                                    </div>
                                </div>
                            </div>
                            <div class="movie-explanation-set-right">
                                <div class="movie-actor-genre">
                                    <div class="movie-detail-personnel1">?????? : <span class="personnel1">?????????, ?????????, ?????????,</span></div>
                                    <div class="movie-detail-personnel1">?????? : <span class="personnel1">???????????? ?????????, ?????? ?????????</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="watched-contents-text">
                            <h2>??????</h2>
                        </div>
                        <div class="drama-round-box">
                        <%-- <%						// YGYGYGYG
                        	DramaRoundDao dDao = new DramaRoundDao();
                        	ArrayList<DramaRoundDto> dRDtoList = dDao.dramaRoundBox();
                        	for(DramaRoundDto dRDto : dRDtoList) {  
                        %> --%>
                            <div class="round-bundle" movieDramaId="">
                                <div style="height:75px; margin-top: 26px;">
                                    <div class="drama-round">
                                        <%-- <%=dRDto.getEpisodeRound() %> --%>
                                    </div>
                                </div>
                                <div>
                                	<a href="">
                                    	<img style="position:absolute;" class="round-image" src="">
                                    	<div class="round-hover-play-button">
                                    		<svg style="position:absolute; width: 45px; height: 28px;" fill="none" xmlns="http://www.w3.org/2000/svg" class="titleCard-playSVG"><path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor"></path></svg>
                                    	</div>
                                	</a>
                                    <div class="titleCardList">
                                        <span class="round-title">
                                            <%-- <%=dRDto.getEpisodeTitle() %> --%>
                                        </span>
                                        <span class="round-running-time">
                                            <%-- <%=dRDto.getPlayTime() %> --%>
                                        </span>
                                        <p class="round-summary">
											<%-- <%=dRDto.getEpisodeSummary() %> --%>
                                        </p>
                                    </div>
                                </div>
                            </div>
                                        <%-- <%
                        					}
                                        %> --%>
                        </div>
                        <div class="trailer-text">
                            <h2>????????? ??? ?????? ??????</h2>
                        </div>
                        <div class="trailer-video">
                            <img style="width:341px; height:192px;" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABc4i_kwdJVNWkGpIHtCZ3-edq9sLYoUM2wZWItEpLiTP5qYmd1S2mNMv5p_k27zd38_Tx7S_j-jRNlS25sQQyZ1XM-FWsN5Exm80WxT19GcAFSQJyAdzh7wP.webp?r=e57" style="border-radius: 5px;width:341px;height:192px;">
                            <div class="titleCard">
                                <svg style="margin-left: 15px; margin-top: 15px" class="titleCard-playSVG" width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor"></path></svg>
                            </div>
                            <h3 class="trailer-text1">?????????</h3>
                        </div>
                        <!-- <div class="trailer-video2">
                            <img src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABf_KoJdOgwVtBtCx4RSWQoysFnTlum6NwdiTJFuTU_qtuQ-hNGkbM7pUoa1x45GVcyEVE-TBnAXEAVKKmO_5wkXZIMHrfBB_RDYwFI8krvGOOyw4GJA6sSaY.webp?r=cab" style="border-radius: 5px;">
                            <div class="titleCard">
                                <svg style="margin-left: 15px; margin-top: 15px" class="titleCard-playSVG" width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor"></path></svg>
                            </div>
                            <h3 class="trailer-text1">?????????2</h3>
                        </div> -->
                        <div class="movie-detail-information-text">
                            <h2><b>???????????? ????????????</b> ?????? ??????</h2>
                            <div class="movie-detail-personnel">??????????????? : <span class="personnel">?????????, ?????????</span></div>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">?????????, ?????????, ?????????, ?????????, ?????????</span></div>
                            <div class="movie-detail-personnel">?????? : <span class="personnel">???????????? ?????????, ?????? ?????????, ?????????</span></div>
                            <div class="movie-detail-personnel">???????????? : <span class="personnel">15??????????????????</span></div>
                        </div>
                    </div>
                </div>
                <div class="notice-board">
                    <div class="title-area">
                        <div class="title-text"><h2>???????????? ????????????</h2></div>
                        <div class="close-icon"><svg style="outline:none; color: white;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon1 Hawkins-Icon-Standard" data-uia="previewModal-closebtn" role="button" aria-label="close" tabindex="0"><path fill-rule="evenodd" clip-rule="evenodd" d="M2.29297 3.70706L10.5859 12L2.29297 20.2928L3.70718 21.7071L12.0001 13.4142L20.293 21.7071L21.7072 20.2928L13.4143 12L21.7072 3.70706L20.293 2.29285L12.0001 10.5857L3.70718 2.29285L2.29297 3.70706Z" fill="currentColor"></path></svg></div>
                    </div>
                    <div class="sub-title">
                        <span class="video-type">?????????</span>
                        <span class="video-year">2020</span>
                    </div>
                    <div class="cm-content-wrap">
                        <div class="grade-text">
                            ??????
                        </div>
                        <div class="grade-box">
                            <div class="user-grade-sum-box">
                                <h3 style="text-align: center; color: white;">????????? ??????</h3>
                                <div class="star-grade" style="font-size: 3.6rem;margin-top:50px; color: black; text-align: center; color: white;"></div>
                                <!-- <form style="text-align: center;" name="myform" id="myform" method="post" action="./save">
                                    <fieldset>
                                        <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">
                                        <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">
                                        <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">
                                        <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">
                                        <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">
                                    </fieldset>
                                </form> -->
                                <div class="participation" style="margin-top:50px; color: white; text-align: center;"></div>
                            </div>
                            <div class="age-satisfaction-box">
                                <h3 style="color: white; text-align: center; border-bottom: solid 1px gray; padding-bottom: 10px;">????????? ?????????</h3>
                                <div class="graph-box">
                                    <div style="width: 363px; height: 175px;">
                                        <canvas id="drama-chart"></canvas>
                                    </div>
                                    <script type="text/javascript">
                                        var context = document.getElementById('drama-chart').getContext('2d');
                                        var myChart = new Chart(context,
                                                {
                                                    type : 'bar', // ????????? ??????
                                                    data : { // ????????? ????????? ?????????
                                                        labels : [
                                                        //x ???
                                                        '10???', '20???', '30???', '40???', '50???'],
                                                        datasets : [ { //?????????
                                                            label : '', //?????? ??????
                                                            fill : false, // line ????????? ???, ??? ????????? ???????????? ???????????????
                                                            data : [ 21, 19, 25, 20, 23 //x??? label??? ???????????? ????????? ???
                                                            ],
                                                            backgroundColor : [
                                                            //??????
                                                            'rgba(255, 99, 132, 0.2)',
                                                                    'rgba(54, 162, 235, 0.2)',
                                                                    'rgba(255, 206, 86, 0.2)',
                                                                    'rgba(75, 192, 192, 0.2)',
                                                                    'rgba(255, 159, 64, 0.2)' ],
                                                            borderColor : [
                                                            //????????? ??????
                                                            'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',
                                                                    'rgba(255, 206, 86, 1)',
                                                                    'rgba(75, 192, 192, 1)',
                                                                    'rgba(255, 159, 64, 1)' ],
                                                            borderWidth : 1
                                                        //????????? ??????
                                                        } /* ,
                                                                                {
                                                                                    label: 'test2',
                                                                                    fill: false,
                                                                                    data: [
                                                                                        8, 34, 12, 24
                                                                                    ],
                                                                                    backgroundColor: 'rgb(157, 109, 12)',
                                                                                    borderColor: 'rgb(157, 109, 12)'
                                                                                } */
                                                        ]
                                                    },
                                                    options : {
                                                        scales : {
                                                            yAxes : [ {
                                                                ticks : {
                                                                    beginAtZero : true
                                                                }
                                                            } ]
                                                        }
                                                    }
                                                });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cm-content-area">
                        <div class="netizens-text" style="font-size: 22px; color: white; padding: 20px 0; text-align: center; border-bottom: solid 1px gray;">
                            ????????? / ?????????
                        </div>
                        <div style="font-size: 22px; color: white; padding: 40px 0 20px 0; text-align: center;">????????? ??????????????????.</div>
                        <form style="text-align: center;" name="myform" id="netizens-grade" method="post" action="./save">
                            <fieldset class="starpoint-box">
                                <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1" class="star-radio">
                                <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2" class="star-radio">
                                <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3" class="star-radio">
                                <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4" class="star-radio">
                                <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5" class="star-radio">
                            </fieldset>
                        </form>
                        <div class="cm_form_intro_box"> 
                            <div class="area_input_box"> 
                                <input id="user_comment" type="text" class="this_input_write" placeholder="???????????? ??????????????????."> 
                            </div> 
                            <button type="button" class="this_button_write">??????</button> 
                        </div>
                        <div class="list-container">
                            <!-- <h3 class="list-select-box" style="color: white; margin-left: 15px;">?????????</h3> -->
                           	<!--<i style="color: white;" class="fa fa-chevron-down"></i>  -->
                           	
                        	<select class="list-box">
                            	<option class="select" selected>??????</option>
                            	<option class="new">?????????</option>
                           	 	<option class="sympathy">?????????</option>
                           	 	<option class="myComment">?????? ????????? ???</option>
                        	</select>
                        </div>
                        <div class="comment-all-box">
                            <%-- <%
                        ArrayList<CommentBoxDto> cSDto = (ArrayList<CommentBoxDto>)request.getAttribute("cSDto");
                        for(CommentBoxDto commentBox : cSDto) {
                        %> --%>
                            <div class="comment-box" commentId="<%-- <%=commentBox.getCommentId() %> --%>">
                                <div>
                                    <form name="myform" id="myform3" method="post" action="./save">
                                        <fieldset id="comment-grade">
                                            <label for="rate1">???</label><input type="radio" name="rating" value="1" id="rate1">
                                            <label for="rate2">???</label><input type="radio" name="rating" value="2" id="rate2">
                                            <label for="rate3">???</label><input type="radio" name="rating" value="3" id="rate3">
                                            <label for="rate4">???</label><input type="radio" name="rating" value="4" id="rate4">
                                            <label for="rate5">???</label><input type="radio" name="rating" value="5" id="rate5">
                                        </fieldset>
                                    </form>
                                    <div class="user-grade">0</div>
                                </div>
                                <div>
                                    <div class="user-comment"><%-- <%=commentBox.getUserComment() %> --%></div>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <div class="user-id"><%-- <%=commentBox.getProfileId() %> --%></div>
                                    <div class="comment-day"><%-- <%=commentBox.getCommentDate() %> --%></div>
                                </div>
                                <div>
                                    <div class="cm_sympathy_area">
                                        <button type="button" class="area_button_upvote">
                                            <span class="plus-count"><i class="fa fa-thumbs-up"><%-- <%=commentBox.getLikeHitCount() %> --%></i></span>
                                        </button>
                                        <button type="button" class="area_button_downvote">
                                            <span class="mines-count"><i class="fa fa-thumbs-down"><%-- <%=commentBox.getUnlikeHitCount() %> --%></i></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                			<%-- <%
                        	}
                        	%>  --%>
                        </div>
                    </div>    
                </div>
            </div>
            
            <%
			ArrayList<MainRandomDto> mRList = (ArrayList<MainRandomDto>)request.getAttribute("mRList");
            for(MainRandomDto mRDto : mRList) {
			%>
            <img class="main-img"
                src="<%=mRDto.getPriviewImage() %>"
                width="100%" height="100%">
            <div class="overlay">
                <div class="banner">
                    <img class="titleImage"
                        src="<%=mRDto.getTitleImage() %>"></img>
                    <div class="summary"><%=mRDto.getSummary() %></div>
                    <div class="buttons">
                        <div class="play-box">
                            <a class="white-button"
                                href="<%=mRDto.getFirstVideo() %>">
                                <i class="fas fa-play"></i>
                                ??????
                            </a>
                        </div>
                        <div class="detail-box">
                            <div class="gray-button" detailVideoId="<%=mRDto.getMovieDramaId() %>">
                                <i class="fa fa-info-circle"></i>
                                ?????? ??????
                            </div>
                        </div>
                    </div>
                    <div class="extra">
                        <!-- <button class="replay-button">
                            <i class="fa fa-redo fa-lg"></i>
                        </button> -->
                        <p class="rating">
                            <!-- <img src="images/12.png" width="30"> -->
                            <h2 style="position: absolute; margin-left: 22px; margin-top: 25px"><%=mRDto.getAge() %>+</h2>
            <%
			}
			%>
                        </p>
                    </div>
                </div>
                <div class="contents">
                    <div class="contents-list">
                        <h2 class="top-movie">TOP 10 ??????</h2>
                        <div class="swiper mySwiper" style="overflow:initial;">
	                        <div class="swiper-wrapper">
		                        <div style="display:flex" class="swiper-slide">
		                        	<div gubun="movie" class="movie-rank" style="display: flex;" >
		                                <svg id="rank-1" width="100%" height="100%" viewBox="-20 0 70 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M35.377 152H72V2.538L2 19.362v30.341l33.377-8.459V152z"></path>
		                                </svg>
		                                <%
		                                	ArrayList<VideoIdDto> top1Movie = (ArrayList<VideoIdDto>)request.getAttribute("top1Movie");
		                                	for(VideoIdDto tDto : top1Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-2" width="100%" height="100%" viewBox="0 0 80 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M3.72 152H113v-30.174H50.484l4.355-3.55 29.453-24.012c5.088-4.124 9.748-8.459 13.983-13.004 4.16-4.464 7.481-9.339 9.972-14.629 2.449-5.203 3.678-11.113 3.678-17.749 0-9.428-2.294-17.627-6.875-24.645-4.597-7.042-10.941-12.494-19.07-16.376C77.803 3.957 68.496 2 58.036 2 47.591 2 38.37 4.023 30.347 8.06c-8.015 4.032-14.457 9.578-19.352 16.654-4.492 6.493-7.389 13.803-8.693 21.952h34.055c1.236-3.52 3.398-6.52 6.459-8.97 3.54-2.834 8.277-4.224 14.147-4.224 5.93 0 10.552 1.537 13.76 4.681 3.181 3.12 4.791 7.024 4.791 11.594 0 4.151-1.16 7.934-3.468 11.298-2.192 3.194-5.987 7.124-11.405 11.84L3.72 122.465V152z">
		                                    </path>
		                                </svg>
		                                <%
		                                	ArrayList<VideoIdDto> top2Movie = (ArrayList<VideoIdDto>)request.getAttribute("top2Movie");
	                                		for(VideoIdDto tDto : top2Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-3" width="100%" height="100%" viewBox="0 0 80 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M3.809 41.577h33.243c1.3-2.702 3.545-4.947 6.674-6.72 3.554-2.015 7.83-3.01 12.798-3.01 5.555 0 10.14 1.11 13.723 3.376 3.839 2.427 5.782 6.283 5.782 11.315 0 4.553-1.853 8.395-5.473 11.38-3.547 2.926-8.18 4.37-13.821 4.37H41.44v28.366h16.77c5.572 0 10.275 1.227 14.068 3.711 4.02 2.633 6.071 6.581 6.071 11.616 0 5.705-1.943 9.975-5.853 12.562-3.658 2.42-8.292 3.61-13.863 3.61-5.205 0-9.82-.94-13.827-2.836-3.698-1.75-6.32-4.272-7.785-7.529H2.33c2.096 12.089 7.761 21.65 17.028 28.78C29.242 148.175 42.594 152 59.476 152c10.706 0 20.175-1.783 28.42-5.337 8.185-3.528 14.575-8.486 19.208-14.884 4.595-6.346 6.896-13.938 6.896-22.837 0-6.952-1.93-13.494-5.81-19.666-3.815-6.07-9.68-10.367-17.683-12.908l-5.46-1.735 5.353-2.04c6.659-2.538 11.667-6.338 15.083-11.412 3.431-5.096 5.142-10.806 5.142-17.181 0-8.471-2.262-15.778-6.787-21.985-4.574-6.275-10.7-11.17-18.408-14.696C77.683 3.775 69.109 2 59.687 2 44.084 2 31.515 5.816 21.91 13.415c-9 7.119-15.025 16.486-18.101 28.162z">
		                                    </path>
		                                </svg>
		                                <%
		                                	ArrayList<VideoIdDto> top3Movie = (ArrayList<VideoIdDto>)request.getAttribute("top3Movie");
                                			for(VideoIdDto tDto : top3Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-4" width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M72 152h35.333v-30.977H128V92.497h-20.667V2H69.89L2 92.712v28.311h70V152zM36.202 92.188l35.93-47.998v47.998h-35.93z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top4Movie = (ArrayList<VideoIdDto>)request.getAttribute("top4Movie");
	                            			for(VideoIdDto tDto : top4Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-5" width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M105.588 32.174V2H13.534l-8.3 88.357h32.463c2.145-2.362 4.866-4.254 8.143-5.675 3.585-1.554 7.543-2.328 11.859-2.328 6.247 0 11.418 1.745 15.418 5.255 4.061 3.564 6.104 8.37 6.104 14.265 0 6.041-2.044 10.89-6.121 14.387-3.999 3.43-9.162 5.132-15.401 5.132-4.299 0-8.17-.694-11.601-2.095-3.11-1.268-5.577-2.946-7.368-5.042H2.592c3.308 11.593 9.782 20.623 19.46 27.164C32.472 148.464 45.64 152 61.602 152c10.12 0 19.294-1.99 27.548-5.966 8.198-3.949 14.711-9.718 19.572-17.335 4.844-7.59 7.278-16.95 7.278-28.123 0-9.182-2.013-17.314-6.032-24.431-4.02-7.118-9.514-12.7-16.51-16.775-6.99-4.072-14.849-6.109-23.612-6.109-11.06 0-20.099 3.483-27.234 10.461l-3.892 3.806 3.273-35.354h63.595z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top5Movie = (ArrayList<VideoIdDto>)request.getAttribute("top5Movie");
	                            			for(VideoIdDto tDto : top5Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-6" width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M79.482 38.192h35.551c-3.284-10.945-8.963-19.573-17.048-25.938C89.323 5.434 77.531 2 62.545 2 50.756 2 40.35 4.86 31.277 10.577c-9.064 5.712-16.198 14.09-21.412 25.178C4.63 46.893 2 60.425 2 76.365c0 14.416 2.356 27.344 7.059 38.798 4.667 11.368 11.573 20.34 20.734 26.956C38.904 148.7 50.225 152 63.816 152a61.513 61.513 0 0019.922-3.278 53.546 53.546 0 0017.378-9.792c5.154-4.33 9.255-9.64 12.314-15.947 3.042-6.273 4.57-13.556 4.57-21.868 0-8.812-2.062-16.636-6.182-23.51-4.134-6.897-9.643-12.293-16.55-16.212-6.905-3.917-14.48-5.874-22.76-5.874-14.546 0-25.34 4.55-32.569 13.63l-4.003 5.03.443-6.413c.874-12.636 3.56-21.85 8.168-27.654 4.69-5.907 10.885-8.9 18.421-8.9 4.26 0 7.826.734 10.685 2.24 2.445 1.287 4.396 2.867 5.829 4.74zM62.605 123c-5.825 0-10.902-1.894-15.136-5.655C43.173 113.528 41 108.603 41 102.71c0-5.881 2.164-10.864 6.44-14.818C51.674 83.975 56.762 82 62.604 82c5.847 0 10.906 1.98 15.074 5.905C81.878 91.859 84 96.837 84 102.71c0 5.885-2.131 10.805-6.35 14.622-4.167 3.77-9.214 5.668-15.045 5.668z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top6Movie = (ArrayList<VideoIdDto>)request.getAttribute("top6Movie");
	                            			for(VideoIdDto tDto : top6Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                       </div>
		                       <div style="display:flex" class="swiper-slide">
		                            <div gubun="movie" class="movie-rank" style="display: flex; margin-left: 31px;">
		                                <svg id="rank-7" width="100%" height="100%" viewBox="0 0 78 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M113,2 L2,2 L2,33.4022989 L75.9665929,33.4022989 L21.22571,152 L60.28102,152 L113,32.7672283 L113,2 Z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top7Movie = (ArrayList<VideoIdDto>)request.getAttribute("top7Movie");
	                            			for(VideoIdDto tDto : top7Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-8" width="100%" height="100%" viewBox="0 0 77 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M59.5 152c11.335 0 21.358-1.72 30.077-5.15 8.637-3.397 15.361-8.258 20.213-14.586 4.805-6.267 7.21-13.876 7.21-22.899 0-7.326-2.261-14.07-6.813-20.29-4.548-6.214-10.837-10.658-18.922-13.35l-5.4-1.799 5.338-1.975c7.238-2.678 12.572-6.683 16.066-12.018 3.53-5.388 5.284-11.178 5.284-17.414 0-7.912-2.133-14.839-6.405-20.84-4.3-6.042-10.403-10.825-18.345-14.351C79.816 3.78 70.386 2 59.5 2S39.184 3.781 31.197 7.328c-7.942 3.526-14.044 8.309-18.345 14.351-4.272 6.001-6.405 12.928-6.405 20.84 0 6.236 1.755 12.026 5.284 17.414 3.494 5.335 8.828 9.34 16.066 12.018l5.338 1.975-5.4 1.798c-8.085 2.693-14.374 7.137-18.922 13.351C4.261 95.295 2 102.04 2 109.365c0 9.023 2.405 16.632 7.21 22.899 4.852 6.328 11.576 11.19 20.213 14.586 8.72 3.43 18.742 5.15 30.077 5.15zm.5-89c-5.6 0-10.334-1.515-14.125-4.56C41.985 55.313 40 51.183 40 46.21c0-5.244 1.976-9.518 5.875-12.65C49.666 30.515 54.4 29 60 29s10.334 1.515 14.125 4.56C78.025 36.694 80 40.968 80 46.212c0 4.973-1.985 9.103-5.875 12.228C70.334 61.485 65.6 63 60 63zm-.5 62c-6.255 0-11.556-1.613-15.836-4.856-4.41-3.343-6.664-7.816-6.664-13.25 0-5.298 2.258-9.698 6.664-13.038C47.944 90.613 53.245 89 59.5 89c6.255 0 11.556 1.613 15.836 4.856 4.406 3.34 6.664 7.74 6.664 13.038 0 5.434-2.254 9.907-6.664 13.25C71.056 123.387 65.755 125 59.5 125z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top8Movie = (ArrayList<VideoIdDto>)request.getAttribute("top8Movie");
	                            			for(VideoIdDto tDto : top8Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-9" width="100%" height="100%" viewBox="0 0 71 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M40.0597376,115.807692 L4.47328474,115.807692 C7.45109332,126.586242 13.4362856,135.15497 22.4670906,141.582071 C32.2129251,148.518048 44.5640134,152 59.5759717,152 C78.2141671,152 92.5105725,145.697944 102.6454,133.074799 C112.853557,120.360322 118,101.543854 118,76.5769231 C118,62.1603327 115.678843,49.3016297 111.046669,37.9886125 C106.453069,26.7698049 99.6241767,17.9802976 90.5435117,11.5767831 C81.5017862,5.20072813 70.1375399,2 56.3957597,2 C49.4158116,2 42.68229,3.15952329 36.1849549,5.47966815 C29.7045526,7.79376647 23.8782903,11.1932931 18.6948526,15.6846002 C13.5316746,20.1583529 9.45923583,25.508367 6.46782377,31.7491046 C3.4928156,37.95562 2,45.0644366 2,53.0961538 C2,61.9117395 4.02797967,69.7019439 8.0788911,76.5056791 C12.1434539,83.3323424 17.5832537,88.6925139 24.4218542,92.6108203 C31.2518358,96.5241882 38.8590885,98.4807692 47.2791519,98.4807692 C55.0853554,98.4807692 61.6095996,97.3619306 66.8547126,95.1478231 C72.0569983,92.9517941 76.4513169,89.5970183 80.0605818,85.0622151 L84.0584687,80.039134 L83.6207883,86.4440446 C82.74746,99.2241219 80.0984349,108.438199 75.5533003,114.10687 C70.9310132,119.871766 64.7726909,122.788462 57.2438163,122.788462 C52.8691399,122.788462 49.1904302,122.100251 46.212535,120.692834 C43.5930338,119.454801 41.5307848,117.825945 40.0597376,115.807692 Z M57.5,31 C63.3657106,31 68.4419893,32.9364861 72.6299874,36.7826253 C76.8609583,40.6682294 79,45.6186068 79,51.5 C79,57.3813932 76.8609583,62.3317706 72.6299874,66.2173747 C68.4419893,70.0635139 63.3657106,72 57.5,72 C51.6342894,72 46.5580107,70.0635139 42.3700126,66.2173747 C38.1390417,62.3317706 36,57.3813932 36,51.5 C36,45.6186068 38.1390417,40.6682294 42.3700126,36.7826253 C46.5580107,32.9364861 51.6342894,31 57.5,31 Z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top9Movie = (ArrayList<VideoIdDto>)request.getAttribute("top9Movie");
	                            			for(VideoIdDto tDto : top9Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                            <div gubun="movie" class="movie-rank" style="display: flex;">
		                                <svg id="rank-10" width="100%" height="100%" viewBox="0 0 140 154" class="svg-icon">
		                                    <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
		                                        d="M34.757 151.55h35.869V2.976L2 19.687v30.14l32.757-8.41v110.132zm105.53 3.45c12.394 0 23.097-3.12 32.163-9.353 9.093-6.25 16.11-15.047 21.066-26.43C198.5 107.766 201 94.196 201 78.5c0-15.698-2.5-29.266-7.484-40.716-4.955-11.384-11.973-20.18-21.066-26.431C163.384 5.119 152.681 2 140.287 2c-12.393 0-23.096 3.12-32.162 9.353-9.093 6.25-16.11 15.047-21.066 26.43-4.984 11.45-7.484 25.02-7.484 40.717 0 15.698 2.5 29.266 7.484 40.716 4.955 11.384 11.973 20.18 21.066 26.431 9.066 6.234 19.769 9.353 32.162 9.353zm0-31.368c-7.827 0-13.942-4.147-18.15-12.178-4.053-7.736-6.047-18.713-6.047-32.954s1.994-25.218 6.047-32.954c4.208-8.03 10.323-12.178 18.15-12.178 7.827 0 13.943 4.147 18.15 12.178 4.053 7.736 6.048 18.713 6.048 32.954s-1.995 25.218-6.047 32.954c-4.208 8.03-10.324 12.178-18.15 12.178z">
		                                    </path>
		                                </svg>
		                                <%
			                                ArrayList<VideoIdDto> top10Movie = (ArrayList<VideoIdDto>)request.getAttribute("top10Movie");
	                            			for(VideoIdDto tDto : top10Movie) {
		                                %>
		                                <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
		                                    <img src="<%=tDto.getPosterImage() %>"
		                                        alt="" width="100%" height="100%">
		                                </div>
		                                <%} %>
		                            </div>
		                        </div>
                        	</div>
                        	<div class="swiper-button-box">
                        		<div class="swiper-button-next" style="right:60px;"></div>
      							<div class="swiper-button-prev" style="left:-40px";></div>
      						</div>
                        </div>
                    </div>
                    <!-- <div class="hover-priview-container">
                        <div class="priview-box">
                            <div class="hover-priview" href="https://www.netflix.com/watch/81094067?trackId=255824129&tctx=0%2C0%2CNAPA%40%40%7C500b0d55-0e81-43cf-b603-e261e3a10231-7109618_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2CNAPA%40%40%7C500b0d55-0e81-43cf-b603-e261e3a10231-7109618_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2Cunknown%2C%2C500b0d55-0e81-43cf-b603-e261e3a10231-7109618%7C1%2CtitlesResults%2C81094067" target="_blank">
                                <img class="hover-priview-img" src="https://occ-0-4342-993.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABRnAD5GLn8CRTyHgXrCFg7xBO-zp3ZKbLmOF9y-HJgqyyD9NhD_0GF7WvD6XBhSNftfFrTzIQf8S7dr77nEJxI0qfMXWfS_pWGMMSzAD1vHt04zJ4ZWKCEaZhGWx.jpg?r=4fa" width="100%" height="100%">
                            </div>
                            <div class="button-container">
                                <div class="box-information">
                                    <a class="primary-button" tabindex="0" toolkitsize="small" listid="GPS_0E85D5A41276BEAEA170340BFDFCD4-A3F87CB3ABAB23-56C897381A_p_1655091994492" ranknum="3" requestid="9d8ed131-f7ff-4c20-8c93-43fa28954bef-893251948" rownum="3" trackid="15035895" data-uia="play-button" role="link" aria-label="??????" href="https://www.netflix.com/watch/81094067?trackId=255824129&tctx=0%2C0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2CNAPA%40%40%7Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782_titles%2F1%2F%2F%EC%8A%B9%EB%A6%AC%ED%98%B8%2F0%2F0%2Cunknown%2C%2Cc89e0000-96df-4e3a-a71d-df8d1e5d8b54-512194782%7C1%2C%2C">
                                        <div style="margin-left:8px; margin-top: 7px;" class="color-primary" tabindex="-1" type="button">
                                            <div class="ltr-1ksxkn9">
                                                <div class="small ltr-18dhnor" role="presentation">
                                                    <svg style="color: black;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                        <path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">

                                                        </path>
                                                    </svg>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                    <div class="ltr">
                                        <div class="ptrack-content" data-ui-tracking-context="%7B%22lolomo_id%22:%22GPS_0E85D5A41276BEAEA170340BFDFCD4_p_1655091994492%22,%22list_id%22:%22GPS_0E85D5A41276BEAEA170340BFDFCD4-A3F87CB3ABAB23-56C897381A_p_1655091994492%22,%22location%22:%22homeScreen%22,%22rank%22:3,%22request_id%22:%229d8ed131-f7ff-4c20-8c93-43fa28954bef-893251948%22,%22row%22:3,%22track_id%22:15035895,%22video_id%22:17672132,%22supp_video_id%22:1,%22appView%22:%22addToMyListButton%22,%22usePresentedEvent%22:true%7D" data-tracking-uuid="d45c9085-3180-43e0-bbbe-068593399c94">
                                            <div aria-label="?????? ?????? ???????????? ??????" class="color-supplementary hasIcon round ltr-1f1y58d" data-uia="add-to-my-list" type="button">
                                                <div class="ltr-1ksxkn9">
                                                    <div class="small ltr-18dhnor" role="presentation">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                            <path fill-rule="evenodd" clip-rule="evenodd" d="M11 2V11H2V13H11V22H13V13H22V11H13V2H11Z" fill="currentColor">

                                                            </path>
                                                        </svg>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="buttonControls">
                                        <div style="margin-left:8px; margin-top: 8px;" aria-label="expand to detail modal" class="color-supplementary hasIcon round ltr-1f1y58d" data-uia="expand-to-detail-button" type="button">
                                            <div class="ltr-1ksxkn9">
                                                <div class="small ltr-18dhnor" role="presentation">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M19.293 7.29297L12.0001 14.5859L4.70718 7.29297L3.29297 8.70718L11.293 16.7072C11.4805 16.8947 11.7349 17.0001 12.0001 17.0001C12.2653 17.0001 12.5196 16.8947 12.7072 16.7072L20.7072 8.70718L19.293 7.29297Z" fill="currentColor">

                                                        </path>
                                                    </svg>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="age-container">
                                <div class="age-information">
                                    <span class="age">
                                        <img src="images/12.png">
                                    </span>
                                    <span class="running-time">
                                        1?????? 43???
                                    </span>
                                </div>
                            </div>
                            <div class="lower-container">
                                <div class="genre-information">
                                    <span class="genre">
                                        <span>SF ?????? ??? ?????? & ????????????</span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
		  </div>
        </div>
        <div class="background-fill" style="background: #141414; height: 101px; width: 1777px;position: absolute;">
        	
        </div>
        <div class="main">
            <div class="main-contents">
                <h2 class="top-drama">TOP 10 ?????????</h2>
                <div class="top-drama-list">
	                <div class="swiper mySwiper1" style="overflow:initial;">
		                <div class="swiper-wrapper" style="width:1680px;">
			                <div class="swiper-slide" style="display:flex;">
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="-20 0 70 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M35.377 152H72V2.538L2 19.362v30.341l33.377-8.459V152z"></path>
			                        </svg>
			                        <%
		                        	ArrayList<VideoIdDto> top1Drama = (ArrayList<VideoIdDto>)request.getAttribute("top1Drama");
		                        	for(VideoIdDto tDto : top1Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 80 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M3.72 152H113v-30.174H50.484l4.355-3.55 29.453-24.012c5.088-4.124 9.748-8.459 13.983-13.004 4.16-4.464 7.481-9.339 9.972-14.629 2.449-5.203 3.678-11.113 3.678-17.749 0-9.428-2.294-17.627-6.875-24.645-4.597-7.042-10.941-12.494-19.07-16.376C77.803 3.957 68.496 2 58.036 2 47.591 2 38.37 4.023 30.347 8.06c-8.015 4.032-14.457 9.578-19.352 16.654-4.492 6.493-7.389 13.803-8.693 21.952h34.055c1.236-3.52 3.398-6.52 6.459-8.97 3.54-2.834 8.277-4.224 14.147-4.224 5.93 0 10.552 1.537 13.76 4.681 3.181 3.12 4.791 7.024 4.791 11.594 0 4.151-1.16 7.934-3.468 11.298-2.192 3.194-5.987 7.124-11.405 11.84L3.72 122.465V152z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top2Drama = (ArrayList<VideoIdDto>)request.getAttribute("top2Drama");
		                        	for(VideoIdDto tDto : top2Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 80 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M3.809 41.577h33.243c1.3-2.702 3.545-4.947 6.674-6.72 3.554-2.015 7.83-3.01 12.798-3.01 5.555 0 10.14 1.11 13.723 3.376 3.839 2.427 5.782 6.283 5.782 11.315 0 4.553-1.853 8.395-5.473 11.38-3.547 2.926-8.18 4.37-13.821 4.37H41.44v28.366h16.77c5.572 0 10.275 1.227 14.068 3.711 4.02 2.633 6.071 6.581 6.071 11.616 0 5.705-1.943 9.975-5.853 12.562-3.658 2.42-8.292 3.61-13.863 3.61-5.205 0-9.82-.94-13.827-2.836-3.698-1.75-6.32-4.272-7.785-7.529H2.33c2.096 12.089 7.761 21.65 17.028 28.78C29.242 148.175 42.594 152 59.476 152c10.706 0 20.175-1.783 28.42-5.337 8.185-3.528 14.575-8.486 19.208-14.884 4.595-6.346 6.896-13.938 6.896-22.837 0-6.952-1.93-13.494-5.81-19.666-3.815-6.07-9.68-10.367-17.683-12.908l-5.46-1.735 5.353-2.04c6.659-2.538 11.667-6.338 15.083-11.412 3.431-5.096 5.142-10.806 5.142-17.181 0-8.471-2.262-15.778-6.787-21.985-4.574-6.275-10.7-11.17-18.408-14.696C77.683 3.775 69.109 2 59.687 2 44.084 2 31.515 5.816 21.91 13.415c-9 7.119-15.025 16.486-18.101 28.162z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top3Drama = (ArrayList<VideoIdDto>)request.getAttribute("top3Drama");
		                        	for(VideoIdDto tDto : top3Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M72 152h35.333v-30.977H128V92.497h-20.667V2H69.89L2 92.712v28.311h70V152zM36.202 92.188l35.93-47.998v47.998h-35.93z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top4Drama = (ArrayList<VideoIdDto>)request.getAttribute("top4Drama");
		                        	for(VideoIdDto tDto : top4Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M105.588 32.174V2H13.534l-8.3 88.357h32.463c2.145-2.362 4.866-4.254 8.143-5.675 3.585-1.554 7.543-2.328 11.859-2.328 6.247 0 11.418 1.745 15.418 5.255 4.061 3.564 6.104 8.37 6.104 14.265 0 6.041-2.044 10.89-6.121 14.387-3.999 3.43-9.162 5.132-15.401 5.132-4.299 0-8.17-.694-11.601-2.095-3.11-1.268-5.577-2.946-7.368-5.042H2.592c3.308 11.593 9.782 20.623 19.46 27.164C32.472 148.464 45.64 152 61.602 152c10.12 0 19.294-1.99 27.548-5.966 8.198-3.949 14.711-9.718 19.572-17.335 4.844-7.59 7.278-16.95 7.278-28.123 0-9.182-2.013-17.314-6.032-24.431-4.02-7.118-9.514-12.7-16.51-16.775-6.99-4.072-14.849-6.109-23.612-6.109-11.06 0-20.099 3.483-27.234 10.461l-3.892 3.806 3.273-35.354h63.595z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top5Drama = (ArrayList<VideoIdDto>)request.getAttribute("top5Drama");
		                        	for(VideoIdDto tDto : top5Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 81 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M79.482 38.192h35.551c-3.284-10.945-8.963-19.573-17.048-25.938C89.323 5.434 77.531 2 62.545 2 50.756 2 40.35 4.86 31.277 10.577c-9.064 5.712-16.198 14.09-21.412 25.178C4.63 46.893 2 60.425 2 76.365c0 14.416 2.356 27.344 7.059 38.798 4.667 11.368 11.573 20.34 20.734 26.956C38.904 148.7 50.225 152 63.816 152a61.513 61.513 0 0019.922-3.278 53.546 53.546 0 0017.378-9.792c5.154-4.33 9.255-9.64 12.314-15.947 3.042-6.273 4.57-13.556 4.57-21.868 0-8.812-2.062-16.636-6.182-23.51-4.134-6.897-9.643-12.293-16.55-16.212-6.905-3.917-14.48-5.874-22.76-5.874-14.546 0-25.34 4.55-32.569 13.63l-4.003 5.03.443-6.413c.874-12.636 3.56-21.85 8.168-27.654 4.69-5.907 10.885-8.9 18.421-8.9 4.26 0 7.826.734 10.685 2.24 2.445 1.287 4.396 2.867 5.829 4.74zM62.605 123c-5.825 0-10.902-1.894-15.136-5.655C43.173 113.528 41 108.603 41 102.71c0-5.881 2.164-10.864 6.44-14.818C51.674 83.975 56.762 82 62.604 82c5.847 0 10.906 1.98 15.074 5.905C81.878 91.859 84 96.837 84 102.71c0 5.885-2.131 10.805-6.35 14.622-4.167 3.77-9.214 5.668-15.045 5.668z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top6Drama = (ArrayList<VideoIdDto>)request.getAttribute("top6Drama");
		                        	for(VideoIdDto tDto : top6Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                </div>
			                <div class="swiper-slide" style="display:flex;">
			                    <div gubun="drama" class="drama-rank" style="display: flex; margin-left:32px;">
			                        <svg width="100%" height="100%" viewBox="0 0 78 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M113,2 L2,2 L2,33.4022989 L75.9665929,33.4022989 L21.22571,152 L60.28102,152 L113,32.7672283 L113,2 Z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top7Drama = (ArrayList<VideoIdDto>)request.getAttribute("top7Drama");
		                        	for(VideoIdDto tDto : top7Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 77 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M59.5 152c11.335 0 21.358-1.72 30.077-5.15 8.637-3.397 15.361-8.258 20.213-14.586 4.805-6.267 7.21-13.876 7.21-22.899 0-7.326-2.261-14.07-6.813-20.29-4.548-6.214-10.837-10.658-18.922-13.35l-5.4-1.799 5.338-1.975c7.238-2.678 12.572-6.683 16.066-12.018 3.53-5.388 5.284-11.178 5.284-17.414 0-7.912-2.133-14.839-6.405-20.84-4.3-6.042-10.403-10.825-18.345-14.351C79.816 3.78 70.386 2 59.5 2S39.184 3.781 31.197 7.328c-7.942 3.526-14.044 8.309-18.345 14.351-4.272 6.001-6.405 12.928-6.405 20.84 0 6.236 1.755 12.026 5.284 17.414 3.494 5.335 8.828 9.34 16.066 12.018l5.338 1.975-5.4 1.798c-8.085 2.693-14.374 7.137-18.922 13.351C4.261 95.295 2 102.04 2 109.365c0 9.023 2.405 16.632 7.21 22.899 4.852 6.328 11.576 11.19 20.213 14.586 8.72 3.43 18.742 5.15 30.077 5.15zm.5-89c-5.6 0-10.334-1.515-14.125-4.56C41.985 55.313 40 51.183 40 46.21c0-5.244 1.976-9.518 5.875-12.65C49.666 30.515 54.4 29 60 29s10.334 1.515 14.125 4.56C78.025 36.694 80 40.968 80 46.212c0 4.973-1.985 9.103-5.875 12.228C70.334 61.485 65.6 63 60 63zm-.5 62c-6.255 0-11.556-1.613-15.836-4.856-4.41-3.343-6.664-7.816-6.664-13.25 0-5.298 2.258-9.698 6.664-13.038C47.944 90.613 53.245 89 59.5 89c6.255 0 11.556 1.613 15.836 4.856 4.406 3.34 6.664 7.74 6.664 13.038 0 5.434-2.254 9.907-6.664 13.25C71.056 123.387 65.755 125 59.5 125z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top8Drama = (ArrayList<VideoIdDto>)request.getAttribute("top8Drama");
		                        	for(VideoIdDto tDto : top8Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 71 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M40.0597376,115.807692 L4.47328474,115.807692 C7.45109332,126.586242 13.4362856,135.15497 22.4670906,141.582071 C32.2129251,148.518048 44.5640134,152 59.5759717,152 C78.2141671,152 92.5105725,145.697944 102.6454,133.074799 C112.853557,120.360322 118,101.543854 118,76.5769231 C118,62.1603327 115.678843,49.3016297 111.046669,37.9886125 C106.453069,26.7698049 99.6241767,17.9802976 90.5435117,11.5767831 C81.5017862,5.20072813 70.1375399,2 56.3957597,2 C49.4158116,2 42.68229,3.15952329 36.1849549,5.47966815 C29.7045526,7.79376647 23.8782903,11.1932931 18.6948526,15.6846002 C13.5316746,20.1583529 9.45923583,25.508367 6.46782377,31.7491046 C3.4928156,37.95562 2,45.0644366 2,53.0961538 C2,61.9117395 4.02797967,69.7019439 8.0788911,76.5056791 C12.1434539,83.3323424 17.5832537,88.6925139 24.4218542,92.6108203 C31.2518358,96.5241882 38.8590885,98.4807692 47.2791519,98.4807692 C55.0853554,98.4807692 61.6095996,97.3619306 66.8547126,95.1478231 C72.0569983,92.9517941 76.4513169,89.5970183 80.0605818,85.0622151 L84.0584687,80.039134 L83.6207883,86.4440446 C82.74746,99.2241219 80.0984349,108.438199 75.5533003,114.10687 C70.9310132,119.871766 64.7726909,122.788462 57.2438163,122.788462 C52.8691399,122.788462 49.1904302,122.100251 46.212535,120.692834 C43.5930338,119.454801 41.5307848,117.825945 40.0597376,115.807692 Z M57.5,31 C63.3657106,31 68.4419893,32.9364861 72.6299874,36.7826253 C76.8609583,40.6682294 79,45.6186068 79,51.5 C79,57.3813932 76.8609583,62.3317706 72.6299874,66.2173747 C68.4419893,70.0635139 63.3657106,72 57.5,72 C51.6342894,72 46.5580107,70.0635139 42.3700126,66.2173747 C38.1390417,62.3317706 36,57.3813932 36,51.5 C36,45.6186068 38.1390417,40.6682294 42.3700126,36.7826253 C46.5580107,32.9364861 51.6342894,31 57.5,31 Z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top9Drama = (ArrayList<VideoIdDto>)request.getAttribute("top9Drama");
		                        	for(VideoIdDto tDto : top9Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                    <div gubun="drama" class="drama-rank" style="display: flex;">
			                        <svg width="100%" height="100%" viewBox="0 0 140 154" class="svg-icon">
			                            <path stroke="#595959" stroke-linejoin="square" stroke-width="4"
			                                d="M34.757 151.55h35.869V2.976L2 19.687v30.14l32.757-8.41v110.132zm105.53 3.45c12.394 0 23.097-3.12 32.163-9.353 9.093-6.25 16.11-15.047 21.066-26.43C198.5 107.766 201 94.196 201 78.5c0-15.698-2.5-29.266-7.484-40.716-4.955-11.384-11.973-20.18-21.066-26.431C163.384 5.119 152.681 2 140.287 2c-12.393 0-23.096 3.12-32.162 9.353-9.093 6.25-16.11 15.047-21.066 26.43-4.984 11.45-7.484 25.02-7.484 40.717 0 15.698 2.5 29.266 7.484 40.716 4.955 11.384 11.973 20.18 21.066 26.431 9.066 6.234 19.769 9.353 32.162 9.353zm0-31.368c-7.827 0-13.942-4.147-18.15-12.178-4.053-7.736-6.047-18.713-6.047-32.954s1.994-25.218 6.047-32.954c4.208-8.03 10.323-12.178 18.15-12.178 7.827 0 13.943 4.147 18.15 12.178 4.053 7.736 6.048 18.713 6.048 32.954s-1.995 25.218-6.047 32.954c-4.208 8.03-10.324 12.178-18.15 12.178z">
			                            </path>
			                        </svg>
			                        <%
			                        ArrayList<VideoIdDto> top10Drama = (ArrayList<VideoIdDto>)request.getAttribute("top10Drama");
		                        	for(VideoIdDto tDto : top10Drama) {
			                        %>
			                        <div class="boxart-image" movieDramaId="<%=tDto.getMovieDramaId() %>">
			                            <img src="<%=tDto.getPosterImage() %>"
			                                alt="" width="100%" height="100%">
			                        </div>
			                        <%} %>
			                    </div>
			                </div>
			            </div>
			            <div class="swiper-button-box">
                        	<div class="swiper-button-next" style="right:10px"></div>
      						<div class="swiper-button-prev" style="left:-40px"></div>
      					</div>
		            </div>
	            </div>
            </div>
            <!-- <div id="drama-priview-box" class="drama-hover-priview-container">
                <div class="priview-box">
                    <div class="hover-priview" href="https://www.netflix.com/watch/81517172?trackId=255824129" target="_blank">
                        <img class="hover-priview-img" src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/X194eJsgWBDE2aQbaNdmCXGUP-Y/AAAABS0rra5Q7QJq9MR_OTTMC07QaBDIKttRCkxPNuTVZ7KQ2hTxU8YUlV7p3JJEyVfBe2c0wkm0g_ODNAMyH2U7CTijGQvVqmu_fzA.webp?r=ea6" width="100%" height="100%">
                    </div>
                    <div class="button-container">
                        <div class="box-information">
                            <a class="primary-button" tabindex="0" toolkitsize="small" listid="GPS_0E85D5A41276BEAEA170340BFDFCD4-A3F87CB3ABAB23-56C897381A_p_1655091994492" ranknum="3" requestid="9d8ed131-f7ff-4c20-8c93-43fa28954bef-893251948" rownum="3" trackid="15035895" data-uia="play-button" role="link" aria-label="??????" href="https://www.netflix.com/watch/81517172?trackId=255824129">
                                <div style="margin-left:8px; margin-top: 7px;" class="color-primary" tabindex="-1" type="button">
                                    <div class="ltr-1ksxkn9">
                                        <div class="small ltr-18dhnor" role="presentation">
                                            <svg style="color: black;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                <path d="M4 2.69127C4 1.93067 4.81547 1.44851 5.48192 1.81506L22.4069 11.1238C23.0977 11.5037 23.0977 12.4963 22.4069 12.8762L5.48192 22.1849C4.81546 22.5515 4 22.0693 4 21.3087V2.69127Z" fill="currentColor">

                                                </path>
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <div class="ltr">
                                <div class="ptrack-content" data-ui-tracking-context="%7B%22lolomo_id%22:%22GPS_0E85D5A41276BEAEA170340BFDFCD4_p_1655091994492%22,%22list_id%22:%22GPS_0E85D5A41276BEAEA170340BFDFCD4-A3F87CB3ABAB23-56C897381A_p_1655091994492%22,%22location%22:%22homeScreen%22,%22rank%22:3,%22request_id%22:%229d8ed131-f7ff-4c20-8c93-43fa28954bef-893251948%22,%22row%22:3,%22track_id%22:15035895,%22video_id%22:17672132,%22supp_video_id%22:1,%22appView%22:%22addToMyListButton%22,%22usePresentedEvent%22:true%7D" data-tracking-uuid="d45c9085-3180-43e0-bbbe-068593399c94">
                                    <div aria-label="?????? ?????? ???????????? ??????" class="color-supplementary hasIcon round ltr-1f1y58d" data-uia="add-to-my-list" type="button">
                                        <div class="ltr-1ksxkn9">
                                            <div class="small ltr-18dhnor" role="presentation">
                                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M11 2V11H2V13H11V22H13V13H22V11H13V2H11Z" fill="currentColor">

                                                    </path>
                                                </svg>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="drama-buttonControls">
                                <div style="margin-left:8px; margin-top: 8px;" aria-label="expand to detail modal" class="color-supplementary hasIcon round ltr-1f1y58d" data-uia="expand-to-detail-button" type="button">
                                    <div class="ltr-1ksxkn9">
                                        <div class="small ltr-18dhnor" role="presentation">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard">
                                                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.293 7.29297L12.0001 14.5859L4.70718 7.29297L3.29297 8.70718L11.293 16.7072C11.4805 16.8947 11.7349 17.0001 12.0001 17.0001C12.2653 17.0001 12.5196 16.8947 12.7072 16.7072L20.7072 8.70718L19.293 7.29297Z" fill="currentColor">

                                                </path>
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="age-container">
                        <div class="age-information">
                            <span class="age">
                                <img src="images/12.png">
                            </span>
                            <span class="running-time">
                                ?????? 1???
                            </span>
                        </div>
                    </div>
                    <div class="lower-container">
                        <div class="genre-information">
                            <span class="genre">
                                <span>???????????? ?????????, ?????? ?????????, ?????????</span>
                            </span>
                        </div>
                    </div>
                </div>
            </div> -->
        </div>
        <div class="main-s">
            <div class="main-viewing-contents">
                <h2 class="viewing-contends">?????? ?????? ?????????</h2>
                <div class="viewing-list">
	                <div class="swiper mySwiper2" style="overflow:initial;">
	                	<div class="swiper-button-all-box">
		                	<div class="swiper-button-next-box">
		                  		<div class="swiper-button-next"></div>
		                	</div>
		                	<div class="swiper-button-prev-box">
			     				<div class="swiper-button-prev"></div>
		                	</div>
	                	</div>
		                <div class="swiper-wrapper" style="width:1680px;">
		                <%
		                	ArrayList<VideoIdDto> viewingContents = (ArrayList<VideoIdDto>)request.getAttribute("viewingContents");
		                	for(VideoIdDto vIDto : viewingContents) {
		                %>
			                <div class="swiper-slide">
			                    <div id="viewing-contents" class="normal-image" movieDramaId="<%=vIDto.getMovieDramaId() %>">
			                        <img src="<%=vIDto.getPosterImage() %>" 
			                            alt="">
			                    </div>
			                </div>
			            <%
			              	}
			            %>
		                </div>
	                </div>
                </div>
            </div>
        </div>
        <div class="main-th">
            <div class="main-dib-contents">
                <h2 class="dib-contents">?????? ?????? ?????????</h2>
                <div class="dib-list">
	                <div class="swiper mySwiper3" style="overflow:initial;">
	                	<div class="swiper-button-all-box">
		                	<div class="swiper-button-next-box">
		                  		<div class="swiper-button-next"></div>
		                	</div>
		                	<div class="swiper-button-prev-box">
			     				<div class="swiper-button-prev"></div>
		                	</div>
	                	</div>
      					<div class="swiper-wrapper" style="width:1680px;">
      					<%
      						ArrayList<VideoIdDto> dibContents = (ArrayList<VideoIdDto>)request.getAttribute("dibContents");
      						for(VideoIdDto dDto : dibContents) {
      					%>
		                    <div class="swiper-slide">
			                    <div class="normal-image" movieDramaId="<%=dDto.getMovieDramaId() %>" >
			                        <img src="<%=dDto.getPosterImage() %>"
			                            alt="">
			                    </div>
			                </div>
			            <%} %>
      					</div>
	                </div>
                </div>
            </div>
        </div>
                	
        <div class="main-fifth">
            <div class="main-all-contents3">
                <h2 class="all-contents">?????????</h2>
                <div class="drama-scroll" style="width: 836px;height: auto;float: left; border-right:3px solid gray;/* overflow-y: scroll;overflow-x: hidden; */" class="all-list1">
                <%
                	ArrayList<VideoIdDto> dPI = (ArrayList<VideoIdDto>)request.getAttribute("dPI");
                	for(VideoIdDto vIDto : dPI) {
                %>
                    <div class="normal-image1" movieDramaId="<%=vIDto.getMovieDramaId() %>">
                        <img class="gubun-image" gubun="drama" src="<%=vIDto.getPosterImage() %>">
                    </div>
                <%
                	}
                %>
                </div>
            </div>
        </div>
        <div class="main-sixth">
            <div class="main-all-contents3">
                <h2 class="all-contents">??????</h2>
                <div class="movie-scroll" style="width: 825px;height: auto;float: left;/* overflow-y: scroll;overflow-x: hidden; */" class="all-list1">
                <%
                	ArrayList<VideoIdDto> vI = (ArrayList<VideoIdDto>)request.getAttribute("vI");
                	for(VideoIdDto vIDto : vI) {
                	
                %>
                    <div class="normal-image1" movieDramaId="<%=vIDto.getMovieDramaId() %>">
                        <img class="gubun-image" gubun="movie" src="<%=vIDto.getPosterImage() %>">
                    </div>
                <%
                	}
                %>
                </div>
            </div>
        </div>
        
                    
        <div class="lower">
            <div class="lower-icon">
                <div class="sns-icon">
                    <div class="facebook-icon">
                        <a class="icons" href="https://www.facebook.com/NetflixKR" target="_blank">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                    </div>
                    <div class="instagram-icon">
                        <a class="icons" href="https://www.instagram.com/netflixkr/" target="_blank">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </div>
                    <div class="twitter-icon">
                        <a class="icons" href="https://twitter.com/netflixkr" target="_blank">
                            <i class="fab fa-twitter"></i>
                        </a>
                    </div>
                    <div class="youtube-icon">
                        <a class="icons" href="https://www.youtube.com/channel/UCiEEF51uRAeZeCo8CJFhGWw/featured"
                            target="_blank">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>
                <table class="lower-table">
                    <tr>
                        <td nowrap class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ????????? ??????
                            </a></td>
                    </tr>
                    <tr>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ????????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????(IR)
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>

                    </tr>
                    <tr>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>
                        <td class="lower-table-td"><a class="lower-icon-hover">
                                ?????? ??????
                            </a></td>

                    </tr>
                    <tr>
                        <td class="lower-table-td"><a class="lower-icon-hover" aria-colspan="4">
                                ????????????
                            </a></td>
                    </tr>
                </table>
                <table class="lower-table-s">
                    <tr>
                        <td class="lower-table-s-td">
                            <a class="lower-hover">
                                ????????? ??????
                            </a>
                        </td>
                    </tr>
                </table>
                <div class="lower-text-contatin">
                    <p class="lower-text">
                        ????????????????????????????????? ???????????? ???????????????????????????: ???2018-????????????-0426??? ????????????: 080-001-9587
                    </p>
                    <p class="lower-text">
                        ??????: ???????????? ??? ?????????
                    </p>
                    <p class="lower-text">
                        ????????? ??????: korea@netflix.com
                    </p>
                    <p class="lower-text">
                        ??????: ???????????? ??????????????? ????????? ???????????? 26, ?????????????????? A??? 20??? ???????????? 03161
                    </p>
                    <p class="lower-text">
                        ?????????????????????: 165-87-00119
                    </p>
                    <p class="lower-text">
                        ???????????? ?????????: Amazon Web Services Inc.
                    </p>
                    <p class="lower-text">

                    </p>
                </div>
            </div>
        </div>
    </div>
    </div>




    <header>
        <div id="header" style="position: fixed; top:0; z-index: 3; background-image: linear-gradient(to bottom,rgba(0,0,0,.7) 10%,rgba(0,0,0,0));">
            <div class="header-list">
                <a href="netflix.jsp" target="_self">
                    <div class="logo"><img class="logo-image" src="images/logo.png"></div>
                </a>
                <ul class="tabbed-primary-navigation">
                    <li class="navigation-menu">
                        <a class="menu-trigger" role="button" aria-haspopup="ture" tabindex="0">??????</a>
                    </li>
                    <li class="navigation-tab">
                        <a style="color:white; pointer-events: none;" class="current-active" href="netflix.jsp"><b>???</b></a>
                    </li>
                    <li id="series-button" class="navigation-tab">
                        <a class="current-active" href="index1.jsp">?????????</a>
                    </li>
                    <li id="movie-button" class="navigation-tab">
                        <a class="current-active" href="netflixMovie.jsp">??????</a>
                    </li>
                    <li id="new-content-button" class="navigation-tab">
                        <a class="current-active">NEW!?????? ?????? ?????????</a>
                    </li>
                    <li id="dib-button" class="navigation-tab">
                        <a class="current-active" href="netflixDib.jsp">?????? ?????? ?????????</a>
                    </li>
                </ul>
                <div class="menu">
                    <div class="tab">
                        <form action="netflixSearch.jsp">
	                        <div class="nav-element">
	                            <div class="searchBox" style="margin-top: 8px; margin-left: 7px;">
	                                <div class="searchInput">
	                                    <!-- <svg style="margin-left: 6px;" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="search-icon">
	                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M13 11C13 13.7614 10.7614 16 8 16C5.23858 16 3 13.7614 3 11C3 8.23858 5.23858 6 8 6C10.7614 6 13 8.23858 13 11ZM14.0425 16.2431C12.5758 17.932 10.4126 19 8 19C3.58172 19 0 15.4183 0 11C0 6.58172 3.58172 3 8 3C12.4183 3 16 6.58172 16 11C16 11.9287 15.8417 12.8205 15.5507 13.6497L24.2533 18.7028L22.7468 21.2972L14.0425 16.2431Z" fill="currentColor"></path>
	                                    </svg> -->
	                                    <label for="searchInput" id="searchInput-label" class="visually-hidden"></label>
		                                <input class="focus-visible" style="outline: none; font-size: 15px; height: 12px; padding-bottom: 10px; border:0 solid black" autocomplete='off' type="text" id="searchInput" name="searchInput" placeholder="??????, ??????, ??????" data-search-input="true" dir="ltr" data-uia="search-box-input" aria-labelledby="searchInput-label" maxlength="80" value=""  data-focus-visible-added="" >
	                                    <div class="searchIcon">
	                                        <input class="searchTab" type="submit" value="" tabindex="0" aria-label="??????" data-uia="search-box-launcher">
	                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="search-icon">
	                                                <path fill-rule="evenodd" clip-rule="evenodd" d="M13 11C13 13.7614 10.7614 16 8 16C5.23858 16 3 13.7614 3 11C3 8.23858 5.23858 6 8 6C10.7614 6 13 8.23858 13 11ZM14.0425 16.2431C12.5758 17.932 10.4126 19 8 19C3.58172 19 0 15.4183 0 11C0 6.58172 3.58172 3 8 3C12.4183 3 16 6.58172 16 11C16 11.9287 15.8417 12.8205 15.5507 13.6497L24.2533 18.7028L22.7468 21.2972L14.0425 16.2431Z" fill="currentColor"></path>
	                                            </svg>
	                                        </input>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                        </form>
                        <!-- <button class="searchTab"><i class="fa-solid fa-magnifying-glass"></i></button> -->
                        <button class="notifications-item"><i class="fa-solid fa-bell"></i></button>
                        <div id="account-menu" style="width: 60px; cursor: pointer;">
                            <div class="account-menu-item"onclick="location.href='jspSY/Main.jsp'"><a class="login-profile">
                            <%
                            	/* int profileID = (int)(session.getAttribute("profileId"));
                            	System.out.print("profileID : " + profileID); */
                            	
                            	ArrayList <ProfileDTO> pList = pDao.viewProfile(profileID);
                            		for(ProfileDTO profile : pList){
                            %>
                                    <img style="width:30px;" class="login-profile-image"
                                        src="images/<%=profile.getProfileImg()%>"></a>
                            <% } %>           
                            </div>
                            <a class="profile-menu">
                                <i class="fas fa-sort-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="caret">
                        <role role="menu" tabindex="0" class="account-drop-down">
                            <div class="ptrack-content1">
                                <ul class="profiles">
                                	<%
                                	//????????? ???????????? ??????????????? ????????? ????????? ????????? ????????????
                                	
                                	
                                	/* ProfilesDao pDao = new ProfilesDao();
                                	ArrayList<ProfilesDto> pList = pDao.profiles(email);
                                	for(ProfilesDto pfDto : pList) { 
                                	conn = DBConnection.getConnection(); */
                            		ArrayList<ProfilesDto> profile = new ArrayList<ProfilesDto>();
                            		String sql ="select member_id, profile_id,nickname,profile_img from profile where profile_id=? order by profile_id";
                            		PreparedStatement pstmt = conn.prepareStatement(sql);
                            		pstmt.setInt(1, memberId); 
                            		/* pstmt.setString(1, email); */
                            		ResultSet rs = pstmt.executeQuery();
                            		
                            		while(rs.next()) {
                            			int profile_id = rs.getInt("profile_id");
                            			String nickname = rs.getString("nickname");
                            			String photo = rs.getString("profile_img");
                                	%>
                                    <li class="sub-menu-item-top" profileID="<%=profile_id%>" onclick="location.href ='jspSY/Main.jsp'">
                                        <div class="account-menu-item1"><a class="login-profile">
                                                <img style="width:34px;" class="sub-profile-image"
                                                    src="images/<%=photo%>"></a>
                                        </div>
                                        <span class="profile-name"><%=nickname %></span>
                                    </li>
                                    <%
                                	}
                                    %>
                                    <!-- <li class="sub-menu-item">
                                        <div class="account-menu-item1"><a class="login-profile">
                                                <img class="sub-profile-image"
                                                    src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/K6hjPJd6cR6FpVELC5Pd6ovHRSk/AAAABQJ0k9TCK_OsiG5fNh6aJCJHg3ljwC08BkulgTBgXPQm3HENI84hLCxJrE1WnG9oZDM15F4f2RBLH0Em-FXAcAW80T2mqCI.png?r=215"></a>
                                        </div>
                                        <span class="profile-name">?????????</span>
                                    </li>
                                    <li class="sub-menu-item">
                                        <div class="account-menu-item1"><a class="login-profile">
                                                <img class="sub-profile-image"
                                                    src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/K6hjPJd6cR6FpVELC5Pd6ovHRSk/AAAABbixeApBW3-Nl2SD40H-NBGKmv-eneU73h6hBcupBZNKnIWKbGO_18HrX2MQBnAL0_JYocPH62UHd58T1ZGF-l0Yoil7sHE.png?r=f71"></a>
                                        </div>
                                        <span class="profile-name">?????????</span>
                                    </li>
                                    <li class="sub-menu-item">
                                        <div class="account-menu-item1"><a class="login-profile">
                                                <img class="sub-profile-image"
                                                    src="https://occ-0-3077-988.1.nflxso.net/dnm/api/v6/K6hjPJd6cR6FpVELC5Pd6ovHRSk/AAAABSitqq49ifW_TwDbOmzmKBnxZ6bPnoiLbB9o9B9Ktw8BC7fe9trNQwyHiqhjKv1J_MzoiPVs9Zy37vkuV4g4QS1-k5SYCz4.png?r=f80"></a>
                                        </div>
                                        <span class="profile-name">?????????</span>
                                    </li> -->
                                    <li class="profile-link">
                                        <a class="sub-menu-link-icon" onclick="location.href='jspBR/p01.account.jsp?member=<%=(Integer)(session.getAttribute("member_id")) %>'">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                xmlns="http://www.w3.org/2000/svg"
                                                class="Hawkins-Icon Hawkins-Icon-Standard">
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                    d="M22.2071 7.79285L15.2071 0.792847L13.7929 2.20706L20.7929 9.20706L22.2071 7.79285ZM13.2071 3.79285C12.8166 3.40232 12.1834 3.40232 11.7929 3.79285L2.29289 13.2928C2.10536 13.4804 2 13.7347 2 14V20C2 20.5522 2.44772 21 3 21H9C9.26522 21 9.51957 20.8946 9.70711 20.7071L19.2071 11.2071C19.5976 10.8165 19.5976 10.1834 19.2071 9.79285L13.2071 3.79285ZM17.0858 10.5L8.58579 19H4V14.4142L12.5 5.91417L17.0858 10.5Z"
                                                    fill="currentColor"></path>
                                            </svg>
                                            <span class="profile-name">????????? ??????</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="account-container">
                                <ul class="account">
                                    <li class="account-information-top">
                                        <div class="account-information-item">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard"><path fill-rule="evenodd" clip-rule="evenodd" d="M9.00011 8C9.00011 6.34315 10.3433 5 12.0001 5C13.657 5 15.0001 6.34315 15.0001 8C15.0001 9.65685 13.657 11 12.0001 11C10.3433 11 9.00011 9.65685 9.00011 8ZM12.0001 3C9.23869 3 7.00011 5.23858 7.00011 8C7.00011 10.7614 9.23869 13 12.0001 13C14.7615 13 17.0001 10.7614 17.0001 8C17.0001 5.23858 14.7615 3 12.0001 3ZM5.98069 21.1961C6.46867 18.7563 8.61095 17 11.0991 17H12.9011C15.3893 17 17.5316 18.7563 18.0195 21.1961L19.9807 20.8039C19.3057 17.4292 16.3426 15 12.9011 15H11.0991C7.65759 15 4.69447 17.4292 4.01953 20.8039L5.98069 21.1961Z" fill="currentColor"></path></svg>
                                        </div>
                                        <span class="profile-name">??????</span>
                                    </li>
                                    <li id="sns" class="account-information">
                                        <div class="account-information-item">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="Hawkins-Icon Hawkins-Icon-Standard"><path fill-rule="evenodd" clip-rule="evenodd" d="M3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12ZM12 1C5.92487 1 1 5.92487 1 12C1 18.0751 5.92487 23 12 23C18.0751 23 23 18.0751 23 12C23 5.92487 18.0751 1 12 1ZM12 8.5C10.6831 8.5 10 9.24303 10 10H8C8 7.75697 10.0032 6.5 12 6.5C13.9968 6.5 16 7.75697 16 10C16 11.3487 14.9191 12.2679 13.8217 12.68C13.5572 12.7793 13.3322 12.9295 13.1858 13.0913C13.0452 13.2467 13 13.383 13 13.5V14H11V13.5C11 12.0649 12.1677 11.1647 13.1186 10.8076C13.8476 10.5339 14 10.1482 14 10C14 9.24303 13.3169 8.5 12 8.5ZM13.5 16.5C13.5 17.3284 12.8284 18 12 18C11.1716 18 10.5 17.3284 10.5 16.5C10.5 15.6716 11.1716 15 12 15C12.8284 15 13.5 15.6716 13.5 16.5Z" fill="currentColor"></path></svg>
                                        </div>
                                        <span class="profile-name">Net n Flix</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="logout-container">
                                <span class="logout-tab">?????????????????? ????????????</span>
                            </div>
                        </role>
                    </div>
                </div>
            </div>
        </div>
        <%--</div> --%>
    </header>
    <script>
    var swiper1 = new Swiper(".mySwiper", {
    	/* slidesPerView : 6, 
  	  slidesPerGroup : 6, */
  	  loop: true,
  	  speed:600,
  	  touchRatio: 0,
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      pagination: {
          el: '.swiper-pagination',
          type: 'progressbar',
          clickable: true,
        },
      observer: true,
	  observeParents: true,
    });
      var swiper2 = new Swiper(".mySwiper1", {
    	  /* slidesPerView : 6, 
    	  slidesPerGroup : 6, */
      	loop: true,
      	speed:600,
    	touchRatio: 0,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        pagination: {
          el: ".swiper-pagination",
          type: "progressbar",
        },
        observer: true,
		observeParents: true,
      }); 
      // ygygygyg
      var swiper3 = new Swiper(".mySwiper2", {
    	  slidesPerView : 6, 
    	  spaceBetween : 6,
    	  slidesPerGroup : 6,
      	  touchRatio: 0,
      	  loop: true,
      	  speed:600,
          navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
          },
          pagination: {
            el: ".swiper-pagination",
            type: "progressbar",
          },
          observer: true,
  		observeParents: true,
        });
      var swiper4 = new Swiper(".mySwiper3", {
    	  slidesPerView : 6, 
    	  spaceBetween : 6,
    	  slidesPerGroup : 6,
      	  touchRatio: 0,
    	  speed:600,
      	  loop: true,
          navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
          },
          pagination: {
            el: ".swiper-pagination",
            type: "progressbar",
          },
          observer: true,
  		observeParents: true,
        }); 
    </script>
</body>

</html>
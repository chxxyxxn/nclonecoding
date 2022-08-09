<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./js/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js" integrity="sha256-eTyxS0rkjpLEo16uXTS0uVCS4815lc40K2iVpWDvdSY=" crossorigin="anonymous"></script>
<script>
$(function() {
	
    let y = new Date();
    y.setDate(y.getDate()-1);
    let str = y.getFullYear() + "-"
    + ("0" + (y.getMonth() + 1)).slice(-2) + "-"
    + ("0" + y.getDate()).slice(-2);
    $("#date").attr("max",str);
    
    $("#mybtn").click(function() {
        let d = $("#date").val(); //YYYY-MM-DD
        const regex = /-/g;
        let d_str = d.replace(regex,"") // YYYYMMDD

        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=5328b84349af95da10e62a9cd56dc6a7&targetDt="+d_str
        // ajax로 json 데이터 가져오기
         $.getJSON(url, function(data) {
             let movieList = data.boxOfficeResult.dailyBoxOfficeList;
             $("div").empty(); // 두 번 클릭했을 때 기존 내용을 지워줌
             $("div").append(d+" 박스 오피스 순위<br>");
             for(let i in movieList){
                 $("div").append("<span id= '"+movieList[i].movieCd + "'>" +(parseInt(i)+1) + " " + movieList[i].movieNm + "</span><hr>" );
             } 
            });
    });
    
    $(document).on("click", "span", function(){ 
        var d = $(this);
        let movieCd = d.attr("id");
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=5328b84349af95da10e62a9cd56dc6a7&movieCd="+movieCd  // +movieCd;    // =20124079
        
        $.getJSON(url,function(res){
            let movie = res.movieInfoResult.movieInfo;
            d.append("<hr>");
            d.append("개봉일 : "+movie.openDt+"<br>");
            d.append("감독 : "+movie.directors[0].peopleNm+"<br>");
            d.append("주연 : "+movie.actors[0].peopleNm+", "+movie.actors[1].peopleNm+", "+movie.actors[2].peopleNm);
            d.append("<hr>");

        });
   		
   	});
});
</script>
<title>Insert title here</title>
</head>
<body>
	<input type="date" id="date"><button id="mybtn">확인</button>
	<div id="boxoffice">
	    박스 오피스 순위<br>
	</div>
</body>
</html>


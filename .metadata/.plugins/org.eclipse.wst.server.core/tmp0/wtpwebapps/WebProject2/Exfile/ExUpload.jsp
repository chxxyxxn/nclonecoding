<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="ExUploadServlet" method="post" enctype="multipart/form-data">
		설명 : <input type="text" name="desc"/>
		이미지 : <input type="file" name="file"/>
		<input type="submit" value="업로드"/>	
	</form>	
</body>
</html>




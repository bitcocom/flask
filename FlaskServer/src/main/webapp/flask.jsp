<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<title>요청 폼</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[type=button]").click(function() {
		 console.log()
		 var form = $("#fileUploadForm")[0];
		 var data = new FormData(form);
		 $("input[type=button]").prop("disabled", true);
		 $.ajax({
			 url : "http://127.0.0.1:5000/test_img",
			 async : true,
			 type : "POST",
			 data : data,
			 processData : false,
			 contentType : false,
			 cache : false,
			 timeout : 600000,
			 success : function(data) {
				 console.log(data)
				 $("#result").append("<img src='data:image/png;base64," + data.file + "'>");
				 $("input[type=button]").prop("disabled", true);
			 },
			 error : function(e) {
				 console.log("ERROR : ", e);
				 alert("fail");
			 }
		 });
		})
	});
</script> 
<form method="post" enctype="multipart/form-data" id="fileUploadForm">
	 데이터 : <input type="text" name="data" value="test hello"><p>
	 파일 : <input type="file" name="file"></p><p>
	 <input type="button" value=" 비동기 요청 ">
	 </p>
</form>
<div id="result">여기에 요청 결과가 출력되어야 합니다.</div>
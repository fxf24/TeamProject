<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<!-- FontAwesome-->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
		<!-- Bootstrap -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
			integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/jquery-3.2.1.min.js"></script>
		<script>
			$(document).ready(function () {
				var user = sessionStorage.getItem("user")
				sessionStorage.setItem("user", "admin")


				/////////////////////////
				var input = document.querySelector('input');
				input.style.opacity = 0;
				// 이미지 분석
				var button = document.querySelector('button');
				// button.style.opacity = 0;

				$("#fileUpload").on('click', function (event) {
					console.log(event);
					event.preventDefault()

					var form = $("#fileForm")[0]
					var formData = new FormData(form)
					formData.append("file", $("#selectedFile")[0].files[0])
					$.ajax({
						url: '/getODjson',
						type: 'post',
						data: formData,
						processData: false,
						contentType: false,
						success: function (response) {
							var responseSplit = response.split("|")
							var filename = responseSplit[0]
							var odjson = JSON.parse(responseSplit[1])
							var cfrjson = JSON.parse(responseSplit[2])

							//캔버스에 이미지 로드(canvas 태그 + canvas 자바스크립트 라이브러리)
							var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
							var context = imagecanvas.getContext("2d")
							console.log(imagecanvas.style);
							context.fillStyle = "red"
							context.font = '15px batang'
							context.strokeStyle = 'green'
							context.lineWidth = 3

							//이미지 로드
							var image = new Image()
							image.src = "/upload/" + filename
							image.onload = function () {
								context.drawImage(image, 10, 10, image.width, image.height)

								//od json
								var names = odjson.predictions[0].detection_names
								var confidence = odjson.predictions[0].detection_scores
								var boxes = odjson.predictions[0].detection_boxes

								//cfr json 
								//cfr json 
								//cfr json 
								var faces = cfrjson.faces
								var faces = cfrjson.faces
								var faces = cfrjson.faces

								for (var i = 0; i < names.length; i++) {
									//if(confidence[i]>=0.9){
									var y1 = boxes[i][0] * image.height
									var x1 = boxes[i][1] * image.width
									var y2 = boxes[i][2] * image.height
									var x2 = boxes[i][3] * image.width

									if (!(names[i] == "person")) {
										//이름 : 00% 출력
										context.fillText(names[i] + " : " + parseInt(confidence[i] * 100) + "%", x1 + 10, y1 + 10)

										//사각형 그려서 출력
										context.strokeRect(x1 + 10, y1 + 10, x2 - x1, y2 - y1)
										$("#hashtags").append("<a href='https://search.shopping.naver.com/search/all?query=" + names[i] + "&cat_id=&frm=NVSHATC'>#" + names[i] + " </a>")
									}

									//}//if end
								}//for end

								//cfr데이터를 해쉬태그로 추가해주기
								for (var i = 0; i < faces.length; i++) {
									var celebrity = faces[i].celebrity.value
									var confidence = faces[i].celebrity.confidence

									if (confidence > 0.5) {
										$("#hashtags").append("<a href='https://search.shopping.naver.com/search/all?query=" + celebrity + "&cat_id=&frm=NVSHATC'>#" + celebrity + " </a>")
									}//if end
								}//for end

							}//image onload end
						},
						error: function (response) {
							alert("사진아이콘을 눌러 사진을 선택 후, 분석을 해주세요")
						}
					})
				})//fileUpload onclick end
			})//document ready end

			function saveImage() {
				var $canvas = document.getElementById('imagecanvas');
				var imgDataUrl = $canvas.toDataURL('image/png', 1.0)

				var blobBin = atob(imgDataUrl.split(',')[1]);	// base64 데이터 디코딩
				var array = [];
				for (var i = 0; i < blobBin.length; i++) {
					array.push(blobBin.charCodeAt(i));
				}
				var file = new Blob([new Uint8Array(array)], { name: '$("#selectedFile")[0].files[0]', type: 'image/png' });	// Blob 생성
				var formdata = new FormData();	// formData 생성
				var fileValue = $("#selectedFile").val().split("\\");
				var fileName = fileValue[fileValue.length - 1];

				formdata.append("file", file, fileName);	// file data 추가

				$.ajax({
					type: 'post',
					url: '/saveImage',
					data: formdata,
					processData: false,	// data 파라미터 강제 string 변환 방지!!
					contentType: false,	// application/x-www-form-urlencoded; 방지!!
					success: function (response) {
						console.log(response.data)
					}

				});

				console.log($("#hashtags").html())

				var user = sessionStorage.getItem("user")
				
				$.ajax({
					type: 'post',
					url: '/saveData',
					data: {
						'id': user, 'content': $("#contents").val(), 'image': fileName,
						'hashtag': $("#hashtags").text() + $("#names").val()
					},
					dataType: 'json',

					success: function (response) {
						console.log(response.data)
						location.href = "/"
					},

					error: function (request, status, error) {
						alert("success에 실패 했습니다.");
						console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				})
			}
			// 글자수 최대 3000자로 제한
			$(function () {
				$('textarea[maxlength]').keyup(function (event) {
					var max = parseInt($(this).attr("maxlength"));
					if ($(this).val().length >= max) {
						alert("글자수를 초과하였습니다");
					}
				});
			})
			function resize(obj){
				obj.style.height = "5px";
				obj.style.height = obj.scrollHeight+"px";
// 				console.log(obj.style.height)
			}
		</script>
	</head>
	<style>
		*{
			margin: 0%;
			padding: 0;
		}
		body {
			padding-top: 50px;
		}
	</style>

	<body>
		<div class="container">
			<div class="row">
				<form id="fileForm" method=post enctype="multipart/form-data" class="col-4">
					<canvas id="imagecanvas" width=400 height=400 style="border: 2px solid pink"></canvas>
					<div>
						<button id="fileUpload">이미지 분석</button>
						<label for="selectedFile"><i class="far fa-images fa-2x"></i></label>
						<input id="selectedFile" type="file" name="file"><br>
					</div>
					<h5>해쉬태그 입력</h5>
					<div id="hashtags"></div>
					<input id="names" type="text">
				</form>
				<div class="col-1"></div>
				<form class="col-6">
					내용 입력<br>
					<textarea maxlength="3000" id="contents" cols="100" onkeydown="resize(this)" onkeyup="resize(this)" style="min-height: 150px;" ></textarea><br>
					<button id="postUpload" onclick="saveImage()" class="btn btn-primary">작성</button>
				</form>
			</div>
		</div>
	</body>

	</html>
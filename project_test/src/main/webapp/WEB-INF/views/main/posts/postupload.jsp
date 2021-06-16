<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="Pragma" content="no-cache" />
    <title>postupload</title>
</head>
<style>
#postupload {
    background-color: rgba(244, 238, 238, 1);
}
</style>

<body>
	<div id="postupload">
		<div class="container pt-5">
			<form id="fileForm"	method=post enctype="multipart/form-data" class="">
				<canvas id="imagecanvas" width="600" height="400" class="rounded d-block mx-auto" style="border: 2px solid pink"></canvas>
				<button type=button id="fileUpload">이미지 분석</button>
				<label for="selectedFile">
					<i class="far fa-images fa-2x"></i>
				</label>
				<input id="selectedFile" type="file" name="file"></button>
			</form>
			<div class="postupload__body">
				<h5>해쉬태그 입력</h5>
				<div id="hashtags"></div>
				<input id="hash_names" type="text" placeholder="#뒤에 공백 작성 불가능합니다.">
			</div>
			<form>
				<h5 class>내용 입력</h5>
				<textarea maxlength="3000" id="contents" cols="100" onkeydown="resize(this)"style="min-height: 150px;" ></textarea><br>
				<div id="sysdate"><%=sf.format(nowTime)%></div>
				<button type="button" id="postUpload" onclick="saveImage()" class="btn btn-primary">작성</button>
			</form>
		</div>
	</div>
</body>
<script>
    $(document).ready(function () {
        var user = sessionStorage.getItem("user")
        $("#fileUpload").on('click', function (event) {
            event.preventDefault()
            var input = document.querySelector('input');
            input.style.opacity = 0;
            // 이미지 분석
            var button = document.querySelector('button');
            // button.style.opacity = 0;
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

                    //이미지 로드
                    var image = new Image()
                    image.src = "/upload/" + filename

                    image.onload = function() { //(하은)
                        var width = image.width;
                        var height = image.height;

                        imagecanvas.width = image.width
                        imagecanvas.height = image.height

                        var context = imagecanvas.getContext("2d")
                        context.fillStyle = 'red'
                        context.font = '15px batang'
                        context.strokeStyle = '#008000'
						console.log(context)
                        context.lineWidth = 1

                        context.drawImage(image, 0, 0, width, height)
                        //od json
                        var names = odjson.predictions[0].detection_names
                        var confidence = odjson.predictions[0].detection_scores
                        var boxes = odjson.predictions[0].detection_boxes
                        //cfr json 
                        var faces = cfrjson.faces
                        for (var i = 0; i < names.length; i++) {
                            var y1 = boxes[i][0] * height
                            var x1 = boxes[i][1] * width
                            var y2 = boxes[i][2] * height
                            var x2 = boxes[i][3] * width
                            if (!(names[i] == "person")) {
                                //이름 : 00% 출력
                                context.fillText(names[i] + " : " + parseInt(confidence[i] * 100) + "%", x1, y1)
                                //사각형 그려서 출력
                                context.strokeRect(x1, y1, x2 - x1, y2 - y1)
                                $("#hashtags").append("<a href='https://search.shopping.naver.com/search/all?query=" + names[i] + "&cat_id=&frm=NVSHATC'>#" + names[i] + " </a>")
                            }//if end
                        }//for end
                        //cfr데이터를 해쉬태그로 추가해주기
                        for (var i = 0; i < faces.length; i++) {
                            var celebrity = faces[i].celebrity.value
                            var confidence = faces[i].celebrity.confidence
                            if (confidence > 0.5) {
                                $("#hashtags").append("<a href='https://search.shopping.naver.com/search/all?query=" + celebrity + "&cat_id=&frm=NVSHATC'>#" + celebrity + " </a>")
                            } //if end
                        } //for end
                    }//image onload end
                },//success end

                error: function (response) {
                    alert("사진아이콘을 눌러 사진을 선택 후, 분석을 해주세요")
                }//error end
            })//ajax end
        }) //fileUpload onclick end
    }) //document ready end

    function saveImage() {
        var user = sessionStorage.getItem("user")

        if (user == null) {
            if (confirm("로그인해주세요!")) {
                location.href = "/login"
            }
        } else {
            var $canvas = document.getElementById('imagecanvas');
            var imgDataUrl = $canvas.toDataURL('image/png', 1.0)
            var blobBin = atob(imgDataUrl.split(',')[1]); // base64 데이터 디코딩
            var array = [];
            for (var i = 0; i < blobBin.length; i++) {
                array.push(blobBin.charCodeAt(i));
            }
            var file = new Blob([new Uint8Array(array)], {
                name: '$("#selectedFile")[0].files[0]',
                type: 'image/png'
            }); // Blob 생성					
            var formdata = new FormData(); // formData 생성
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
            });//saveImage ajax end
            console.log($("#hashtags").text())
            $.ajax({
                type: 'post',
                url: '/saveData',
                data: {
                    'id': user,
                    'content': $("#contents").val(),
                    'image': fileName,
                    'hashtag': $("#hashtags").text() + $("#hash_names").val()
                },
                dataType: 'json',
                success: function (response) {
                    location.href = "/"
                },
                error: function (request, status, error) {
                    alert("success에 실패 했습니다.");
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })//saveData ajax end
        }//else end

    }//saveImage() end
    // 글자수 최대 3000자로 제한
    $(function () {
        $('textarea[maxlength]').keyup(function (event) {
            var max = parseInt($(this).attr("maxlength"));
            if ($(this).val().length >= max) {
                alert("글자수를 초과하였습니다");
            }
        });
    })

    function resize(obj) {
        obj.style.height = "2em";
        obj.style.height = obj.scrollHeight + "px";
		obj.scrollHeight += "1em";
    }
	let $hash_names= document.getElementById("hash_names");
	let $word = "";
    const spaceWord = (event) => {
		// $word += event.target.value
        if (event.keyCode === 32) {
			if ($word=="") {
	           
			} else {
 				$hash_names.value += " #";
				$word = "";
			}
        }
		else {
			$word += String.fromCharCode(event.keyCode);
		}
		// console.log($word)
    }
    const addHash = () => {
        if ($hash_names.value=="") {
            $hash_names.value = "#";
        }
    }
    $hash_names.addEventListener("keyup", spaceWord);
    $hash_names.addEventListener("click", addHash);
</script>

</html>

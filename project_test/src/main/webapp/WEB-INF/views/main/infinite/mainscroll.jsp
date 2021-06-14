<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="author"/>
	<meta name="viewport" content="width=device-width">
	<title>Infinite Scroll</title>
	<link href='styles/messages.css' rel='stylesheet' type='text/css'>
</head>
<body>
	<div id="templates">
		<div id= mainBarBox>
			<div class="card__main chat-item" data-id="{{id}}">
				<div class="bubble">
					<div class ="main__right">
						<i class="far fa-eye-slash">Invisible</i>
						<i class="fas fa-share-alt">Share</i>
						<i class="fas fa-bell">Report</i>
						<svg class="plusBoxIcon" viewBox="10 4 8 32">
							<path id="plusBoxIcon" d="M 13.99999904632568 12.00000095367432 C 16.19999885559082 12.00000095367432 17.99999809265137 10.20000171661377 17.99999809265137 8.000000953674316 C 17.99999809265137 5.799999713897705 16.19999885559082 4 13.99999904632568 4 C 11.79999923706055 4 9.999999046325684 5.799999713897705 9.999999046325684 8.000000953674316 C 9.999999046325684 10.20000171661377 11.79999923706055 12.00000095367432 13.99999904632568 12.00000095367432 Z M 13.99999904632568 16.00000190734863 C 11.79999923706055 16.00000190734863 9.999999046325684 17.80000114440918 9.999999046325684 20.00000381469727 C 9.999999046325684 22.20000267028809 11.79999923706055 24.00000381469727 13.99999904632568 24.00000381469727 C 16.19999885559082 24.00000381469727 17.99999809265137 22.20000267028809 17.99999809265137 20.00000381469727 C 17.99999809265137 17.80000114440918 16.19999885559082 16.00000190734863 13.99999904632568 16.00000190734863 Z M 13.99999904632568 28.00000381469727 C 11.79999923706055 28.00000381469727 9.999999046325684 29.80000495910645 9.999999046325684 32.00000381469727 C 9.999999046325684 34.20000076293945 11.79999923706055 36 13.99999904632568 36 C 16.19999885559082 36 17.99999809265137 34.20000076293945 17.99999809265137 32.00000381469727 C 17.99999809265137 29.80000495910645 16.19999885559082 28.00000381469727 13.99999904632568 28.00000381469727 Z" />
						</svg>
						<svg class="favoriteIcon1" viewBox="2 3 30 27">
							<path id="favoriteIcon1" d="M 17 30 L 14.824997 28.057767 C 7.0999984 21.186378 2 16.654495 2 11.092643 C 2 6.5607643 5.6299982 2.9999997 10.249997 2.9999997 C 12.859997 2.9999997 15.364994 4.1918258 16.999996 6.0752062 C 18.634998 4.1918258 21.139997 2.9999997 23.749998 2.9999997 C 28.369993 2.9999997 31.999998 6.5607643 31.999998 11.092643 C 31.999998 16.654495 26.89999 21.18638 19.174995 28.072484 L 16.999996 30.000001 Z" />
						</svg>
						<svg class="favoriteIcon2" viewBox="2 3 30 27">
							<path id="favoriteIcon2" d="M 17 30 L 14.824997 28.057767 C 7.0999984 21.186378 2 16.654495 2 11.092643 C 2 6.5607643 5.6299982 2.9999997 10.249997 2.9999997 C 12.859997 2.9999997 15.364994 4.1918258 16.999996 6.0752062 C 18.634998 4.1918258 21.139997 2.9999997 23.749998 2.9999997 C 28.369993 2.9999997 31.999998 6.5607643 31.999998 11.092643 C 31.999998 16.654495 26.89999 21.18638 19.174995 28.072484 L 16.999996 30.000001 Z" />
						</svg>
						<svg class="favoriteIcon3" viewBox="2 3 30 27">
							<path id="favoriteIcon3" d="M 17 30 L 14.824997 28.057767 C 7.0999984 21.186378 2 16.654495 2 11.092643 C 2 6.5607643 5.6299982 2.9999997 10.249997 2.9999997 C 12.859997 2.9999997 15.364994 4.1918258 16.999996 6.0752062 C 18.634998 4.1918258 21.139997 2.9999997 23.749998 2.9999997 C 28.369993 2.9999997 31.999998 6.5607643 31.999998 11.092643 C 31.999998 16.654495 26.89999 21.18638 19.174995 28.072484 L 16.999996 30.000001 Z" />
						</svg>
						<svg class="invisibleIcon" viewBox="1 3 40 30">
							<path id="invisibleIcon" d="M 21.009094 9.3157882 C 26.02956 9.3157882 30.104137 12.852629 30.104137 17.210527 C 30.104137 18.236843 29.867666 19.200000 29.449291 20.100000 L 34.760799 24.710527 C 37.507503 22.721052 39.672122 20.147369 41.000003 17.210527 C 37.853118 10.278946 30.085947 5.3684215 20.990903 5.3684215 C 18.444292 5.3684215 16.00682 5.7631578 13.751249 6.4736838 L 17.680309 9.8842096 C 18.717144 9.5210514 19.82674 9.3157882 21.009094 9.3157882 Z M 2.8190088 5.0052638 L 6.9663476 8.6052627 L 7.8030924 9.3315782 C 4.7835378 11.36842 2.4188265 14.08421 1 17.210527 C 4.1468849 24.142105 11.914052 29.052631 21.009094 29.052631 C 23.828557 29.052631 26.52069 28.578948 28.976354 27.726316 L 29.740337 28.389472 L 35.07003 33 L 37.380176 30.994735 L 5.1291499 3 L 2.8190088 5.0052638 Z M 12.878126 13.736841 L 15.697589 16.184213 C 15.606637 16.51579 15.552068 16.863159 15.552068 17.210527 C 15.552068 19.831579 17.98954 21.947368 21.009094 21.947368 C 21.409276 21.947368 21.809457 21.900001 22.191448 21.821052 L 25.010913 24.268419 C 23.792177 24.789472 22.446109 25.105264 21.009094 25.105264 C 15.988630 25.105264 11.914052 21.568422 11.914052 17.210527 C 11.914052 15.963158 12.277852 14.794735 12.878125 13.736841 Z M 20.718051 12.505263 L 26.447931 17.478948 L 26.48431 17.226318 C 26.48431 14.605262 24.046838 12.489472 21.027284 12.489472 L 20.718051 12.505263 Z" />
						</svg>
						<svg class="shareIcon" viewBox="665.063 -170.939 27 30">
							<path id="shareIcon" d="M 687.5629882 -149.733871 C 686.4226684 -149.733871 685.4030151 -149.282058 684.6227416 -148.574523 L 673.9279785 -154.823928 C 674.0026855 -155.170913 674.0629882 -155.516998 674.0629882 -155.878448 C 674.0629882 -156.239883 674.0026855 -156.585968 673.9279785 -156.932968 L 684.5030517 -163.122726 C 685.3129272 -162.369110 686.3776245 -161.902847 687.5629882 -161.902847 C 690.0532836 -161.902847 692.0629882 -163.920608 692.0629882 -166.420913 C 692.0629882 -168.920318 690.0532836 -170.93898 687.5629882 -170.93898 C 685.0726928 -170.93898 683.0629272 -168.920318 683.0629272 -166.420913 C 683.0629272 -166.059478 683.1232910 -165.712478 683.1979980 -165.366409 L 672.6229858 -159.176635 C 671.8129882 -159.929351 670.7482910 -160.396530 669.5629882 -160.396530 C 667.0727539 -160.396530 665.0629882 -158.378753 665.0629882 -155.878448 C 665.0629882 -153.378143 667.0727539 -151.360382 669.5629882 -151.360382 C 670.7482910 -151.360382 671.8129882 -151.827545 672.6229858 -152.580245 L 683.3032836 -146.31549 C 683.2276 -145.999237 683.1826171 -145.667602 683.1826171 -145.335968 C 683.1826171 -142.911575 685.1482543 -140.938995 687.5629882 -140.938995 C 689.9776611 -140.938995 691.9432983 -142.911575 691.9432983 -145.335968 C 691.9432983 -147.761276 689.9776611 -149.733871 687.5629882 -149.733871 Z" />
						</svg>
						<div id="reportPBoxIcon">
							<svg class="reportIcon1" viewBox="12 -0.21 28 18">
								<path id="reportIcon1" d="M 22.3199997 -0.21 L 29.6800003 -0.21 C 32.1432991 0.250935703 34.01918792 1.337349176 35.88377761 3.379324436 C 38.56800842 6.245957374 39.5890007 11.782692 40 17.79000282 L 12 17.79000282 C 12.54000091 8.866735458 15.8244629 0.936089396 22.3199997 -0.21 Z" />
							</svg>
							<svg class="reportIcon2">
								<rect id="reportIcon2" rx="0" ry="0" x="0" y="0" width="40" height="6" />
							</svg>
							<svg class="reportIcon3">
								<ellipse id="reportIcon3" rx="3" ry="3" cx="3" cy="3" />
							</svg>
							<svg class="reportIcon4" viewBox="0 0 12 1">
								<path id="reportIcon4" d="M 0 0 L 12 0" />
							</svg>
						</div>
						<div id="invisibleFont">
							<span>INVISIBLE</span>
						</div>
						<div id="notinterestedFont">
							<span>not interested</span>
						</div>
						<div id="shareFont">
							<span>SHARE</span>
						</div>
						<div id="reportFont">
							<span>REPORT</span>
						</div>
					</div> <!-- main__right -->
					
					<!-- 아이디 표시 위치 -->
					<span class="hashId fs-4 align-middle "></span>
					<!-- 시간 위치 -->
					<div class="posted-date"></div>
					<!-- 이미지 위치 -->
					<div class="d-flex justify-content-center">
						<img id="postImage" class="card__img">
					</div>
					<div class="card__updown">
						<i class="fas fa-chevron-up"></i>
						<i class="fas fa-chevron-down"></i>
						<i class="fas fa-heart"></i>
						<i class="fas fa-ellipsis-v"></i>
						<div class="dropdown">
							<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
								Dropdown button
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#">Action</a></li>
								<li><a class="dropdown-item" href="#">Another action</a></li>
								<li><a class="dropdown-item" href="#">Something else here</a></li>
							</ul>
						</div>
					</div>
					<div id="card__body">
						<!-- 해시태그 위치 -->				
						<div class="hashtag m-3"></div>
						<!--게시물 내용 위치-->
						<div class="card__content"></div>
					</div>
				</div> <!-- bubble 종료 -->
			</div>
		</div>
	
		<div class="chat-item tombstone" data-id="{{id}}">
			<div class="bubble__tombstone" >
				<div class ="plusBox"></div>
				<p></p>
			</div>
		</div>
	</div>
	<!-- 여기가 infinite-scroll을 생성 -->
	<div id="chat-timeline"></div>
</body>

<script src="es6-promise.js"></script>
<script src="stats.min.js"></script>
<script src="scripts/infinite-scroll.js"></script>
<script src="scripts/messages.js"></script>
<script>
	var user = sessionStorage.getItem("user") //프로필 연결용 세션 유지 (하은)
	
	var list = []
	$.ajax({
			url :"/showposts",
			type : "post",
			data : {"user" : user},
			dataType : "json",
			success : function(response){
				list = response
				console.log(user)
				console.log(list)
				console.log(list[0].id)
			}, // success end
			error : function(e){
					console.log(e);
			} // error end
	}); // ajax end		
	var INIT_TIME = new Date().getTime();
	const random1 = Math.floor(Math.random()*18);// 총 데이터 갯수, 현재 image0 ~19가 있음
	/**
	 * Constructs a random item with a given id.
	 * @param {number} id An identifier for the item.
	 * @return {Object} A randomly generated item.
	 */
	function getItem(id) {
		function pickRandom(a) {
			return a[Math.floor(Math.random() * a.length)];
		}

	/* 데이터 랜덤 전송위치 */
	
		return new Promise(function(resolve) {
			var item = {
			id: list[id].id,
			self: Math.random() < 0.1,
			image: list[id].imagepath,
			time: list[id].postDate,
			message: list[id].contents,
			hashtag: list[id].hashtag
			}
			if(item.image == '') {
			resolve(item);
			item.image = random1
			}
			var image = new Image();
			image.src = '/upload/'  + item.image;
			image.addEventListener('load', function() {
			item.image = image;
			resolve(item);
			});
			image.addEventListener('error', function() {
			item.image = '';
			resolve(item);
			});
		});

	}
	
	
	function ContentSource() {
		// Collect template nodes to be cloned when needed.
		this.tombstone_ = document.querySelector("#templates > .chat-item.tombstone");
		this.messageTemplate_ = document.querySelector("#templates >#mainBarBox > .chat-item:not(.tombstone)");
		this.nextItem_ = 0;
	}

	ContentSource.prototype = {
		fetch: function(count) {
			// Fetch at least 30 or count more objects for display.
			count = Math.max(30, count);
			return new Promise(function(resolve, reject) {
			// Assume 50 ms per item.
			setTimeout(function() {
				var items = [];
				for (var i = 0; i < list.length; i++) {
				items[i] = getItem(i);
				}
				resolve(Promise.all(items));
			}.bind(this), 1000 /* Simulated 1 second round trip time */ );
			}.bind(this));
		},

		createTombstone: function() {
			return this.tombstone_.cloneNode(true);
		},

		render: function(item, div) {
			// TODO: Different style?
			div = div || this.messageTemplate_.cloneNode(true);
			div.querySelector('.hashId').textContent = item.id;
			div.querySelector('.card__content').textContent = item.message;
			div.querySelector('.posted-date').textContent = item.time;
			var hashtags = div.querySelector('.hashtag');
			var hashtagSplit = item.hashtag.split("#");
			for(var i = 1; i < hashtagSplit.length; i++){
				hashtags.innerHTML += "<a href='https://search.shopping.naver.com/search/all?query="
					+hashtagSplit[i]+"&cat_id=&frm=NVSHATC'>#"+hashtagSplit[i]+" </a>";
			}
			
			//image 설정
			var img = div.querySelector('.card__img');
			if(item.image !== '') {
			img.classList.remove('invisible');
			img.src = item.image.src;
			img.style.minWidth = '30em';
			img.style.maxWidth = '50em';
			img.style.height = 'auto';
			// img.width = item.image.width;
			// img.height = item.image.height;
			} else {
			img.src = '';
			img.classList.add('invisible');
			}
		
			if(item.self) {
			div.classList.add('from-me');
			} else {
			div.classList.remove('from-me');
			}
			return div;
		},

	};

	function numDomNodes(node) {
		if(!node.children || node.children.length == 0)
			return 0;
		var childrenCount = Array.from(node.children).map(numDomNodes);
		return node.children.length + childrenCount.reduce(function(p, c){ return p + c; }, 0);
		}

		document.addEventListener('DOMContentLoaded', function() {
		window.scroller =
			new InfiniteScroller(
			document.querySelector('#chat-timeline'),
			new ContentSource()
			);

	});
	</script>
</html>
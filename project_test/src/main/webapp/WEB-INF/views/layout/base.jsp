<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <!-- Bootstrap -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
            <!-- FontAwesome -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
            <!-- Google Fonts -->
            <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
            <!-- JavaScript Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
            <!-- jquery -->
            <script src="/jquery-3.2.1.min.js"></script>
            
        </head>
        <style>
            .header_indent {
                /* margin: 5em; */
            }
        </style>

        <body>

            <tiles:insertAttribute name="header" />
            <div class="header_indent"></div>
            <div class="border border-primary m-5">위에 위치한 빈공간은 다른 작업에 방해되지 않도록 띄운 공간입니다. 나중에 삭제할 예정</div>
            <tiles:insertAttribute name="body" />
            <!-- <meta http-equiv="refresh" content="0; url=/" /> -->
          	<tiles:insertAttribute name="right" />
<!--             <div class="border border-primary m-5"> -->
<!--                 이 부분은 나중에 아래가 아닌 오른쪽으로 옮겨서 팔로우 목록, 추천 목록 등을 표시할 예정 -->
<!--             </div>  -->
        </body>

        </html>

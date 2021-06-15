<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <!-- CSS only -->
    </head>
    <style scoped>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }
        
        /* 초기 navbar*/
        #navbar {
            overflow: hidden;
            background-color: #f1f1f1;
            padding: 20px 10px;
            transition: 0.5s;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 99;
        }
        
        /* 아이콘 스타일 */
        #navbar a {
            float: left;
            color: ivory;
            text-align: center;
            padding: 1em 2em;
            text-decoration: none;
            font-size: 12px;
            line-height: 25px;
            border-radius: 4px;
        }
        
        /* 아이콘 마우스 올릴 시 */
        #navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        #navbar-right {
            float: right;
            margin-top: 0.4em;
            /* align-content: center 넣고싶은데 안돼서 대체함 */
            margin-right: 5em;
        }

        @media screen and (max-width: 580px) {
            #navbar {
                padding: 20px 10px !important;
            }

            #navbar a {
                float: none;
                display: block;
                text-align: left;
            }

            #navbar-right {
                float: none;
            }
        }

        .logo-image {
            width: 13em;
            margin-left: 10em;
        }

        .header_navbar {
            background-color: black !important;
        }
    </style>

    <body>
        <div id="navbar" class="header_navbar align-self-center">
            <div class="d-flex bd-highlight">
                <a href="/" class="me-auto">
                    <img class="logo-image" src="/loginimage/logo.png" alt="">
                </a>
                <div id="navbar-right">
                    <a href="/search"><i class="fas fa-search fa-3x"></i></a>
                    <a href="/postupload"><i class="fas fa-pen fa-3x"></i></a>
                    <a href="/profile"><i class="fas fa-user-circle fa-3x"></i></a>
                </div>
            </div>
        </div>
        <script>
            window.onscroll = function () { scrollFunction() };

            function scrollFunction() {
                if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
                    document.getElementById("navbar").style.padding = "5px 10px";
                } else {
                    document.getElementById("navbar").style.padding = "20px 10px";
                }
            }
        </script>
    </body>

    </html>

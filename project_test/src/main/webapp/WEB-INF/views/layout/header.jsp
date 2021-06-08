<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="EUC-KR">
        <title>Insert title here</title>
        <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    </head>
    <style scoped>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        #navbar {
            overflow: hidden;
            background-color: #f1f1f1;
            padding: 20px 10px;
            transition: 0.4s;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 99;
        }

        #navbar a {
            float: left;
            color: ivory;
            text-align: center;
            padding: 1px 5px;
            text-decoration: none;
            font-size: 12px;
            line-height: 25px;
            border-radius: 4px;
        }

        #navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        #navbar a.active {
            background-color: dodgerblue;
            color: white;
        }

        #navbar-right {
            float: right;
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
            width: 10em;
        }
        .header_navbar {
            background-color: black !important;
        }
    </style>

    <body>
        <div id="navbar" class = "header_navbar">
            <div class="d-flex bd-highlight mb-3">
                <a href="" class="me-auto">
                    <img class="logo-image" src="/loginimage/logo.png" alt="">
                </a>
                <div id="navbar-right">
                    <a class="active" href="/search">Search</a>
                    <a href="/postupload">±Û¾²±â</a>
                    <a href="#about">Profile</a>
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

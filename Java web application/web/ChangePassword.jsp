<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/login_style.css">
        <!--===============================================================================================-->

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

    </head>
    <body>

        <div class="limiter">
            <div class="container-login100" style="background-image: url('images/banner.jpg');">
                <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">

                    <form class="login100-form validate-form"  class="form__login" action="ChangePasswordServlet" method="POST">
                        <input  type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <span class="login100-form-title p-b-49">
                            Đổi mật khẩu
                        </span>

                        <div class="wrap-input100 validate-input m-b-23" data-validate = "Cần điền mật khẩu hiện tại">
                            <span class="label-input100">Mật khẩu hiện tại</span>
                            <input class="input100"  type="password"  name="currentPassword"  placeholder="Mật khẩu hiện tại"  required>
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>

                        <div class="wrap-input100 validate-input m-b-23" data-validate = "Cần điền mật khẩu mới">
                            <span class="label-input100">Mật khẩu mới</span>
                            <input class="input100"  type="password"  name="newPassword"  placeholder="Mật khẩu mới"  required>
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>

                        <div class="wrap-input100 validate-input m-b-23" data-validate = "Cần nhập lại mật khẩu mới">
                            <span class="label-input100">Nhập lại mật khẩu</span>
                            <input class="input100"  type="password"  name="confirmPassword"  placeholder="Nhập lại mật khẩu"  required>
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>

                        <div class="text-left p-t-8 p-b-31" style="color: red">
                            ${errorMessage}
                        </div>  

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn">
                                    Xác nhận
                                </button>
                            </div>
                        </div>



                    </form>


                </div>
            </div>
        </div>


        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/login_js.js"></script>


    </body>
</html>            


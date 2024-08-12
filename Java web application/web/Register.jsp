<%-- 
    Document   : Register
    Created on : May 23, 2024, 9:55:38 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
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
    </head>

    <body>

        <div class="limiter">
            <div class="container-login100" style="background-image: url('images/banner.jpg');">
                <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
                    <form class="login100-form validate-form" action="register" method="post" class="form__login">
                        <span class="login100-form-title p-b-49">
                            Register
                        </span>

                        <div class="wrap-input100 validate-input m-b-23" data-validate="Bắt buộc điền">
                            <span class="label-input100">Nickname</span>
                            <input class="input100" type="text" name="name" value="${name}"
                                   placeholder="Nickname" maxLength="40">
                            <span class="focus-input100" data-symbol="&#xf206;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Email</span>
                            <input class="input100" type="text" name="email" value="${email}"
                                   placeholder="Email">
                            <span class="focus-input100" data-symbol="&#9993;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Mật khẩu</span>
                            <input class="input100" type="password" name="password" value="${password}"
                                   placeholder="Mật khẩu">
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>
                        
                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Nhập lại mật khẩu</span>
                            <input class="input100" type="password" name="passwordRepeat" value=""
                                   placeholder="Nhập lại mật khẩu">
                            <span class="focus-input100" data-symbol="&#xf190;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Số điện thoại</span>
                            <input class="input100" type="text" name="phone" value=""
                                   placeholder="Số điện thoại">
                            <span class="focus-input100" data-symbol="&#x1F57F;"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Giới tính</span><br>


                            <input type="radio" id ="gender" name="gender" value="0" checked>Nam
                            <input type="radio" id ="gender" name="gender" value="1">Nữ
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Bắt buộc điền">
                            <span class="label-input100">Ngày sinh</span><br>
                            <input type="date" id ="dob" name="dob" value="" min="1900-01-01" max="">
                            <script>
                                // Get the current date
                                var today = new Date();

                                // Format the date as yyyy-mm-dd
                                var dd = String(today.getDate()).padStart(2, '0');
                                var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
                                var yyyy = today.getFullYear();

                                var formattedToday = yyyy + '-' + mm + '-' + dd;

                                // Set the value of the date input to the current date
                                document.getElementById('dob').value = formattedToday;
                                document.getElementById('dob').max = formattedToday;
                            </script>

                        </div>


                        <div class="text-left p-t-8 p-b-31" style="color: red">
                            <a>
                                ${requestScope.err}
                            </a>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn">
                                    Đăng ký
                                </button>
                            </div>
                        </div>

                        <div class="flex-col-c p-t-155">
                            <span class="txt1 p-b-17">
                                Hoặc đang nhập
                            </span>

                            <a href="login" class="txt2">
                                Đăng nhập
                            </a>
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
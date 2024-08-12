<%-- 
    Document   : profile
    Created on : Oct 6, 2023, 8:56:51 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suga</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
    <!-- css -->
    <link rel="stylesheet" href="./assests/css/main.css">
    <link rel="stylesheet" href="./assests/css/base.css">
    <link rel="stylesheet" href="./assests/css.profile/profile.css">

    <!-- font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

    <!-- icon title -->
    <link rel="icon" type="image/x-icon" href="./assests/img/cat-icon-title.ico">
    <!-- boostrap -->
    <link href="./assests/boostrap/bootstrap.css" rel="stylesheet">

</head>

<body>
    <div class="app">
        

            <!-- container profile -->
            <div class="container__profile ">
                <div class="grid">
                    <div class="grid__row row">
                     

                        <div class="profile__right grid__column-980">
                            <div class="profile__right-head">
                                <div>
                                    <h2>Hồ Sơ Của Tôi</h2>
                                    <span>Quản lý thông tin hồ sơ để bảo mật tài khoản</span>
                                </div>
                                <div class="profile__right-message ">
                                ${msSuccess}
                            </div>
                        </div>
                        <div class="profile__right-content" style="margin-top: 25px;">
                            <div class="profile__right-form">
                                <form action="UpdateProfile" method="POST">
                                    <table class="profile__right-table" style="width: 100%;">
                                        <tr>
                                            <td>
                                                <label for="">Tên đăng nhập</label>
                                                <span style="padding-left: 2px">${sessionScope.AccDetail.name}</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="profile__right-table__name">
                                                <label>Nickname </label>
                                                <input name="name" value="${sessionScope.AccDetail.name}" class="profile__right-input" type="text" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="profile__right-table__email">
                                                <label>Email</label>
                                                <input name="email" value="${sessionScope.AccDetail.email}" class="profile__right-input" placeholder="... @gmail.com" type="text">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="profile__right-table__phone">
                                                <label>Số điện thoại</label>
                                                <input name="phone" value="${sessionScope.AccDetail.phoneNumber}" class="profile__right-input" type="number">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="profile__right-table__gender" style="display: flex; ">
                                                <label>Giới tính</label>
                                                <input  type="radio"  name="gender" value="0"  ${sessionScope.AccDetail.gender == "0" ? 'checked' : ""}  />&nbsp;Nam
                                                &nbsp;&nbsp; <input type="radio" name="gender" value="1"  ${sessionScope.AccDetail.gender == "1" ? 'checked' : ""}  />&nbsp;Nữ
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="profile__right-table__date">
                                                <label>Ngày sinh</label>
                                                <input  name="dob" value="${sessionScope.AccDetail.dob}" style="max-width: 250px;" class="profile__right-input" type="date" >
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label></label>
                                                <button class="btn__save" type="submit"> Lưu</button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>

                            
                        </div>
                    </div>
                </div>

            </div>
        </div>
        

    </div>
</body>



</html>

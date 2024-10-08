<%-- 
    Document   : profileSavePost
    Created on : Jun 9, 2024, 4:01:31 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head itemscope itemtype="http://schema.org/WebSite">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title itemprop="name">Profile</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
        <meta name="viewport" content="width=device-width">
        <meta property="twitter:account_id" content="2433978487" />

        <!--For comment modal-->
        <link rel="stylesheet" href="css/modal.css">
        <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"
                integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
        <!---->

        <!--For post modal-->
        <link rel="stylesheet" href="post_modal/post_modal.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://unpkg.com/popper.js@1"></script>
        <script src="https://unpkg.com/tippy.js@4"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/autosize.js/4.0.2/autosize.min.js"></script>
        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/1.4.0/perfect-scrollbar.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
        <script src="post_modal/post_modal.js"></script>
        <!---->

        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.6/css/unicons.css">
    </head>

    <body>
        <nav>
            <div class="container">

                <a href="Explore">
                    <img src="images/Logo.jpg" style="width: 5rem" alt="alt"/>
                </a>

                <div class="search-bar">
                    <form action="search" method="post" class="form-inline my-2 my-lg-0">
                        <i class="uil uil-search" style="width: 10%"></i>
                        <input style="width: 80%" value="${searchText}" name="txt" type="search" placeholder="Tìm kiếm bài viết">
                    </form>

                </div>
                <div class="create">


                    <c:if test="${sessionScope.AccDetail==null}">
                        <a href="login">
                            <label class="btn btn-primary" >Đăng nhập</label>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.AccDetail!=null}">
                       
                        <a href="logout">
                            <label class="btn btn-primary">Đăng xuất</label>
                        </a>


                        <a class="profile-photo" href="Profile?accountId=${sessionScope.AccDetail.accountId}&page=1">
                            <img src="${sessionScope.AccDetail.avatarPath}" alt="">
                        </a>

                    </c:if> 
                </div>
            </div>
        </nav>



        <div id="snippetContent">
            <link rel="stylesheet" href="css/bootstrap.min.css">

            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
            <main>
                <div style="display: flex; justify-content: center;">
                    <div class="panel profile-cover" style="width: 90%; border-color:#fff; border-style: solid ;">
                        <div class="profile-cover__img"> <img src="${requestScope.account.avatarPath}"
                                                              alt />
                            <h3 class="h3">${requestScope.account.name}</h3>
                        </div>
                        <div class="profile-cover__action bg--img" data-overlay="0.3"> 
                            <c:if test="${requestScope.account.accountId==sessionScope.AccDetail.accountId}">
                                <button
                                    class="btn btn-rounded btn-info" data-toggle="modal" data-target="#exampleModalAvatar"> <i class="fa fa-camera"></i> <span>Avatar</span>
                                </button>
                                <button class="btn btn-rounded btn-info" data-bs-toggle="modal"
                                        data-bs-target="#editEmployeeModal"> <i class="fa fa-edit"></i> <span>Sửa thông tin</span>
                                </button>
                            </c:if>
                            <c:if test="${requestScope.account.accountId!=sessionScope.AccDetail.accountId && sessionScope.AccDetail.accountId!=null}">
                                <c:if test="${!checkFollow}">
                                    <button class="btn btn-rounded btn-info follow-btn" data-is-following="false" onclick="doFollow('${requestScope.account.accountId}', '${sessionScope.AccDetail.accountId}')" data-account-id="${sessionScope.AccDetail.getAccountId()}"> 
                                        <i class="fa fa-plus ChuaFollow"></i> <span>Theo dõi</span>
                                    </button>
                                </c:if>
                                <c:if test="${checkFollow}">
                                    <button class="btn btn-rounded btn-info follow-btn" data-is-following="true" onclick="doFollow('${requestScope.account.accountId}', '${sessionScope.AccDetail.accountId}')" data-account-id="${sessionScope.AccDetail.getAccountId()}"> 
                                        <i class="fa fa-check DaFollow"></i> <span>Đã theo dõi</span>
                                    </button>
                                </c:if>
                            </c:if>

                        </div>
                        <div class="profile-cover__info">
                            <ul class="nav">
                                <ul class="nav">
                                    <li><strong>${numberOfPost}</strong>Post</li>
                                    <li><a href="#" id="followerLink" style="text-decoration: none"><strong id="followerCount">${numberOfFollower}</strong></a>Người theo dõi</li>
                                    <li><a href="#" id="followingLink" style="text-decoration: none"><strong>${numberOfFollowing}</strong></a>Đang theo dõi</li>
                                </ul>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="container">

                    <div class="left">

                        <!-- Sidebar -->
                        <div class="sidebar">
                            <a class="menu-item" href="Feed">
                                <span><i class="uil uil-home"></i></span>
                                <h3>Feed</h3>
                            </a>
                            <a class="menu-item" href="Restaurants">
                                <span><i class="uil uil-restaurant"></i></span>
                                <h3>Địa điểm</h3>

                            </a>
                            <a class="menu-item" href="Explore">
                                <span><i class="uil uil-compass"></i></span>
                                <h3>Khám phá</h3>
                            </a>


                        </div>

                    </div>

                    <div class="middle">

                        <div class="middle-profileRestaurant">

                            <!-- Sidebar -->
                            <div class="sidebar">
                                <a class="menu-item" href="Profile?accountId=${requestScope.account.accountId}&page=1">
                                    <span><i class="uil uil-mailbox" style="margin-left: 0; margin-right: 0"></i></span>
                                    <h3>Bài viết</h3>
                                </a>
                                <a class="menu-item active" href="">
                                    <span><i class="uil uil-bookmark" style="margin-left: 0; margin-right: 0"></i></span>
                                    <h3>Đã lưu</h3>
                                </a>
                                <a class="menu-item" href="Profile?accountId=${requestScope.account.accountId}&page=3">
                                    <span><i class="uil uil-restaurant" style="margin-left: 0; margin-right: 0"></i></span>
                                    <h3>Địa điểm</h3>
                                </a>
                            </div>


                        </div>

                        <div class="feeds">
                            <c:forEach items="${requestScope.postMap}" var="p">
                                <c:if test="${p.value.status==1}">
                                    <div class="feed">
                                        <div class="head">
                                            <div class="user" style="display: flex; justify-content: center; align-items: center">
                                                <div class="profile-photo">
                                                    <img src="${p.key.avatarPath}" alt="pic">
                                                </div>
                                                <div class="info">
                                                    <h5>${p.key.name}</h5>
                                                    <small>${p.value.getFormattedDate()}</small>
                                                </div>
                                            </div>
                                        </div>

                                        <a href="PostPage?postId=${p.value.postId}">
                                            <div class="photo">
                                                <c:if test="${p.value.getImagePaths().size()!=0}">
                                                    <td><img src="${p.value.getImagePaths().get(0)}" alt="alt"/></td>
                                                    </c:if>
                                            </div>
                                        </a>    


                                        <div class="caption">
                                            <p><b>${p.value.title}</b> 
                                        </div>

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>



                    </div>
                    <div class="right" id="rightDiv">


                    </div>
                </div>
            </main>
        </div>

        <!-- Edit Modal HTML -->
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="UpdateProfile" method="POST">
                        <div class="modal-header">
                            <h4 class="modal-title">Chỉnh sửa thông tin</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" name="email" class="form-control" value="${sessionScope.AccDetail.email}" readonly="readonly" required>
                            </div>
                            <div class="form-group">
                                <label>Tên</label>
                                <input type="text" class="form-control" name="name" value="${sessionScope.AccDetail.name}" required>
                            </div>
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" value="${sessionScope.AccDetail.phoneNumber}" required>
                            </div>
                            <div class="form-group">
                                <label>Giới tính</label>

                                <input type="radio"  name="gender" value="0"  ${!sessionScope.AccDetail.gender  ? 'checked' : ""}  />&nbsp;Nam
                                &nbsp;&nbsp; <input type="radio" name="gender" value="1"  ${sessionScope.AccDetail.gender  ? 'checked' : ""}  />&nbsp;Nữ
                            </div>

                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input  name="dob" value="${sessionScope.AccDetail.dob}" style="max-width: 250px;" class="profile__right-input" type="date" >
                            </div>

                            <!-- <div class="form-group">
                                <label>Address</label>
                                <textarea class="form-control" required></textarea>
                            </div> -->


                        </div>
                        <div class="modal-footer">
                            <a href="ChangePassword.jsp?userId=${requestScope.account.accountId}" class="btn btn-warning">Đổi mật khẩu</a>
                            <input type="submit" class="btn btn-info" value="Lưu">
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Avatar Modal -->
        <div class="modal fade" id="exampleModalAvatar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form id="postForm" action="updateAvatar" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <div class="indicator"></div>
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Cập nhật Avatar</h5>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="media mb-3">

                                <div class="media-body">

                                    <div class="position-relative">
                                        <input type="file" class="d-none" accept="audio/*|video/*|video/x-m4v|video/webm|video/x-ms-wmv|video/x-msvideo|video/3gpp|video/flv|video/x-flv|video/mp4|video/quicktime|video/mpeg|video/ogv|.ts|.mkv|image/*|image/heic|image/heif" onchange="previewFile2()" id="inputUp2" name="file" required>
                                    </div>
                                </div>
                            </div>
                            <a class="mediaUp mr-4"><i class="material-icons mr-2" data-tippy="add (Video, Audio, Photo)" onclick="trigger('inputUp2')">perm_media</i>Tải ảnh</a>
                        </div>
                        <div class="row col-md-12 ml-auto mr-auto preview2"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-info btn-sm">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>                
        <script>
            let love_icons = document.querySelectorAll(".like");
            love_icons.forEach(function (icon) {
                icon.addEventListener("click", function () {
                    let not_loved = icon.children[0];
                    let loved = icon.children[1];
                    icon.classList.toggle("love");
                    not_loved.classList.toggle("hide_img");
                    loved.classList.toggle("display");
                })
            });
            let save_icon = document.querySelectorAll(".save");
            save_icon.forEach(function (save) {
                save.addEventListener("click", function () {
                    let not_save = save.children[1];
                    let saved = save.children[0];
                    not_save.classList.toggle("hide");
                    saved.classList.toggle("hide");

                })
            })
            document.addEventListener('DOMContentLoaded', (event) => {
                // Attach event listener to the Close button
                document.querySelector('.modal-header .close').addEventListener('click', () => {
                    window.location.href = 'Profile?accountId=${account.accountId}&page=2';
                });
            });

            function doFollow(accountId, followerId) {
                console.log(accountId + "," + followerId);




                var button = document.querySelector('.follow-btn');

                const followerCountElement = document.getElementById('followerCount');


                var isFollowing = button.getAttribute('data-is-following') === 'true';
                if (isFollowing) {
                    // Already following, unfollow action
                    button.setAttribute('data-is-following', 'false');
                    button.querySelector('i').classList.remove('DaFollow');
                    button.querySelector('i').classList.remove('fa-check');

                    button.querySelector('i').classList.add('ChuaFollow');
                    button.querySelector('i').classList.add('fa-plus');

                    button.querySelector('span').textContent = 'Theo dõi';


                    let numberOfFollowers = parseInt(followerCountElement.textContent);
                    numberOfFollowers -= 1;
                    followerCountElement.textContent = numberOfFollowers;

                } else {
                    // Not following, follow action
                    button.setAttribute('data-is-following', 'true');
                    button.querySelector('i').classList.remove('ChuaFollow');
                    button.querySelector('i').classList.remove('fa-plus');

                    button.querySelector('i').classList.add('DaFollow');
                    button.querySelector('i').classList.add('fa-check');

                    button.querySelector('span').textContent = 'Đã theo dõi';


                    let numberOfFollowers = parseInt(followerCountElement.textContent);
                    numberOfFollowers += 1;
                    followerCountElement.textContent = numberOfFollowers;
                }

                const d = {
                    accountId: accountId,
                    followerId: followerId,
                    operation: 'follow'
                };

                $.ajax({
                    url: "FollowUserServlet",
                    type: "POST",
                    data: d,

                    error: function (jqXHR, textStatus, errorThrown) {
                        console.error("Error occurred: " + errorThrown);
                    }
                });
            }

        </script>

        <style type="text/css">
            /*<![CDATA[*/
            /* Profile_page */
            body {
                background: #dcdcdc;
                margin-top: 20px;
            }

            .profile-cover {
                position: relative;
                z-index: 0;
            }

            .panel {
                margin-bottom: 30px;
                color: #696969;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.08);
            }

            .profile-cover__action {
                display: -ms-flexbox;
                display: -webkit-box;
                display: flex;
                padding: 120px 30px 10px 153px;
                border-radius: 5px 5px 0 0;
                -ms-flex-wrap: wrap;
                flex-wrap: wrap;
                -ms-flex-pack: end;
                -webkit-box-pack: end;
                justify-content: flex-end;
                overflow: hidden;
                background: url(images/banner.jpg) no-repeat;
                background-size: cover;
            }

            .profile-cover__action>.btn {
                margin-left: 10px;
                margin-bottom: 10px;
            }

            .profile-cover__img {
                position: absolute;
                top: 120px;
                left: 30px;
                text-align: center;
                z-index: 1;
            }

            .profile-cover__img>img {
                max-width: 120px;
                border: 5px solid #fff;
                border-radius: 50%;
            }

            .profile-cover__img>.h3 {
                color: #393939;
                font-size: 20px;
                line-height: 30px;
            }

            .profile-cover__img>img+.h3 {
                margin-top: 6px;
            }

            .profile-cover__info .nav {
                margin-right: 28px;
                padding: 15px 0 10px 170px;
                color: #999;
                font-size: 16px;
                line-height: 26px;
                font-weight: 300;
                text-align: center;
                text-transform: uppercase;
                -ms-flex-pack: end;
                -webkit-box-pack: end;
                justify-content: flex-end;
            }

            .profile-cover__info .nav li {
                margin-top: 13px;
                margin-bottom: 13px;
            }

            .profile-cover__info .nav li:not(:first-child) {
                margin-left: 30px;
                padding-left: 30px;
                border-left: 1px solid #eee;
            }

            .profile-cover__info .nav strong {
                display: block;
                margin-bottom: 10px;
                color: #9c1628;
                font-size: 34px;
            }

            @media (min-width: 481px) {
                .profile-cover__action>.btn {
                    min-width: 125px;
                }

                .profile-cover__action>.btn>span {
                    display: inline-block;
                }
            }

            @media (max-width: 600px) {
                .profile-cover__info .nav {
                    display: block;
                    margin: 90px auto 0;
                    padding-left: 30px;
                    padding-right: 30px;
                }

                .profile-cover__info .nav li:not(:first-child) {
                    margin-top: 8px;
                    margin-left: 0;
                    padding-top: 18px;
                    padding-left: 0;
                    border-top: 1px solid #eee;
                    border-left-width: 0;
                }
            }

            .panel {
                margin-bottom: 30px;
                color: #696969;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.08);
            }

            .panel-heading {
                color: #393939;
                padding: 10px 20px;
                border-width: 0;
                border-radius: 0;
            }

            .panel-heading:after,
            .panel-heading:before {
                content: " ";
                display: table;
            }

            .panel-heading:after {
                clear: both;
            }

            .panel-title {
                float: left;
                margin-top: 3px;
                margin-bottom: 3px;
                font-size: 14px;
                line-height: 24px;
                font-weight: 700;
                text-transform: uppercase;
            }

            .panel-title select {
                border-width: 0;
                background-color: transparent;
                text-transform: uppercase;
            }

            .panel-title select option {
                text-transform: capitalize;
            }

            .panel-title .select2 {
                display: block;
                min-width: 200px;
            }

            .panel-title .select2-selection {
                height: auto;
                padding: 0;
                background-color: transparent;
                border-width: 0;
                border-radius: 0;
                overflow: hidden;
                white-space: nowrap;
            }

            .no-outlines .panel-title .select2-selection {
                outline: 0;
            }

            .panel-title .select2-selection .select2-selection__rendered {
                float: left;
                margin-right: 8px;
                padding: 0;
                line-height: inherit;
            }

            .panel-title .select2-selection .select2-selection__arrow {
                float: left;
                display: block;
                position: relative;
                top: auto;
                right: auto;
                width: auto;
                height: auto;
            }

            .panel-title .select2-selection .select2-selection__arrow:before {
                content: "\f107";
                font-family: "Font Awesome\ 5 Free";
                font-weight: 700;
            }

            .panel-title .select2-container--open .select2-selection__arrow:before {
                content: "\f106";
            }

            .panel-heading .dropdown {
                float: right;
            }

            .panel-heading .dropdown .dropdown-toggle {
                margin: -10px -20px;
                padding: 10px 20px;
                color: #999;
                border-width: 0;
                font-size: 14px;
                line-height: 30px;
                cursor: pointer;
            }

            .panel-heading .dropdown .dropdown-toggle:after,
            .toolbar__nav>li>a>span {
                display: none;
            }

            .panel-heading .dropdown-menu {
                top: 30px !important;
                left: auto !important;
                right: -20px;
                margin: 0;
                padding: 10px 0;
                border-width: 0;
                border-radius: 4px 0 0 4px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.08);
                -webkit-transform: none !important;
                transform: none !important;
                z-index: 1001;
            }

            .panel-heading .dropdown-menu a {
                padding: 5px 15px;
                color: #999;
                font-size: 13px;
                line-height: 23px;
            }

            .panel-heading .dropdown-menu a:hover {
                color: #e16123;
            }

            .panel-heading .dropdown-menu i {
                min-width: 15px;
                margin-right: 6px;
                font-size: 11px;
                text-align: center;
            }

            .panel-subtitle {
                margin: 20px 0;
            }

            .panel-subtitle:first-child {
                margin-top: 0;
            }

            .panel-subtitle .h5 {
                color: #999;
                font-weight: 600;
            }

            .panel-subtitle .h5 small {
                color: #777;
            }

            .panel-body {
                padding: 20px;
            }

            .panel-content,
            .panel-social {
                position: relative;
                border-radius: 0 0 4px 4px;
            }

            .panel-content {
                border-top: 1px solid #eee;
                padding: 31px 20px 33px;
            }

            .panel-about table {
                width: 100%;
                word-break: break-word;
            }

            .panel-about table tr+tr td,
            .panel-about table tr+tr th {
                padding-top: 8px;
            }

            .panel-about table th {
                min-width: 120px;
                color: #c02b2b;
                font-weight: 400;
                vertical-align: top;
            }

            .panel-about table th>i {
                min-width: 14px;
                margin-right: 8px;
                text-align: center;
            }

            .panel-social {
                padding: 0 20px 33px;
                z-index: 0;
            }

            .panel-heading+.panel-social {
                padding-top: 21px;
                border-top: 1px solid #eee;
            }

            .panel-social>.nav {
                -ms-flex-pack: center;
                -webkit-box-pack: center;
                justify-content: center;
            }

            .panel-social>.nav>li:not(:last-child) {
                margin-right: 20px;
            }

            .panel-social>.nav>li>a {
                color: #ccc;
            }

            .panel-activity__status>.actions {
                display: -ms-flexbox;
                display: -webkit-box;
                display: flex;
                padding: 10px 20px;
                background-color: #ebebea;
                border-style: solid;
                border-width: 0 1px 1px;
                border-color: #ccc;
                border-bottom-left-radius: 4px;
                border-bottom-right-radius: 4px;
            }

            .btn-link {
                display: inline-block;
                color: inherit;
                font-weight: inherit;
                cursor: pointer;
                background-color: transparent;
            }

            button.btn-link {
                border-width: 0;
            }

            .panel-activity__status>.actions>.btn-group>.btn-link:not(:last-child) {
                margin-right: 25px;
            }

            .panel-activity__status>.actions>.btn-group>.btn-link {
                padding-left: 0;
                padding-right: 0;
                color: #9c9c9c;
            }

            .btn-info {
                background-color: #fff;
                border: none;
            }

            .btn-group,
            .btn-group-vertical {
                position: relative;
                display: -ms-inline-flexbox;
                display: inline-flex;
                vertical-align: middle;
            }

            .panel-activity__status>.actions>.btn-group {
                -ms-flex: 1;
                -webkit-box-flex: 1;
                flex: 1;
                font-size: 16px;
            }

            .panel-activity__list {
                margin: 60px 0 0;
                padding: 0;
                list-style: none;
            }

            .panel-activity__list,
            .panel-activity__list>li {
                position: relative;
                z-index: 0;
            }

            .panel-activity__list:before {
                content: " ";
                display: none;
                position: absolute;
                top: 20px;
                left: 35px;
                bottom: 0;
                border-left: 2px solid #ebebea;
            }

            .activity__list__icon {
                display: none;
                position: absolute;
                top: 2px;
                left: 0;
                min-width: 30px;
                color: #fff;
                background-color: #c02b2b;
                border-radius: 50%;
                line-height: 30px;
                text-align: center;
            }

            .panel-activity__list,
            .panel-activity__list>li {
                position: relative;
                z-index: 0;
            }

            .activity__list__header {
                position: relative;
                min-height: 35px;
                padding-top: 4px;
                padding-left: 45px;
                color: #999;
                z-index: 0;
            }

            .activity__list__body {
                padding-top: 13px;
                padding-left: 43px;
            }

            .entry-content .gallery {
                margin: 0;
                list-style: none;
                padding: 0;
            }

            .entry-content .gallery,
            .m-error {
                display: -ms-flexbox;
                display: flex;
                -ms-flex-wrap: wrap;
                flex-wrap: wrap;
            }

            .entry-content .gallery>li {
                padding-right: 20px;
                -ms-flex-preferred-size: 0;
                flex-basis: 0;
                -ms-flex-positive: 1;
                flex-grow: 1;
                max-width: 100%;
            }

            .gallery>li img {
                max-width: 100%;
                height: auto;
            }

            .entry-content blockquote:last-child,
            p:last-child,
            table:last-child,
            ul:last-child {
                margin-bottom: 0;
            }

            .entry-content blockquote:last-child,
            p:last-child,
            table:last-child,
            ul:last-child {
                margin-bottom: 0;
            }

            .entry-content blockquote p:before {
                content: "\f10d";
                color: #999;
                margin-right: 12px;
                font-family: "FontAwesome";
                font-size: 24px;
                font-weight: 900;
            }

            .activity__list__header img {
                position: absolute;
                top: 0;
                left: 0;
                max-width: 35px;
                border-radius: 50%;
            }

            .activity__list__header a {
                color: #222;
                font-weight: 600;
            }

            .activity__list__footer {
                display: -ms-flexbox;
                display: -webkit-box;
                display: flex;
                margin-top: 23px;
                margin-left: 43px;
                padding: 13px 8px 0;
                color: #999;
                border-top: 1px dotted #ccc;
            }

            .activity__list__footer a {
                color: inherit;
            }

            .activity__list__footer a+a {
                margin-left: 15px;
            }

            .activity__list__footer i {
                margin-right: 8px;
            }

            .activity__list__footer a:hover {
                color: #222;
            }

            .activity__list__footer span {
                margin-left: auto;
            }

            .panel-activity__list>li+li {
                margin-top: 51px;
            }

            .weather--panel {
                padding: 24px 20px 36px;
                border-radius: 5px;
                text-align: center;
            }

            .weather--title {
                font-size: 18px;
                line-height: 28px;
                font-weight: 600;
            }

            .weather--title .fa {
                margin-right: 5px;
                font-size: 30px;
                line-height: 40px;
            }

            .weather--info {
                margin-top: 14px;
                font-size: 46px;
                line-height: 56px;
            }

            .weather--info .wi {
                margin-right: 10px;
            }

            .bg-blue {
                background-color: #c02b2b;
            }

            .bg-orange {
                background-color: #e16123;
            }

            .todo--panel .list-group,
            .user--list>li,
            .user--list>li>a {
                position: relative;
                z-index: 0;
            }

            .hero-height {
                max-height: 314px;
            }

            .hero-height .mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar {
                background: rgb(233, 236, 238);
            }

            .todo--panel .list-group {
                margin-bottom: 0;
                padding-top: 23px;
                padding-bottom: 25px;
            }

            .todo--panel .list-group:before {
                content: " ";
                position: absolute;
                top: 0;
                left: 20px;
                right: 20px;
                border-top: 1px solid #eee;
            }

            .todo--panel .list-group-item {
                margin-top: 27px;
                padding: 0;
                border-width: 0;
            }

            li.list-group-item:first-child {
                margin-top: 0;
            }

            .todo--label {
                padding-left: 20px;
                padding-right: 30px;
                color: #696969;
                font-weight: 400;
            }

            .todo--input {
                display: none;
            }

            .todo--text {
                display: block;
                position: relative;
                padding-left: 39px;
                -webkit-transition: color 0.25s;
                transition: color 0.25s;
                cursor: pointer;
                z-index: 0;
            }

            .todo--input:checked+.todo--text {
                color: #999;
                text-decoration: line-through;
            }

            .todo--text:after,
            .todo--text:before {
                position: absolute;
                top: 50%;
                left: 0;
                margin-top: -10px;
                width: 20px;
                height: 20px;
                border-radius: 2px;
            }

            .todo--text:before {
                border: 1px solid #ccc;
                content: " ";
            }

            .todo--text:after {
                content: "\f00c";
                color: #fff;
                background-color: #009378;
                font-family: "FontAwesome";
                font-size: 11px;
                line-height: 21px;
                font-weight: 700;
                text-align: center;
                opacity: 0;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
                -webkit-transform: scale(0.3);
                transform: scale(0.3);
                -webkit-transition: opacity 0.25s linear, -webkit-transform 0.25s linear;
                transition: opacity 0.25s linear, transform 0.25s linear;
                transition: opacity 0.25s linear, transform 0.25s linear, -webkit-transform 0.25s linear;
            }

            .todo--input:checked+.todo--text:after {
                opacity: 1;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
                -webkit-transform: scale(1);
                transform: scale(1);
            }

            .todo--remove {
                position: absolute;
                top: 50%;
                right: 20px;
                margin-top: -15px;
                color: #999;
                font-size: 18px;
                line-height: 28px;
            }

            .todo--panel .input-group {
                border-top: 1px solid #eee;
            }

            .todo--panel .form-control {
                height: auto;
                padding: 13px 20px 14px;
                border-width: 0;
            }

            .todo--panel .btn-link {
                padding: 12px 16px;
                color: #ccc;
                font-size: 28px;
                border-width: 0;
                text-decoration: none;
            }

            .feeds-panel {
                margin: 20px 20px 0;
                padding-top: 17px;
                padding-bottom: 23px;
                border-top: 1px solid #ebebea;
            }

            .feeds-panel li {
                position: relative;
                width: 100%;
                min-height: 20px;
                padding-left: 40px;
                z-index: 0;
            }

            .feeds-panel li a {
                color: #e16123;
            }

            .feeds-panel li+li {
                margin-top: 12px;
            }

            .bg- red {
                background-color: #ff4040;
            }

            .bg-green {
                background-color: #009378;
            }

            .comments-panel>ul>li:after,
            .comments-panel>ul>li:before,
            .feeds-panel li:after,
            .feeds-panel li:before {
                content: " ";
                display: table;
            }

            .comments-panel>ul>li:after,
            .feeds-panel li:after {
                clear: both;
            }

            .feeds-panel .time {
                float: right;
                margin-left: 5px;
                color: #ccc;
                font-style: italic;
            }

            .feeds-panel .fa {
                position: absolute;
                top: 0;
                left: 0;
                min-width: 30px;
                border-radius: 2px;
                font-size: 12px;
                line-height: 30px;
                text-align: center;
            }

            .feeds-panel .text {
                color: #696969;
                line-height: 26px;
            }

            /*]]>*/
        </style>

        <link rel="stylesheet" href="css/style.css">
        <script src="js/main.js"></script>

        <script>
            $(document).ready(function () {
                $('#followingLink').on('click', function (e) {
                    e.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết
                    $('#rightDiv').html(`
                    <div class="messages" style="position: relative">
            <div class="heading">
                <h4>Đang theo dõi</h4>
            </div>
            <c:forEach items="${requestScope.followingList}" var="f">
                <a class="message" href="Profile?accountId=${f.accountId}&page=1" style="text-decoration: none; color: black">
                    <div class="profile-photo">
                        <img src="${f.avatarPath}">
                    </div>
                    <div class="message-body">
                        <h5>${f.name}</h5>
                        <p class="text-muted">${f.numberOfPost} bài viết</p>
                    </div>
                </a>
            </c:forEach>
                </div>
        `);
                });

                $('#followerLink').on('click', function (e) {
                    e.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết
                    $('#rightDiv').html(`
                    <div class="messages" style="position: relative">
                            
                        
            <div class="heading">
                <h4>Người theo dõi</h4>
            </div>
            <c:forEach items="${requestScope.followerList}" var="f">
                <a class="message" href="Profile?accountId=${f.accountId}&page=1" style="text-decoration: none; color: black">
                    <div class="profile-photo">
                        <img src="${f.avatarPath}">
                    </div>
                    <div class="message-body">
                        <h5>${f.name}</h5>
                        <p class="text-muted">${f.numberOfPost} bài viết</p>
                    </div>
                </a>
            </c:forEach>
                </div>
        `);
                });
            });
        </script>

    </body>

</html>

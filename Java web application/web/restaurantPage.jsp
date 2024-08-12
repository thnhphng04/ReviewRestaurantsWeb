<%-- 
    Document   : PostPage
    Created on : Jun 3, 2024, 3:42:14 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%@ page import="DAL.PostSavedDAO" %>
<%@ page import="DAL.ReactDAO" %>
<%@ page import="Model.AccountDetail" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Social Media Clone</title>

        <!--For comment ajax-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!---->

        <!--For comment modal-->
        <link rel="stylesheet" href="css/modal.css">
        <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.js"></script>
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
        <link rel="stylesheet" href="css/restaurantPageStyle.css">

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

        <!-- Main section -->

        <main>
            <div class="container">
                <div class="left">

                    <!-- Sidebar -->
                    
                    <div class="sidebar">

                        <c:if test="${sessionScope.AccDetail!=null}">
                            <c:if test="${sessionScope.AccDetail.role==1}">
                            <a class="postBtn" data-toggle="modal" data-target="#exampleModal">
                                <img class="" src="./images/create-post.png">
                            </a>
                            <a class="postBtn" data-toggle="modal" data-target="#exampleModal3">
                                <img class="" src="./images/report-flag.png">

                            </a>
                            </c:if>
                        </c:if>

                        <c:if test="${sessionScope.AccDetail==null}">
                            <a class="postBtn" href="login">
                                <img class="" src="./images/create-post.png">
                            </a>

                            <a class="postBtn" href="login">
                                <img class="" src="./images/report-flag.png">

                            </a>
                        </c:if>






                    </div>

                </div>
                <!-- End of Left -->

                <div class="middle">


                    <div class="restaurants-modal">

                        <c:if test="${sessionScope.AccDetail.role==2}">
                            <div class="restaurant">
                                <div class="head">
                                    <div class="user">
                                        <div class="info">
                                            <h3>Ảnh bằng chứng đã đến quán</h3>

                                        </div>
                                    </div>

                                </div>

                                <div style="display: flex; overflow-x: scroll">
                                    <c:forEach items="${requestScope.restaurant.proofPaths}" var="i">
                                        <img src="${i}" class="img-thumbnail" alt="pic" style="width: 30%; margin-right: 10px; border-radius: 5px">
                                    </c:forEach>
                                </div>




                            </div>
                        </c:if>


                        <div class="restaurant">
                            <div class="head">
                                <div class="user">
                                    <div class="profile-photo">
                                        <img src="${requestScope.restaurant.avatarPath}" alt="pic">
                                    </div>
                                    <div class="info" style="display: flex; flex-direction: column; justify-content: center">
                                        <h4>${requestScope.restaurant.name}</h4>
                                        <div style="display: flex; align-items: center">
                                            <svg xmlns="http://www.w3.org/2000/svg" font-size="2rem" position="relative" width="1em" height="1em" viewBox="0 0 128 128"><path fill="#ad0b0b" d="m68.05 7.23l13.46 30.7a7.047 7.047 0 0 0 5.82 4.19l32.79 2.94c3.71.54 5.19 5.09 2.5 7.71l-24.7 20.75c-2 1.68-2.91 4.32-2.36 6.87l7.18 33.61c.63 3.69-3.24 6.51-6.56 4.76L67.56 102a7.033 7.033 0 0 0-7.12 0l-28.62 16.75c-3.31 1.74-7.19-1.07-6.56-4.76l7.18-33.61c.54-2.55-.36-5.19-2.36-6.87L5.37 52.78c-2.68-2.61-1.2-7.17 2.5-7.71l32.79-2.94a7.047 7.047 0 0 0 5.82-4.19l13.46-30.7c1.67-3.36 6.45-3.36 8.11-.01"/><path fill="#ff9494" d="m67.07 39.77l-2.28-22.62c-.09-1.26-.35-3.42 1.67-3.42c1.6 0 2.47 3.33 2.47 3.33l6.84 18.16c2.58 6.91 1.52 9.28-.97 10.68c-2.86 1.6-7.08.35-7.73-6.13"/><path fill="#f50000" d="M95.28 71.51L114.9 56.2c.97-.81 2.72-2.1 1.32-3.57c-1.11-1.16-4.11.51-4.11.51l-17.17 6.71c-5.12 1.77-8.52 4.39-8.82 7.69c-.39 4.4 3.56 7.79 9.16 3.97"/></svg>
                                            <p style="font-size: 1.5em; line-height: 1em; margin-bottom: 0; margin-top: 5px; margin-right: 5px">${requestScope.averageRate}/5 điểm (${requestScope.numberOfPost} đánh giá)</p>



                                        </div>


                                    </div>
                                </div>

                                <c:if test="${restaurant.status==2}">
                                    <p style="color:blue">Địa điểm này chưa được duyệt</p>
                                </c:if>
                                <c:if test="${restaurant.status==3}">
                                    <p style="color:red">Địa điểm này không được duyệt vì: ${restaurant.reasonDeny}</p>
                                </c:if>
                                <c:if test="${restaurant.status==5 && restaurant.accountId == sessionScope.AccDetail.accountId}">
                                    <p style="color:blue">Địa điểm này đang chờ duyệt chỉnh sửa</p>
                                </c:if>

                                <c:if test="${sessionScope.AccDetail.accountId==requestScope.restaurant.accountId}">
                                    <span class="edit">
                                        <i class="uil uil-ellipsis-h"></i>
                                        <div class="dropdown-menu" style="z-index: 800">
                                            <a href="#" class="dropdown-item" id="edit-post" data-toggle="modal" data-target="#exampleModal2">Chỉnh sửa</a>
                                            <a href="#" class="dropdown-item" id="delete-post">Xóa</a>
                                        </div>
                                    </span>
                                </c:if>

                            </div>



                            <p style="margin-top: 1rem"> <span><i class="uil uil-phone"></i></span>     Số điện thoại: ${requestScope.restaurant.phoneNumber}</p> 

                            <p style="margin-bottom: 1rem"> <span><i class="uil uil-home"></i></span>     Địa chỉ: ${requestScope.restaurant.address}</p>

                            <p style="margin-bottom: 1rem"> <span><i class="uil uil-money-bill"></i></span>     Khoảng giá: ${requestScope.restaurant.lowestPrice} - ${requestScope.restaurant.highestPrice} VNĐ</p>

                            <c:if test="${requestScope.restaurant.isOpenNow()}">
                                <p style="margin-bottom: 1rem; color: #00c8c5">
                                    <span><i class="uil uil-clock"></i></span>Thời gian: Đang mở cửa (${requestScope.restaurant.openTime} - ${requestScope.restaurant.closeTime})
                                </p>
                            </c:if>
                            <c:if test="${!requestScope.restaurant.isOpenNow()}">
                                <p style="margin-bottom: 1rem; color: #e1120c">
                                    <span><i class="uil uil-clock"></i></span>Thời gian: Đang đóng cửa (${requestScope.restaurant.openTime} - ${requestScope.restaurant.closeTime})
                                </p>
                            </c:if>



                            <iframe
                                id="map1"
                                loading="lazy"
                                allowfullscreen
                                src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAj6t7ZZxyY1pmYURedsxUu9uUzV0bj-iw&q=${requestScope.restaurant.address}"
                                style="width: 100%; height: 500px">
                            </iframe>

                        </div>



                    </div>

                    <div class="feeds">
                        <c:forEach items="${requestScope.postMap}" var="p">
                            <div class="feed" style="width: 60%">
                                <div class="head">
                                    <div class="user" style="display: flex; justify-content: center; align-items: center">
                                        <div class="profile-photo">
                                            <img src="${p.key.avatarPath}" alt="pic">
                                        </div>
                                        <div class="info">
                                            <h3>${p.key.name}</h3>
                                            <small>${p.value.getFormattedDate()}</small>
                                        </div>
                                    </div>
                                    <span class="edit">
                                        <i class="uil uil-ellipsis-h"></i>
                                    </span>
                                </div>



                                <div style="display: flex; align-items: center; margin-top: 10px">
                                    <svg xmlns="http://www.w3.org/2000/svg" font-size="2rem" position="relative" width="1em" height="1em" viewBox="0 0 128 128"><path fill="#ad0b0b" d="m68.05 7.23l13.46 30.7a7.047 7.047 0 0 0 5.82 4.19l32.79 2.94c3.71.54 5.19 5.09 2.5 7.71l-24.7 20.75c-2 1.68-2.91 4.32-2.36 6.87l7.18 33.61c.63 3.69-3.24 6.51-6.56 4.76L67.56 102a7.033 7.033 0 0 0-7.12 0l-28.62 16.75c-3.31 1.74-7.19-1.07-6.56-4.76l7.18-33.61c.54-2.55-.36-5.19-2.36-6.87L5.37 52.78c-2.68-2.61-1.2-7.17 2.5-7.71l32.79-2.94a7.047 7.047 0 0 0 5.82-4.19l13.46-30.7c1.67-3.36 6.45-3.36 8.11-.01"/><path fill="#ff9494" d="m67.07 39.77l-2.28-22.62c-.09-1.26-.35-3.42 1.67-3.42c1.6 0 2.47 3.33 2.47 3.33l6.84 18.16c2.58 6.91 1.52 9.28-.97 10.68c-2.86 1.6-7.08.35-7.73-6.13"/><path fill="#f50000" d="M95.28 71.51L114.9 56.2c.97-.81 2.72-2.1 1.32-3.57c-1.11-1.16-4.11.51-4.11.51l-17.17 6.71c-5.12 1.77-8.52 4.39-8.82 7.69c-.39 4.4 3.56 7.79 9.16 3.97"/></svg>
                                    <p style="margin: 3px;">${p.value.rating}/5 điểm</p>
                                </div>
                                <div class="caption" style="margin-top: 10px">

                                    <h3>${p.value.title} </h3>     
                                    <pre class="post-text"><h6>${p.value.text}</h6></pre>

                                </div>

                                <div style="display: flex; overflow-x: scroll">
                                    <c:forEach items="${p.value.getImagePaths()}" var="i">
                                        <img src="${i}" class="img-thumbnail" alt="pic" style="width: 15%; margin-right: 10px; border-radius: 5px">
                                    </c:forEach>
                                </div>

                            </div>
                        </c:forEach>




                    </div>

                </div>

            </div>

        </main>

        <!-- Post Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 50%;">
                <div class="modal-content">
                    <form id="postForm" action="createPost" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <div class="indicator"></div>
                        <div class="modal-header" style="display: flex; justify-content: flex-start">
                            <h5 class="modal-title" id="exampleModalLabel"></h5>
                            <div class="profile-photo">
                                <img src="${sessionScope.AccDetail.avatarPath}" alt="">
                            </div>
                            <div class="handle">
                                <h4>${sessionScope.AccDetail.name}</h4>
                                <p class="text-muted">@${sessionScope.AccDetail.name}</p>
                            </div>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <!-- Hidden input to store the selected restaurant ID -->
                            <input type="hidden" name="restaurantId" value="${requestScope.restaurant.restaurantId}" id="selectedRestaurantId" required>

                            <div class="media mb-3">
                                <div class="media-body">

                                    <div class="position-relative">
                                        <input type="file" class="d-none" accept="audio/*|video/*|video/x-m4v|video/webm|video/x-ms-wmv|video/x-msvideo|video/3gpp|video/flv|video/x-flv|video/mp4|video/quicktime|video/mpeg|video/ogv|.ts|.mkv|image/*|image/heic|image/heif" onchange="previewFiles2()" id="inputUp2" name="files2" multiple required>
                                    </div>
                                </div>

                            </div>
                            <a class="mediaUp2 mr-4"><i class="material-icons mr-2" data-tippy="add (Video, Audio, Photo)" onclick="trigger('inputUp2')">perm_media</i>Thêm bằng chứng đã đến quán (Bill có địa chỉ, ảnh chụp mặt tiền của quán)</a>

                            <div class="row col-md-12 ml-auto mr-auto preview2"></div>

                            <div style="display: flex; justify-content: space-evenly;">
                                <!-- Checkbox 1: Meal Types -->
                                <div class="form-group">
                                    <label>Chọn loại bữa ăn:</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="mealType" value="1" id="breakfast">
                                        <label class="form-check-label" for="breakfast">Ăn sáng</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="mealType" value="2" id="lunch">
                                        <label class="form-check-label" for="lunch">Ăn trưa</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="mealType" value="3" id="dinner">
                                        <label class="form-check-label" for="dinner">Ăn tối</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="mealType" value="4" id="snack">
                                        <label class="form-check-label" for="snack">Ăn vặt</label>
                                    </div>
                                </div>
                                <!-- Checkbox 2: Food Types -->
                                <div class="form-group">
                                    <label>Chọn loại thức ăn:</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="foodType" value="food" id="food">
                                        <label class="form-check-label" for="food">Đồ ăn</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="foodType" value="drink" id="drink">
                                        <label class="form-check-label" for="drink">Đồ uống</label>
                                    </div>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-user"></i>Phục vụ:</span></h6>

                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="2.5" step="0.1" class="slider" id="myRange1" name="serviceRating">
                                    <h6>&#160;&#160;<span id="demo1">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-money-bill"></i>Giá cả:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="2.5" step="0.1" class="slider" id="myRange2" name="priceRating">
                                    <h6>&#160;&#160;<span id="demo2">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-home"></i>Không gian:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="2.5" step="0.1" class="slider" id="myRange3" name="spaceRating">
                                    <h6>&#160;&#160;<span id="demo3">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-restaurant"></i>Hương vị:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="2.5" step="0.1" class="slider" id="myRange4" name="tasteRating">
                                    <h6>&#160;&#160;<span id="demo4">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-trash-alt"></i>Vệ sinh:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="2.5" step="0.1" class="slider" id="myRange5" name="hygieneRating">
                                    <h6>&#160;&#160;<span id="demo5">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="form-group" style="display: flex; align-items: center; justify-content: flex-start">
                                <h6 for="rating" style="width: 30%; margin: 0;">Điểm tổng quát: </h6>
                                <input type="number" value="2.5" class="form-control" id="rating" name="rating" min="0" max="5" step="0.1" required readonly style="border: none; width: 10%; font-size: 22px;">
                                <svg xmlns="http://www.w3.org/2000/svg" font-size="2rem" position="relative" width="1em" height="1em" viewBox="0 0 128 128"><path fill="#ad0b0b" d="m68.05 7.23l13.46 30.7a7.047 7.047 0 0 0 5.82 4.19l32.79 2.94c3.71.54 5.19 5.09 2.5 7.71l-24.7 20.75c-2 1.68-2.91 4.32-2.36 6.87l7.18 33.61c.63 3.69-3.24 6.51-6.56 4.76L67.56 102a7.033 7.033 0 0 0-7.12 0l-28.62 16.75c-3.31 1.74-7.19-1.07-6.56-4.76l7.18-33.61c.54-2.55-.36-5.19-2.36-6.87L5.37 52.78c-2.68-2.61-1.2-7.17 2.5-7.71l32.79-2.94a7.047 7.047 0 0 0 5.82-4.19l13.46-30.7c1.67-3.36 6.45-3.36 8.11-.01"/><path fill="#ff9494" d="m67.07 39.77l-2.28-22.62c-.09-1.26-.35-3.42 1.67-3.42c1.6 0 2.47 3.33 2.47 3.33l6.84 18.16c2.58 6.91 1.52 9.28-.97 10.68c-2.86 1.6-7.08.35-7.73-6.13"/><path fill="#f50000" d="M95.28 71.51L114.9 56.2c.97-.81 2.72-2.1 1.32-3.57c-1.11-1.16-4.11.51-4.11.51l-17.17 6.71c-5.12 1.77-8.52 4.39-8.82 7.69c-.39 4.4 3.56 7.79 9.16 3.97"/></svg>
                            </div>
                            <div class="media mb-3">
                                <div class="media-body">
                                    <textarea class="autosize" placeholder="Tiêu đề" rows="1" id="note" name="title" data-emoji="true"></textarea>
                                    <textarea class="autosize" placeholder="Nội dung" rows="5" id="note" name="text" data-emoji="true"></textarea>
                                    <div class="position-relative">
                                        <input type="file" class="d-none" accept="audio/*|video/*|video/x-m4v|video/webm|video/x-ms-wmv|video/x-msvideo|video/3gpp|video/flv|video/x-flv|video/mp4|video/quicktime|video/mpeg|video/ogv|.ts|.mkv|image/*|image/heic|image/heif" onchange="previewFiles()" id="inputUp" name="files" multiple required>
                                    </div>
                                </div>
                            </div>
                            <a class="mediaUp mr-4"><i class="material-icons mr-2" data-tippy="add (Video, Audio, Photo)" onclick="trgger('inputUp')">perm_media</i>Thêm ảnh/video</a>
                        </div>
                        <div class="row col-md-12 ml-auto mr-auto preview"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-info btn-sm">Đăng</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>                        

        <!-- Add restaurant Modal -->
        <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 50%;">
                <div class="modal-content">
                    <form id="postForm" action="createEditRestaurant" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="editOfRestaurantId" value="${restaurant.restaurantId}">

                        <input type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <div class="indicator"></div>
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Thêm địa điểm</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div style="display: flex; justify-content: space-around;">
                                <div style="display: flex; flex-direction: column;">

                                    <label for="location_name" style="margin-bottom: 30px;"><span></i>Tên địa điểm:</span></label>

                                    <label for="province">Địa chỉ:</label><br>

                                    <br>
                                    <br>
                                    <br>





                                </div>

                                <div style="display: flex; flex-direction: column; width: 40%;">
                                    <input type="text" value="${restaurant.name}" id="location_name" name="name" required
                                           style="margin-bottom: 4px;"><br>

                                    <div style="display: flex; justify-content: flex-start; flex-direction: column; margin-bottom: 3px;">
                                        <select id="tinh" name="tinh" title="Chọn Tỉnh Thành" required>
                                            <option value="0">Tỉnh Thành</option>
                                        </select> 
                                        <select id="quan" name="quan" title="Chọn Quận Huyện" required>
                                            <option value="0">Quận Huyện</option>
                                        </select> 
                                        <select id="phuong" name="phuong" title="Chọn Phường Xã" required>
                                            <option value="0">Phường Xã</option>
                                        </select>
                                    </div>

                                    <input type="text" value="${restaurant.address}" id="address" name="address" placeholder="(Số nhà, tên đường)" required><br>


                                </div>


                            </div>

                            <div style="display: flex; justify-content: center; margin-bottom: 30px">
                                <iframe
                                    id="map"
                                    loading="lazy"
                                    allowfullscreen
                                    src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAj6t7ZZxyY1pmYURedsxUu9uUzV0bj-iw&q=HaNoi"
                                    style="width: 80%; height: 500px">
                                </iframe>
                            </div>    




                            <div style="display: flex; justify-content: space-around; margin-top: 30px">
                                <div style="display: flex; flex-direction: column;">
                                    <label for="phone_number"><span><i class="uil uil-phone"></i>Số điện thoại:</span></label><br>

                                    <label for="lowest_price"><span><i class="uil uil-money-bill"></i>Giá thấp nhất:</span></label><br>

                                    <label for="highest_price"><span><i class="uil uil-money-bill"></i>Giá cao nhất:</span></label><br>

                                    <label for="opening_hours"><span><i class="uil uil-clock"></i>Khung giờ:</span></label><br>

                                </div>
                                <div style="display: flex; flex-direction: column; width: 40%;">
                                    <input type="tel" value="${restaurant.phoneNumber}" id="phone_number" name="phone_number" pattern="[0-9]{10,11}" required
                                           style="margin-bottom: 7px;"><br>

                                    <input type="number" value="${restaurant.lowestPrice}" id="lowest_price" name="lowest_price" min="0" required
                                           style="margin-bottom: 7px;"><br>

                                    <input type="number" value="${restaurant.highestPrice}" id="highest_price" name="highest_price" min="0" required
                                           style="margin-bottom: 7px;"><br>

                                    <div style="width: 100%; ;display: flex; justify-content: space-evenly;">
                                        <input type="time" value="${restaurant.openTime}" id="opening_hours" name="opening_hours" required><br>

                                        <input type="time" value="${restaurant.closeTime}" id="closing_hours" name="closing_hours" required><br>

                                    </div>

                                </div>
                            </div>


                            <div class="media mb-3">

                                <div class="media-body">
                                    <div class="position-relative">
                                        <input type="file" class="d-none"
                                               accept="audio/*|video/*|video/x-m4v|video/webm|video/x-ms-wmv|video/x-msvideo|video/3gpp|video/flv|video/x-flv|video/mp4|video/quicktime|video/mpeg|video/ogv|.ts|.mkv|image/*|image/heic|image/heif"
                                               onchange="previewFile4()" id="inputUp3" name="fileAva">
                                    </div>
                                </div>
                            </div>
                            <a class="mediaUp mr-4"><i class="material-icons mr-2" data-tippy="add (Video, Audio, Photo)"
                                                       onclick="trgger4('inputUp3')">perm_media</i>Sửa ảnh đại diện</a>
                        </div>
                        <div class="row col-md-12 ml-auto mr-auto preview4"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-info btn-sm">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>   

        <!-- Report Modal -->
        <div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 30%;">
                <div class="modal-content">
                    <form id="postForm" action="createRestaurantReport" method="post">
                        <input type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <div class="indicator"></div>
                        <div class="modal-header" style="display: flex; justify-content: flex-start">
                            <h5 class="modal-title" id="exampleModalLabel">Report bài viết</h5>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <input type="hidden" name="restaurantId" value="${requestScope.restaurant.restaurantId}" >

                            <div class="form-group">
                                <label>Tại sao bạn báo cáo địa điểm này?</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report1" name="reportId" value="1" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report1">Thông tin không chính xác</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report2" name="reportId" value="2" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report2">Địa điểm đã đóng cửa</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report3" name="reportId" value="3" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report3">Sai vị trí trên bản đồ</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report4" name="reportId" value="4" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report4">Các lý do khác</label>
                                </div>
                            </div>





                            <div class="media mb-3">
                                <div class="media-body">

                                    <textarea class="autosize" placeholder="Điền nội dung" rows="5" id="note" name="text" data-emoji="true"></textarea>

                                </div>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-info btn-sm">Gửi báo cáo</button>
                        </div>
                    </form>
                </div>
            </div>
        </div> 

        <!-- The image Modal -->
        <div id="myModal" class="image-modal">
            <span class="close1">&times;</span>
            <img class="image-modal-content" id="img01">
        </div>

        <script>
            function updateMap() {
                var location_name = document.getElementById('location_name').value;
                var tinh = document.getElementById('tinh').value;
                var quan = document.getElementById('quan').value;
                var phuong = document.getElementById('phuong').value;
                var address = document.getElementById('address').value;

                // Combine the values to form the complete address
                var fullAddress = location_name + ", " + address + ", " + phuong + ", " + quan + ", " + tinh;

                var iframe = document.getElementById('map');
                var apiKey = 'AIzaSyAj6t7ZZxyY1pmYURedsxUu9uUzV0bj-iw';
                iframe.src = 'https://www.google.com/maps/embed/v1/place?key=' + apiKey + '&q=' + encodeURIComponent(fullAddress);
            }

            // Add event listeners to all inputs
            document.getElementById('tinh').addEventListener('change', updateMap);
            document.getElementById('quan').addEventListener('change', updateMap);
            document.getElementById('phuong').addEventListener('change', updateMap);
            document.getElementById('address').addEventListener('input', updateMap);

            //api dia chi
            $(document).ready(function () {
                //Lấy tỉnh thành
                $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                    if (data_tinh.error == 0) {
                        $.each(data_tinh.data, function (key_tinh, val_tinh) {
                            $("#tinh").append('<option value="' + val_tinh.full_name + '" data-id="' + val_tinh.id + '">' + val_tinh.full_name + '</option>');
                        });
                        $("#tinh").change(function (e) {
                            var idtinh = $(this).find(":selected").data("id");
                            //Lấy quận huyện
                            $.getJSON('https://esgoo.net/api-tinhthanh/2/' + idtinh + '.htm', function (data_quan) {
                                if (data_quan.error == 0) {
                                    $("#quan").html('<option value="0">Quận Huyện</option>');
                                    $("#phuong").html('<option value="0">Phường Xã</option>');
                                    $.each(data_quan.data, function (key_quan, val_quan) {
                                        $("#quan").append('<option value="' + val_quan.full_name + '" data-id="' + val_quan.id + '">' + val_quan.full_name + '</option>');
                                    });
                                    //Lấy phường xã  
                                    $("#quan").change(function (e) {
                                        var idquan = $(this).find(":selected").data("id");
                                        $.getJSON('https://esgoo.net/api-tinhthanh/3/' + idquan + '.htm', function (data_phuong) {
                                            if (data_phuong.error == 0) {
                                                $("#phuong").html('<option value="0">Phường Xã</option>');
                                                $.each(data_phuong.data, function (key_phuong, val_phuong) {
                                                    $("#phuong").append('<option value="' + val_phuong.full_name + '">' + val_phuong.full_name + '</option>');
                                                });
                                            }
                                        });
                                    });

                                }
                            });
                        });

                    }
                });
            });

        </script> 

        <script>

            function doLike(postId, accountId) {
                console.log(postId + "," + accountId);
                const d = {
                    accountId: accountId,
                    postId: postId,
                    operation: 'like'
                }
                const u = {
                    accountId: accountId,
                    postId: postId,
                    operation: 'unlike'
                }
                var imgElement = document.getElementById('imgLike');
                $.ajax({
                    url: "LikeServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if (data.trim() == 'like') {
                            let c = $(".like-counter").html();
                            c++;
                            $('.like-counter').html(c);
                            imgElement.src = './images/heart.png';
                        } else if (data.trim() == 'unlike') {
                            let c = $(".like-counter").html();
                            c--;
                            $('.like-counter').html(c);
                            imgElement.src = './images/love.png';
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data)
                    }

                });
            }
            ;
            function doSave(postId, accountId) {
                console.log(postId + "," + accountId);
                const d = {
                    accountId: accountId,
                    postId: postId,
                    operation: 'save'
                }
                const u = {
                    accountId: accountId,
                    postId: postId,
                    operation: 'unsave'
                }
                var imgElement = document.getElementById('imgSave');
                $.ajax({
                    url: "PostSavedServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if (data.trim() == 'save') {
                            imgElement.src = './images/save_black.png';
                        } else if (data.trim() == 'unsave') {
                            imgElement.src = './images/save-instagram.png';
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data)
                    }

                });
            }
            ;







        </script>


        <script src="js/main.js"></script>

        <!--For image modal-->
        <style>
            .img-thumbnail {
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
                width: 100%;
                max-width: 300px;
                margin: 10px;
            }

            .img-thumbnail:hover {
                opacity: 0.7;
            }

            /* The Modal (background) */
            .image-modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
            }

            /* Modal Content (image) */
            .image-modal-content {
                top: 100px;
                margin: auto;
                display: block;

                max-width: 500px;
                max-height: 700px;
            }

            /* Caption of Modal Image */
            #caption {
                margin: auto;
                display: block;
                width: 80%;
                max-width: 700px;
                text-align: center;
                color: #ccc;
                padding: 10px 0;
                height: 150px;
            }

            /* Add Animation */
            .image-modal-content, #caption {
                -webkit-animation-name: zoom;
                -webkit-animation-duration: 0.6s;
                animation-name: zoom;
                animation-duration: 0.6s;
            }

            @-webkit-keyframes zoom {
                from {
                    -webkit-transform:scale(0)
                }
                to {
                    -webkit-transform:scale(1)
                }
            }

            @keyframes zoom {
                from {
                    transform:scale(0)
                }
                to {
                    transform:scale(1)
                }
            }

            /* The Close Button */
            .close1 {
                position: absolute;
                top: 70px;
                right: 35px;
                color: #f1f1f1;
                font-size: 40px;
                font-weight: bold;
                transition: 0.3s;
            }

            .close1:hover,
            .close1:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }

            /* 100% Image Width on Smaller Screens */
            @media only screen and (max-width: 700px){
                .image-modal-content {
                    width: 100%;
                }
            }
        </style>


        <!--For image modal -->
        <script>
            // Get the modal
            var modal = document.getElementById("myModal");

            // Get the images and insert the clicked image inside the modal - use its "alt" text as a caption
            var images = document.getElementsByClassName("img-thumbnail");
            var modalImg = document.getElementById("img01");
            var captionText = document.getElementById("caption");

            for (let i = 0; i < images.length; i++) {
                images[i].onclick = function () {
                    modal.style.display = "block";
                    modalImg.src = this.src;
                    captionText.innerHTML = this.alt;
                }
            }

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close1")[0];

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }
        </script>


        <!--For slider-->
        <style>



            .caption pre {
                white-space: pre-wrap; /* Preserve line breaks and wrap text */
                word-wrap: break-word; /* Allow breaking long words */
                overflow-wrap: break-word; /* Ensure long words break within the container */
                max-width: 100%; /* Prevent the pre tag from overflowing its container */
                overflow: hidden; /* Hide any overflowed content */
            }

            a {
                cursor: pointer;
            }

            a:hover {
                text-decoration: none;
            }

            .section {
                position: relative;
                width: 100%;
                display: block;
            }


            .over-hide {
                overflow: hidden;
            }




        </style>

        <!--For edit button-->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelector('.edit').addEventListener('click', function () {
                    var dropdownMenu = this.querySelector('.dropdown-menu');
                    dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
                });
                document.addEventListener('click', function (event) {
                    var isClickInside = document.querySelector('.edit').contains(event.target);
                    if (!isClickInside) {
                        document.querySelector('.dropdown-menu').style.display = 'none';
                    }
                });
            });
            document.getElementById('delete-post').addEventListener('click', function (event) {
                event.preventDefault();
                if (confirm('Bạn có muốn xóa nhà hàng này không?')) {
                    window.location.href = '/SWP391/deleteRestaurant?restaurantId=${requestScope.restaurant.restaurantId}';
                }
            });
        </script>

        <script>
            // Function to create a File object
            function createFileObject(url, name) {
                return fetch(url)
                        .then(res => res.blob())
                        .then(blob => new File([blob], name, {type: blob.type}));
            }

// Function to add initial files to the input element
            function addInitialFiles() {
                console.log('running');

                const input = document.getElementById('inputUp3');
                const files = [

                    {url: '${requestScope.restaurant.avatarPath}', name: 'avatar.jpg'}


                ];

                console.log(files);


                Promise.all(files.map(file => createFileObject(file.url, file.name)))
                        .then(fileObjects => {
                            const dataTransfer = new DataTransfer();
                            fileObjects.forEach(file => dataTransfer.items.add(file));
                            input.files = dataTransfer.files;
                            previewFile4();
                        })
                        .catch(error => console.error('Error adding initial files:', error));
            }





// Call the function to add initial files when the page loads
            window.onload = function () {
                addInitialFiles();
            };
        </script>

        <script type="text/javascript">
            <%
            // Lấy giá trị của attribute 'message' từ request
            String message = (String) request.getAttribute("message");
            %>
            // Hàm hiển thị thông báo
            function showMessage(message) {
                if (message) {
                    alert(message);
                }
            }

            // Gọi hàm showMessage với giá trị của 'message' từ server
            showMessage('<%= message != null ? message : "" %>');
        </script>

        <script src="js/slider.js"></script>
    </body>

</html>

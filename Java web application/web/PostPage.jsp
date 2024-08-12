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




        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.6/css/unicons.css">
        <link rel="stylesheet" href="css/postStyle.css">

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
                    <c:if test="${sessionScope.AccDetail!=null}" >
                        <c:if test="${sessionScope.AccDetail.role==1}">

                            <%
                                ReactDAO rd = new ReactDAO();
                                PostSavedDAO psd = new PostSavedDAO();
                                String postId = (String) request.getParameter("postId");
                                int pid = Integer.parseInt(postId);
                                AccountDetail accDetail = (AccountDetail) session.getAttribute("AccDetail");
                                int accountId = accDetail.getAccountId();
                                System.out.println("accountId: "+accountId);
                                boolean isLiked = rd.isLikeByUser(pid, accountId);
                                System.out.println("isLiked "+isLiked);
                                boolean isSaved = psd.isSavedByUser(pid,accountId);
                                System.out.println("isSaved "+isSaved);

                            %>
                            <!-- Sidebar -->
                            <div class="sidebar">
                                <div class="postBtn like">
                                    <% if (isLiked) { %>
                                    <img onclick="doLike('${requestScope.post.postId}', '${sessionScope.AccDetail.getAccountId()}')" id="imgLike" class="love" src="./images/heart.png">
                                    <% } else{ %>
                                    <img onclick="doLike('${requestScope.post.postId}', '${sessionScope.AccDetail.getAccountId()}')" id="imgLike" class="love" src="./images/love.png">
                                    <% } %>
                                </div>

                                <span class="like-counter"><%= rd.countLikeOnPost(pid)%></span>
                                <div class="postBtn chat">
                                    <a href="#comments">
                                        <button type="button" class="btn p-0">
                                            <img src="./images/bubble-chat.png">
                                        </button>
                                    </a>
                                </div>

                                <div class="postBtn save">
                                    <% if (isSaved) { %>
                                    <img onclick="doSave('${requestScope.post.postId}', '${sessionScope.AccDetail.getAccountId()}')" id="imgSave" class="save" src="./images/save_black.png">
                                    <% } else{ %>
                                    <img onclick="doSave('${requestScope.post.postId}', '${sessionScope.AccDetail.getAccountId()}')" id="imgSave" class="save" src="./images/save-instagram.png">
                                    <% } %>
                                </div>

                                <a class="postBtn" data-toggle="modal" data-target="#exampleModal2">
                                    <img class="" src="./images/report-flag.png">

                                </a>

                            </div>
                        </c:if>
                    </c:if>
                </div>
                <!-- End of Left -->

                <div class="middle">

                    <div class="feeds">

                        <c:if test="${sessionScope.AccDetail.role==2}">
                            <div class="feed">
                                <div class="head">
                                    <div class="user">
                                        <div class="info">
                                            <h3>Ảnh bằng chứng đã đến quán</h3>

                                        </div>
                                    </div>

                                </div>

                                <div style="display: flex; overflow-x: scroll">
                                    <c:forEach items="${requestScope.post.proofPaths}" var="i">
                                        <img src="${i}" class="img-thumbnail" alt="pic" style="width: 30%; margin-right: 10px; border-radius: 5px">
                                    </c:forEach>
                                </div>




                            </div>
                        </c:if>

                        <div class="feed">
                            <div class="head">
                                <div class="user" style="display: flex; justify-content: center; align-items: center">
                                    <div class="profile-photo">
                                        <img src="${requestScope.posterAccount.getAvatarPath()}" alt="pic">
                                    </div>
                                    <div class="info">
                                        <h3>${requestScope.posterAccount.getName()}</h3>
                                        <small>${requestScope.post.getFormattedDate()}</small>
                                    </div>
                                </div>
                                <c:if test="${post.status==2}">
                                    <p style="color:blue">Bài viết này chưa được duyệt</p>
                                </c:if>
                                <c:if test="${post.status==3}">
                                    <p style="color:red">Bài viết này không được duyệt vì: ${post.reasonDeny}</p>
                                </c:if>
                                <c:if test="${post.status==5 && posterAccount.accountId == sessionScope.AccDetail.accountId}">
                                    <p style="color:blue">Bài viết này đang chờ duyệt chỉnh sửa</p>
                                </c:if>
                                <c:if test="${post.status==6 && posterAccount.accountId == sessionScope.AccDetail.accountId}">
                                    <p style="color:darkred">Bài viết bị báo cáo và xóa vì: ${post.reasonDeny}</p>
                                </c:if>

                                <c:if test="${sessionScope.AccDetail.accountId==requestScope.posterAccount.accountId}">
                                    <span class="edit">
                                        <i class="uil uil-ellipsis-h"></i>
                                        <div class="dropdown-menu" style="z-index: 800">
                                            <a href="#" class="dropdown-item" id="edit-post" data-toggle="modal" data-target="#exampleModal">Chỉnh sửa</a>
                                            <a href="#" class="dropdown-item" id="delete-post">Xóa</a>
                                        </div>
                                    </span>
                                </c:if>
                            </div>

                            <c:if test="${requestScope.post.imagePaths.size()!=0}">
                                <div class="section mx-auto text-center slider-height-padding" style="margin-bottom: 20px;">

                                    <input class="checkbox image1" type="radio" id="slide-1" name="slider" checked/>
                                    <label for="slide-1"></label>

                                    <c:if test="${requestScope.post.getImagePaths().size()!=0}">
                                        <c:forEach begin="${1}" end="${requestScope.post.imagePaths.size()-1}" var="i">
                                            <input class="checkbox image${i+1}" type="radio" id="slide-${i+1}" name="slider"/>
                                            <label for="slide-${i+1}"></label>
                                        </c:forEach>
                                    </c:if>    

                                    <!--
                                    <input class="checkbox frst" type="radio" id="slide-1" name="slider" checked />
                                    <label for="slide-1"></label>
                                    <input class="checkbox scnd" type="radio" name="slider" id="slider-2" />
                                    <label for="slider-2"></label>
                                    <input class="checkbox thrd" type="radio" name="slider" id="slider-3" />
                                    <label for="slider-3"></label>
                                    <input class="checkbox foth" type="radio" name="slider" id="slider-4" />
                                    <label for="slider-4"></label>
                                    -->



                                    <ul>

                                        <c:if test="${p.getImagePaths().size()!=0}">
                                            <c:forEach begin="${1}" end="${requestScope.post.imagePaths.size()}" var="i">
                                                <li>

                                                </li>
                                            </c:forEach>
                                        </c:if>

                                    </ul>
                                </div>
                            </c:if>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-user"></i>Phục vụ:</span></h6>

                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.serviceRating}" step="0.1" class="slider" id="myRange6" name="serviceRating" disabled>
                                    <h6>&#160;&#160;<span id="demo6">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-money-bill"></i>Giá cả:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.priceRating}" step="0.1" class="slider" id="myRange7" name="priceRating" disabled>
                                    <h6>&#160;&#160;<span id="demo7">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-home"></i>Không gian:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.spaceRating}" step="0.1" class="slider" id="myRange8" name="spaceRating" disabled>
                                    <h6>&#160;&#160;<span id="demo8">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-restaurant"></i>Hương vị:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.tasteRating}" step="0.1" class="slider" id="myRange9" name="tasteRating" disabled>
                                    <h6>&#160;&#160;<span id="demo9">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-trash-alt"></i>Vệ sinh:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.hygieneRating}" step="0.1" class="slider" id="myRange10" name="hygieneRating" disabled>
                                    <h6>&#160;&#160;<span id="demo10">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>        
                            <div style="display: flex; align-items: center">
                                <svg xmlns="http://www.w3.org/2000/svg" font-size="2rem" position="relative" width="1em" height="1em" viewBox="0 0 128 128"><path fill="#ad0b0b" d="m68.05 7.23l13.46 30.7a7.047 7.047 0 0 0 5.82 4.19l32.79 2.94c3.71.54 5.19 5.09 2.5 7.71l-24.7 20.75c-2 1.68-2.91 4.32-2.36 6.87l7.18 33.61c.63 3.69-3.24 6.51-6.56 4.76L67.56 102a7.033 7.033 0 0 0-7.12 0l-28.62 16.75c-3.31 1.74-7.19-1.07-6.56-4.76l7.18-33.61c.54-2.55-.36-5.19-2.36-6.87L5.37 52.78c-2.68-2.61-1.2-7.17 2.5-7.71l32.79-2.94a7.047 7.047 0 0 0 5.82-4.19l13.46-30.7c1.67-3.36 6.45-3.36 8.11-.01"/><path fill="#ff9494" d="m67.07 39.77l-2.28-22.62c-.09-1.26-.35-3.42 1.67-3.42c1.6 0 2.47 3.33 2.47 3.33l6.84 18.16c2.58 6.91 1.52 9.28-.97 10.68c-2.86 1.6-7.08.35-7.73-6.13"/><path fill="#f50000" d="M95.28 71.51L114.9 56.2c.97-.81 2.72-2.1 1.32-3.57c-1.11-1.16-4.11.51-4.11.51l-17.17 6.71c-5.12 1.77-8.52 4.39-8.82 7.69c-.39 4.4 3.56 7.79 9.16 3.97"/></svg>

                                <p style="font-size: 1.5em; line-height: 1em; margin: 3px;">${requestScope.post.rating}/5 điểm</p>
                            </div>
                            <div class="caption" style="margin-top: 30px">

                                <h3>${requestScope.post.title} </h3>     <br>
                                <pre class="post-text"><h6>${requestScope.post.text}</h6></pre>

                            </div>


                        </div>
                    </div>




                    <c:if test="${sessionScope.AccDetail!=null}">
                        <c:if test="${sessionScope.AccDetail.role==1}">
                            <div class="modal-footer">
                                <form id="commentForm" style="display: flex">
                                    <input type="hidden" id="postId" name="postId" value="${requestScope.post.postId}" /> 
                                    <input type="hidden" id="postId" name="accountId" value="${sessionScope.AccDetail.getAccountId()}" /> 
                                    <div class="input" style="width:90% ;display: flex ; align-items: center">
                                        <img src="${sessionScope.AccDetail.getAvatarPath()}" alt="">
                                        <input type="text" id="emoji_comment" name="comment" placeholder="Viết bình luận..." />
                                    </div>
                                    <input class="btn btn-primary" type="button" value="Gửi" onclick="submitForm()">
                                </form>            
                            </div>  
                        </c:if>
                    </c:if>            



                    <div class="comments" id="comments">
                        <c:forEach items="${requestScope.commentMap}" var="i">
                            <c:if test="${i.value.status==1}">
                                <div class="comment">
                                    <div class="d-flex">
                                        <div class="img">
                                            <img src="${i.key.avatarPath}" alt="">
                                        </div>
                                        <div class="content">
                                            <div class="person">
                                                <h4>${i.key.name}</h4>
                                                <span>${i.value.getFormattedDate()}</span>
                                            </div>
                                            <p>${i.value.text}</p>
                                        </div>
                                    </div>

                                    <div style="display: flex; justify-content: flex-end; align-items: center">

                                        <div class="like comment-like" data-comment-id="${i.value.commentId}" onclick="toggleLike('${i.value.commentId}')">
                                            <c:if test="${i.value.reactAccounts.contains(sessionScope.AccDetail.accountId)}">
                                                <img class="loved" src="./images/heart.png" alt="Loved" style="display: inline-block">
                                            </c:if>
                                            <c:if test="${!i.value.reactAccounts.contains(sessionScope.AccDetail.accountId)}">
                                                <img class="not_loved" src="./images/love.png" alt="Not Loved" style="display: inline-block">
                                            </c:if>
                                            <p>${i.value.reactAccounts.size()}</p>
                                        </div>

                                        <c:if test="${sessionScope.AccDetail.accountId==i.key.accountId}">

                                            <i class="uil uil-trash-alt delete-comment" data-comment-id="${i.value.commentId}" onclick="toggleDelete('${i.value.commentId}')" style="cursor: pointer"></i>


                                        </c:if>
                                    </div>    

                                </div>
                            </c:if>
                        </c:forEach>
                    </div>


                </div>

                <div class="right">
                    <a class="profile" href="Profile?accountId=${requestScope.posterAccount.accountId}&page=1" style="margin-bottom: 1rem">
                        <div class="profile-photo">
                            <img src="${requestScope.posterAccount.getAvatarPath()}" alt="">
                        </div>
                        <div class="handle">
                            <h4>${requestScope.posterAccount.name}</h4>
                        </div>
                    </a>

                    <div class="restaurants-modal">


                        <div class="restaurant">
                            <div class="head">
                                <a class="user" href="RestaurantPage?restaurantId=${restaurant.restaurantId}" style="text-decoration: none; color: black">
                                    <div class="profile-photo">
                                        <img src="${requestScope.restaurant.avatarPath}" alt="pic">
                                    </div>
                                    <div class="info">
                                        <h5>${requestScope.restaurant.name}</h5>
                                        <small>Địa chỉ: ${requestScope.restaurant.address}</small><br>
                                        <small>Số điện thoại: ${requestScope.restaurant.phoneNumber}</small>
                                    </div>
                                    <c:if test="${restaurant.status==2}">
                                        <p style="color:blue">Địa điểm này chưa được duyệt</p>
                                    </c:if>
                                    <c:if test="${restaurant.status==3}">
                                        <p style="color:red">Địa điểm này không được duyệt vì: ${restaurant.reasonDeny}</p>
                                    </c:if>    

                                </a>

                            </div>
                        </div>


                    </div>

                    <a class="profile" href="Profile?accountId=${requestScope.posterAccount.accountId}&page=1">
                        <iframe
                            id="map"
                            loading="lazy"
                            allowfullscreen
                            src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAj6t7ZZxyY1pmYURedsxUu9uUzV0bj-iw&q=${requestScope.restaurant.address}"
                            style="width: 100%; height: 300px">
                        </iframe>
                    </a>

                    <!-- End of Message -->
                </div>
            </div>
        </main>

        <!-- The image Modal -->
        <div id="myModal" class="image-modal" style="z-index: 100">
            <span class="close1">&times;</span>
            <img class="image-modal-content" id="img01">
        </div>

        <!-- Post Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 50%;">
                <div class="modal-content">
                    <form id="postForm" action="createEditPost" method="post" enctype="multipart/form-data">
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

                            <input type="hidden" name="editOfPostId" value="${requestScope.post.postId}" >

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

                                        <input class="form-check-input" type="checkbox" name="mealType" value="1" id="breakfast" <c:forEach items="${requestScope.post.mealList}" var="i"><c:if test="${i==1}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="breakfast">Ăn sáng</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="mealType" value="2" id="lunch" <c:forEach items="${requestScope.post.mealList}" var="i"><c:if test="${i==2}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="lunch">Ăn trưa</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="mealType" value="3" id="dinner" <c:forEach items="${requestScope.post.mealList}" var="i"><c:if test="${i==3}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="dinner">Ăn tối</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="mealType" value="4" id="snack" <c:forEach items="${requestScope.post.mealList}" var="i"><c:if test="${i==4}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="snack">Ăn vặt</label>
                                            </div>
                                        </div>
                                        <!-- Checkbox 2: Food Types -->
                                        <div class="form-group">
                                            <label>Chọn loại thức ăn:</label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="foodType" value="1" id="food" <c:forEach items="${requestScope.post.foodList}" var="i"><c:if test="${i==1}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="food">Đồ ăn</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="foodType" value="2" id="drink" <c:forEach items="${requestScope.post.foodList}" var="i"><c:if test="${i==2}">checked</c:if></c:forEach>>
                                                <label class="form-check-label" for="drink">Đồ uống</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="slidecontainer">
                                        <h6><span><i class="uil uil-user"></i>Phục vụ:</span></h6>

                                        <div style="width: 100%; display: flex; align-items: center">
                                            <input type="range" min="0" max="5" value="${requestScope.post.serviceRating}" step="0.1" class="slider" id="myRange1" name="serviceRating">
                                    <h6>&#160;&#160;<span id="demo1">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-money-bill"></i>Giá cả:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.priceRating}" step="0.1" class="slider" id="myRange2" name="priceRating">
                                    <h6>&#160;&#160;<span id="demo2">2.5</span>/5 Điểm</h6>
                                </div> 
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-home"></i>Không gian:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.spaceRating}" step="0.1" class="slider" id="myRange3" name="spaceRating">
                                    <h6>&#160;&#160;<span id="demo3">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-restaurant"></i>Hương vị:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.tasteRating}" step="0.1" class="slider" id="myRange4" name="tasteRating">
                                    <h6>&#160;&#160;<span id="demo4">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="slidecontainer">
                                <h6><span><i class="uil uil-trash-alt"></i>Vệ sinh:</span></h6>
                                <div style="width: 100%; display: flex; align-items: center">
                                    <input type="range" min="0" max="5" value="${requestScope.post.hygieneRating}" step="0.1" class="slider" id="myRange5" name="hygieneRating">
                                    <h6>&#160;&#160;<span id="demo5">2.5</span>/5 Điểm</h6>
                                </div>
                            </div>
                            <div class="form-group" style="display: flex; align-items: center; justify-content: flex-start">
                                <h6 for="rating" style="width: 30%; margin: 0;">Điểm tổng quát: </h6>
                                <input type="number" class="form-control" id="rating" name="rating" min="0" max="5" step="0.1" required readonly style="border: none; width: 10%; font-size: 22px;">
                                <svg xmlns="http://www.w3.org/2000/svg" font-size="2rem" position="relative" width="1em" height="1em" viewBox="0 0 128 128"><path fill="#ad0b0b" d="m68.05 7.23l13.46 30.7a7.047 7.047 0 0 0 5.82 4.19l32.79 2.94c3.71.54 5.19 5.09 2.5 7.71l-24.7 20.75c-2 1.68-2.91 4.32-2.36 6.87l7.18 33.61c.63 3.69-3.24 6.51-6.56 4.76L67.56 102a7.033 7.033 0 0 0-7.12 0l-28.62 16.75c-3.31 1.74-7.19-1.07-6.56-4.76l7.18-33.61c.54-2.55-.36-5.19-2.36-6.87L5.37 52.78c-2.68-2.61-1.2-7.17 2.5-7.71l32.79-2.94a7.047 7.047 0 0 0 5.82-4.19l13.46-30.7c1.67-3.36 6.45-3.36 8.11-.01"/><path fill="#ff9494" d="m67.07 39.77l-2.28-22.62c-.09-1.26-.35-3.42 1.67-3.42c1.6 0 2.47 3.33 2.47 3.33l6.84 18.16c2.58 6.91 1.52 9.28-.97 10.68c-2.86 1.6-7.08.35-7.73-6.13"/><path fill="#f50000" d="M95.28 71.51L114.9 56.2c.97-.81 2.72-2.1 1.32-3.57c-1.11-1.16-4.11.51-4.11.51l-17.17 6.71c-5.12 1.77-8.52 4.39-8.82 7.69c-.39 4.4 3.56 7.79 9.16 3.97"/></svg>
                            </div>
                            <div class="media mb-3">
                                <div class="media-body">
                                    <textarea class="autosize" placeholder="Tiêu đề" rows="1" id="note" name="title" data-emoji="true" >${requestScope.post.title}</textarea>
                                    <textarea class="autosize" placeholder="Nội dung" rows="5" id="note" name="text" data-emoji="true">${requestScope.post.text}</textarea>
                                    <div class="position-relative">
                                        <input type="file" class="d-none" accept="audio/*|video/*|video/x-m4v|video/webm|video/x-ms-wmv|video/x-msvideo|video/3gpp|video/flv|video/x-flv|video/mp4|video/quicktime|video/mpeg|video/ogv|.ts|.mkv|image/*|image/heic|image/heif" onchange="previewFiles()" id="inputUp" name="files" multiple>
                                    </div>
                                </div>
                            </div>
                            <a class="mediaUp mr-4"><i class="material-icons mr-2" data-tippy="add (Video, Audio, Photo)" onclick="trgger('inputUp')">perm_media</i>Thêm ảnh/video</a>
                        </div>
                        <div class="row col-md-12 ml-auto mr-auto preview"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-info btn-sm">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div> 

        <!-- Report Modal -->
        <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width: 30%;">
                <div class="modal-content">
                    <form id="postForm" action="createPostReport" method="post">
                        <input type="hidden" name="accountId" value="${sessionScope.AccDetail.accountId}">
                        <div class="indicator"></div>
                        <div class="modal-header" style="display: flex; justify-content: flex-start">
                            <h5 class="modal-title" id="exampleModalLabel">Report bài viết</h5>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <input type="hidden" name="postId" value="${requestScope.post.postId}" >

                            <div class="form-group">
                                <label>Tại sao bạn báo cáo bài viết này?</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report1" name="reportId" value="1" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report1">Nội dung không liên quan đến địa điểm</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report2" name="reportId" value="2" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report2">Hình ảnh đồi trụy</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report3" name="reportId" value="3" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report3">Bài viết PR/Quảng cáo</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report4" name="reportId" value="4" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report4">Nội dung sai lệch/ Tin giả</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report5" name="reportId" value="5" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report5">Từ ngữ bài post không phù hợp</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report6" name="reportId" value="6" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report6">Bài viết rác/ Spam</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="report7" name="reportId" value="7" style="position: absolute; left: 2rem;">
                                    <label class="form-check-label" for="report7">Khác</label>
                                </div>
                            </div>





                            <div class="media mb-3">
                                <div class="media-body">

                                    <textarea class="autosize" placeholder="Điền nội dung" rows="5" id="note" name="text" data-emoji="true"></textarea>

                                </div>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-info btn-sm">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>                            

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





            $(document).ready(function () {
                $("#emoji_comment").emojioneArea({
                    pickerPosition: "bottom",
                    tonesStyle: "radio"
                });
            });
            function submitForm() {
                var formData = new FormData(document.getElementById("commentForm"));
                var dataObject = {};
                // Convert formData to a plain object and check for empty comment
                var hasComment = false;
                formData.forEach(function (value, key) {
                    dataObject[key] = value;
                    if (key === "comment" && value.trim() !== "") {
                        hasComment = true;
                    }
                });
                if (!hasComment) {
                    // If the comment field is empty, show an alert or handle the case as needed
                    alert("Vui lòng nhập bình luận trước khi gửi.");
                    return;
                }

                // Log the dataObject to verify the data
                console.log(dataObject);
                // Send the data using AJAX
                $.ajax({
                    type: "POST",
                    url: "comment",
                    data: dataObject,
                    success: function (response) {
                        // Handle the response from the server
                        $("#comments").prepend(response);
                        document.getElementById("commentForm").reset();
                        $("#emoji_comment").data("emojioneArea").setText('');
                    },
                    error: function (xhr, status, error) {
                        // Handle any errors
                        console.error("An error occurred: " + error);
                    }
                });
            }

            function toggleLike(commentId) {
                var likeElement = document.querySelector('.comment-like[data-comment-id="' + commentId + '"]');
                var imgElement = likeElement.querySelector('img');
                var likeCountElement = likeElement.querySelector('p');

                // Toggle the image src
                if (imgElement.src.includes('heart.png')) {
                    imgElement.src = './images/love.png';
                    // Update like count (decrement)
                    likeCountElement.textContent = parseInt(likeCountElement.textContent) - 1;
                } else {
                    imgElement.src = './images/heart.png';
                    // Update like count (increment)
                    likeCountElement.textContent = parseInt(likeCountElement.textContent) + 1;
                }

                console.log(commentId);



                $.ajax({
                    type: "POST",
                    url: "commentReact",
                    data: {
                        accountId: '${sessionScope.AccDetail.getAccountId()}',
                        commentId: commentId // Assuming commentId is defined in your context
                    },

                    error: function (xhr, status, error) {
                        // Handle any errors

                    }
                }
                );






            }



        </script>


        <script src="js/main.js"></script>
        <script src="js/slider.js"></script> 

        <!--For image slider-->
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



            [type="radio"]:checked,
            [type="radio"]:not(:checked) {
                position: absolute;
                left: -9999px;
            }

            .checkbox:checked+label,
            .checkbox:not(:checked)+label {
                position: relative;
                cursor: pointer;
                margin: 0 auto;
                text-align: center;
                margin-right: 6px;
                margin-left: 6px;
                display: inline-block;
                width: 50px;
                height: 50px;
                border: 3px solid #bdc3c7;
                background-size: cover;
                background-position: center;
                box-sizing: border-box;
                -webkit-transition: all 0.2s ease;
                transition: all 0.2s ease;
                <c:if test="${requestScope.post.getImagePaths().size()!=0}">
                    background-image: url('${requestScope.post.imagePaths.get(0)}');
                </c:if>
                animation: border-transform 6s linear infinite alternate forwards;
                -webkit-animation-play-state: paused;
                -moz-animation-play-state: paused;
                animation-play-state: paused;
            }

            <c:if test="${requestScope.post.getImagePaths().size()!=0}">
                <c:forEach var="i" begin="1" end="${requestScope.post.imagePaths.size() - 1}">
                    .checkbox.image${i+1} + label {
                        background-image: url('${requestScope.post.imagePaths[i]}');
                    }
                </c:forEach>
            </c:if>


            .checkbox:checked+label {
                box-shadow: 0 8px 25px 0 rgba(16, 39, 112, .3);
                transform: scale(1.3);
                -webkit-animation-play-state: running;
                -moz-animation-play-state: running;
                animation-play-state: running;
            }

            @keyframes border-transform {

                0%,
                100% {
                    border-radius: 63% 37% 54% 46% / 55% 48% 52% 45%;
                }

                14% {
                    border-radius: 40% 60% 54% 46% / 49% 60% 40% 51%;
                }

                28% {
                    border-radius: 54% 46% 38% 62% / 49% 70% 30% 51%;
                }

                42% {
                    border-radius: 61% 39% 55% 45% / 61% 38% 62% 39%;
                }

                56% {
                    border-radius: 61% 39% 67% 33% / 70% 50% 50% 30%;
                }

                70% {
                    border-radius: 50% 50% 34% 66% / 56% 68% 32% 44%;
                }

                84% {
                    border-radius: 46% 54% 50% 50% / 35% 61% 39% 65%;
                }
            }

            .slider-height-padding {
                padding-top: 440px;
            }

            ul {
                position: absolute;
                top: 0;
                left: 0;
                display: block;
                width: 100%;
                z-index: 100;
                padding: 0;
                margin: 0;
                list-style: none;
            }

            ul li {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                display: block;
                z-index: 100;
                padding: 0;
                margin: 0;
                list-style: none;
                min-height: 400px;
                /* Ensure the list items have a minimum height */
                border: 5px solid #bdc3c7;
                border-radius: 10px;
                background-size: contain;
                /* Maintain aspect ratio */
                background-position: center;
                background-repeat: no-repeat;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
                font-weight: 900;
                font-size: 16px;
                letter-spacing: 2px;
                line-height: 2.7;
                color: #343434;
                writing-mode: vertical-rl;
                opacity: 0;
                pointer-events: none;
                box-shadow: 0 8px 25px 0 rgba(16, 39, 112, .1);
                -webkit-transition: all 0.5s ease;
                transition: all 0.5s ease;
            }

            ul li span {
                mix-blend-mode: difference;
            }

            <c:if test="${requestScope.post.getImagePaths().size()!=0}">
                <c:forEach var="i" begin="0" end="${requestScope.post.imagePaths.size() - 1}">
                    ul li:nth-child(${i+1}) {
                        background-image: url('${requestScope.post.imagePaths[i]}');
                    }

                </c:forEach>
            </c:if>


            <c:if test="${requestScope.post.getImagePaths().size()!=0}">
                <c:forEach var="i" begin="0" end="${requestScope.post.imagePaths.size() - 1}">
                    .checkbox.image${i+1}:checked~ul li:nth-child(${i+1}) {
                        opacity: 1;
                        pointer-events: auto;
                    }

                </c:forEach>
            </c:if>


            .logoXYZ img {
                height: 26px;
                width: auto;
                display: block;
            }

            @media (max-width: 767px) {
                .slider-height-padding {
                    padding-top: 340px;
                }

                ul li {
                    font-size: 13px;
                    letter-spacing: 1px;
                }
            }

            @media (max-width: 575px) {
                .slider-height-padding {
                    padding-top: 240px;
                }
            }
        </style>

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
                if (confirm('Bạn có muốn xóa bài viết này không?')) {
                    window.location.href = '/SWP391/deletePost?postId=${requestScope.post.postId}';
                }
            });



            function toggleDelete(commentId) {


                if (confirm('Bạn có muốn xóa bình luận này không?')) {
                    window.location.href = `/SWP391/deleteComment?commentId=` + commentId + '&postId=${requestScope.post.postId}';
                }
            }


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

                const input = document.getElementById('inputUp');
                const files = [
            <c:if test="${requestScope.post.imagePaths.size()!=0}">
                <c:forEach var="i" begin="0" end="${requestScope.post.imagePaths.size() - 1}" varStatus="status">
                { url: '${requestScope.post.imagePaths[i]}', name: 'image${status.index + 1}.jpg' }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            </c:if>
                ];

                console.log(files);


                Promise.all(files.map(file => createFileObject(file.url, file.name)))
                        .then(fileObjects => {
                            const dataTransfer = new DataTransfer();
                            fileObjects.forEach(file => dataTransfer.items.add(file));
                            input.files = dataTransfer.files;
                            previewFiles();
                        })
                        .catch(error => console.error('Error adding initial files:', error));
            }

            function addInitialFiles2() {
                console.log('running');

                const input = document.getElementById('inputUp2');
                const files = [
            <c:if test="${requestScope.post.proofPaths.size()!=0}">
                <c:forEach var="i" begin="0" end="${requestScope.post.proofPaths.size() - 1}" varStatus="status">
                { url: '${requestScope.post.proofPaths[i]}', name: 'proofImage${status.index + 1}.jpg' }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            </c:if>
                ];

                console.log(files);


                Promise.all(files.map(file => createFileObject(file.url, file.name)))
                        .then(fileObjects => {
                            const dataTransfer = new DataTransfer();
                            fileObjects.forEach(file => dataTransfer.items.add(file));
                            input.files = dataTransfer.files;
                            previewFiles2();
                        })
                        .catch(error => console.error('Error adding initial files:', error));
            }



// Call the function to add initial files when the page loads
            window.onload = function () {
                addInitialFiles();
                addInitialFiles2();
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

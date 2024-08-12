<%-- 
    Document   : Feed.jsp
    Created on : May 30, 2024, 3:07:57 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Social Media Clone</title>

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
        <link rel="stylesheet" href="css/style.css">

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
                        <label for="create-post" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Đăng bài</label>
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
                    <c:if test="${sessionScope.AccDetail!=null}">
                        <a class="profile" href="Profile?accountId=${sessionScope.AccDetail.accountId}&page=1">
                            <div class="profile-photo">
                                <img src="${sessionScope.AccDetail.avatarPath}" alt="">
                            </div>
                            <div class="handle">
                                <h4>${sessionScope.AccDetail.name}</h4>

                            </div>
                        </a>
                    </c:if> 
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
                        <a class="menu-item active" href="Explore">
                            <span><i class="uil uil-compass"></i></span>
                            <h3>Khám phá</h3>
                        </a>

                    </div>
                    <c:if test="${sessionScope.AccDetail!=null}">
                        <label for="create-post" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Đăng bài</label>
                    </c:if>  

                </div>
                
                <!-- End of Left -->

                <div class="middle">
                    
                    <h1 style="color: black">Kết quả tìm kiếm cho "${requestScope.searchText}"</h1>
                    
                    <!-- Feeds -->
                    <div class="feeds">

                        <c:forEach items="${requestScope.postMap}" var="p">
                            <div class="feed">
                                <div class="head">
                                    <div class="user">
                                        <div class="profile-photo">
                                            <img src="${p.key.avatarPath}" alt="pic">
                                        </div>
                                        <div class="info">
                                            <h5>${p.key.name}</h5>
                                        </div>
                                    </div>
                                    <span class="edit">
                                        <i class="uil uil-ellipsis-h"></i>
                                    </span>
                                </div>
                                <small>${p.value.getFormattedDate()}</small>
                                <a href="PostPage?postId=${p.value.postId}">
                                    <div class="photo">
                                        <c:if test="${p.value.getImagePaths().size()!=0}">
                                            <td><img src="${p.value.getImagePaths().get(0)}" alt="alt"/></td>
                                            </c:if>
                                    </div>
                                </a>    
                                <div class="desc">
                                    <div class="icons">
                                        <div class="icon_left d-flex">
                                            <div class="like">
                                                <img class="not_loved" src="./images/love.png">
                                                <img class="loved" src="./images/heart.png">
                                            </div>
                                            <div class="chat">
                                                <button type="button" class="btn p-0" data-bs-toggle="modal"
                                                        data-bs-target="#message_modal">
                                                    <img src="./images/bubble-chat.png">
                                                </button>
                                            </div>
                                        </div>
                                        <div class="save not_saved">
                                            <img class="hide saved" src="./images/save_black.png">
                                            <img class="not_saved" src="./images/save-instagram.png">
                                        </div>
                                    </div>
                                </div>

                                <div class="caption">
                                    <p><b>${p.value.title}</b> 
                                </div>
                                
                            </div>
                        </c:forEach>


                    </div>

                </div>

                <div class="right">
                    <div class="messages">
                        <div class="heading">
                            <h4>Following</h4><i class="uil uil-edit"></i>
                        </div>

                        <!-- messages category -->

                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-17.jpg">
                            </div>
                            <div class="message-body">
                                <h5>Edem Quist</h5>
                                <p class="text-muted">Just woke up bruh</p>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-3.jpg">
                            </div>
                            <div class="message-body">
                                <h5>France Deila</h5>
                                <p class="text-muted">Recived bruh, thanks</p>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-4.jpg">
                                <div class="active"></div>
                            </div>
                            <div class="message-body">
                                <h5>Jane Doe</h5>
                                <p class="text-muted">Ok</p>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-5.jpg">
                            </div>
                            <div class="message-body">
                                <h5>Daniel Jakson</h5>
                                <p class="text-muted">2 new messages</p>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-6.jpg">
                            </div>
                            <div class="message-body">
                                <h5>Justin Heoi</h5>
                                <p class="text-muted">Lol u right</p>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="message">
                            <div class="profile-photo">
                                <img src="images/profile-7.jpg">
                                <div class="active"></div>
                            </div>
                            <div class="message-body">
                                <h5>Chantel Msiza</h5>
                                <p class="text-muted">Birthday Tomorrow!</p>
                            </div>
                        </div>
                    </div>
                    <!-- End of Message -->
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
                        <div class="modal-header">
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
                            <div class="form-group">
                                <label for="restaurantSearch">Tìm kiếm nhà hàng:</label>
                                <input type="text" class="form-control" id="restaurantSearch" placeholder="Nhập tên nhà hàng">
                            </div>
                            <!-- Restaurant List -->
                            <div class="restaurants-modal mt-2" id="restaurantList">
                                <c:forEach items="${requestScope.restaurants}" var="r">
                                    <div class="restaurant" data-id="${r.restaurantId}" data-name="${r.name}">
                                        <div class="head">
                                            <div class="user">
                                                <div class="profile-photo">
                                                    <img src="${r.avatarPath}" alt="pic">
                                                </div>
                                                <div class="info">
                                                    <h5>${r.name}</h5>
                                                    <small>Địa chỉ: ${r.address}</small><br>
                                                    <small>Số điện thoại: ${r.phoneNumber}</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Hidden input to store the selected restaurant ID -->
                            <input type="hidden" name="restaurantId" id="selectedRestaurantId">
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
                            <div class="form-group">
                                <label for="rating">Điểm(Từ 0 đến 5):</label>
                                <input type="number" class="form-control" id="rating" name="rating" min="0" max="5" step="0.1" required>
                            </div>
                            <div class="media mb-3">
                                <div class="media-body">
                                    <textarea class="autosize" placeholder="Tiêu đề" rows="1" id="note" name="title" data-emoji="true"></textarea>
                                    <textarea class="autosize" placeholder="Nội dung" rows="5" id="note" name="text" data-emoji="true"></textarea>
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
            });

            $(document).ready(function () {
                // Function to filter restaurants based on search query
                $('#restaurantSearch').on('input', function () {
                    var searchQuery = $(this).val().toLowerCase();

                    // Show restaurant list when typing starts
                    if (searchQuery.length > 0) {
                        $('#restaurantList').show();

                        $('.restaurant').each(function () {
                            var restaurantName = $(this).data('name').toLowerCase();
                            if (restaurantName.includes(searchQuery)) {
                                $(this).show();
                            } else {
                                $(this).hide();
                            }
                        });
                    } else {
                        // Hide restaurant list when input is empty
                        $('#restaurantList').hide();
                    }
                });

                // Click event to select a restaurant
                $('.restaurant').click(function () {
                    var restaurantId = $(this).data('id');
                    var restaurantName = $(this).data('name');
                    $('#selectedRestaurantId').val(restaurantId);
                    $('#restaurantSearch').val(restaurantName);
                    $('.restaurant').removeClass('selected');
                    $(this).addClass('selected');
                    $('.restaurant').not(this).hide();
                });
            });

        </script>


        <script src="js/main.js"></script>

    </body>

</html>

<%-- 
    Document   : Explore
    Created on : May 22, 2024, 7:50:12 AM
    Author     : Lenono
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

        <!--For image slider-->
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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
                        <a class="menu-item active" href="Restaurants">
                            <span><i class="uil uil-restaurant"></i></span>
                            <h3>Địa điểm</h3>

                        </a>
                        <a class="menu-item" href="Explore">
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
                    <div class="feeds">

                        <div class="feed">


                            <div class="photo" style="height: 4.35rem">

                                <div style="display: flex; justify-content: space-around; margin-bottom: 1rem">
                                    <div>
                                        <label for="lowestPrice">Giá thấp nhất:&nbsp;</label>
                                        <input type="number" id="lowestPrice" name="lowestPrice" min="0" step="1000" style="width: 30%">
                                        <label>VNĐ</label>
                                    </div>
                                    <div>
                                        <label for="highestPrice">Giá cao nhất:&nbsp;</label>
                                        <input type="number" id="highestPrice" name="highestPrice" min="0" step="1000" style="width: 30%">
                                        <label>VNĐ</label>
                                    </div>
                                </div>
                                <div>
                                    <label>
                                        <input type="checkbox" id="openNow" name="openNow"> Chỉ hiển thị địa điểm đang mở cửa
                                    </label>
                                </div>




                            </div>

                        </div>

                    </div>


                    <a>
                        <form class="create-post">
                            <i class="uil uil-search"></i>
                            <input type="text" placeholder="Tìm kiếm địa điểm theo tên" id="restaurantSearchOnPage">
                        </form>
                    </a>

                    <div class="middle-profileRestaurant">
                        <div class="restaurants">

                            <c:forEach items="${requestScope.restaurants1}" var="r">
                                <c:if test="${r.status==1}">
                                    <div class="restaurant restaurant-page" data-price="${r.lowestPrice}" data-open="${r.isOpenNow()}">
                                        <div class="head">
                                            <a class="user" href="RestaurantPage?restaurantId=${r.restaurantId}" style="text-decoration: none; color: black">
                                                <div class="profile-photo">
                                                    <img src="${r.avatarPath}" alt="pic">
                                                </div>
                                                <div class="info">
                                                    <h5>${r.name}</h5>

                                                    <small><span><i class="uil uil-home"></i>Địa chỉ: ${r.address}</span></small><br>
                                                    <small><span><i class="uil uil-phone"></i>Số điện thoại: ${r.phoneNumber}</span></small>
                                                </div>
                                            </a>
                                           
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                        </div>
                    </div>

                </div>
                <c:if test="${sessionScope.AccDetail!=null}">

                    <div class="right">
                        <div class="messages">
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
                        <!-- End of Message -->


                    </div>
                </c:if>
            </div>
        </main>

        <!-- Theme Customization -->

        <div class="customize-theme">
            <div class="card">
                <h2>Customize your view</h2>
                <p class="text-muted">Manage your font size, color, and background.</p>

                <!-- Font sizes -->

                <div class="font-size">
                    <h4>Font Size</h4>
                    <div>
                        <h6>Aa</h6>
                        <div class="choose-size">
                            <span class="font-size-1"></span>
                            <span class="font-size-2 active"></span>
                            <span class="font-size-3"></span>
                            <span class="font-size-4"></span>
                            <span class="font-size-5"></span>
                        </div>
                        <h3>Aa</h3>
                    </div>
                </div>

                <!-- Primary colors -->
                <div class="color">
                    <h4>Color</h4>
                    <div class="choose-color">
                        <span class="color-1"></span>
                        <span class="color-2"></span>
                        <span class="color-3 active"></span>
                        <span class="color-4"></span>
                        <span class="color-5"></span>
                    </div>
                </div>

                <!-- Background colors -->
                <div class="background">
                    <h4>Background</h4>
                    <div class="choose-bg">
                        <div class="bg-1 active">
                            <span></span>
                            <h5 for="bg-1">Light</h5>
                        </div>
                        <div class="bg-2">
                            <span></span>
                            <h5>Dim</h5> <!--  for="bg-2" -->
                        </div>
                        <div class="bg-3">
                            <span></span>
                            <h5 for="bg-3">Lights out</h5>
                        </div>
                    </div>
                </div>

            </div>
        </div>



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
                                <label for="restaurantSearch">Tìm kiếm địa điểm:</label>
                                <input type="text" class="form-control" id="restaurantSearch" placeholder="Nhập tên địa điểm" required>
                            </div>
                            <!-- Restaurant List -->
                            <div class="restaurants-modal mt-2" id="restaurantList">
                                <c:forEach items="${requestScope.restaurants2}" var="r">
                                    <c:if test="${r.status==1 || r.status==2}">
                                        <div class="restaurant restaurant-modal" data-id="${r.restaurantId}" data-name="${r.name}">
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
                                            <c:if test="${r.status==2}">
                                                <p style="color:blue">Địa điểm này chưa được duyệt</p>
                                            </c:if>
                                            </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <!-- Hidden input to store the selected restaurant ID -->
                            <input type="hidden" name="restaurantId" id="selectedRestaurantId" required>

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
                                        <input class="form-check-input" type="checkbox" name="foodType" value="1" id="food">
                                        <label class="form-check-label" for="food">Đồ ăn</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="foodType" value="2" id="drink">
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
                                <input type="number" class="form-control" id="rating" name="rating" value="2.5" min="0" max="5" step="0.1" required readonly style="border: none; width: 10%; font-size: 22px;">
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
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-info btn-sm">Đăng</button>
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

            //search restaurants in page
            $(document).ready(function () {
                // Function to filter restaurants based on search query
                $('#restaurantSearchOnPage').on('input', function () {
                    var searchQuery = $(this).val().toLowerCase();

                    // Show restaurant list when typing starts
                    if (searchQuery.length > 0) {
                        $('#restaurantList').show();

                        $('.restaurant-page').each(function () {
                            var restaurantName = $(this).find('h5').text().toLowerCase();
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


            });


            //search restaurants in modal
            $(document).ready(function () {
                // Function to filter restaurants based on search query
                $('#restaurantSearch').on('input', function () {
                    var searchQuery = $(this).val().toLowerCase();

                    // Show restaurant list when typing starts
                    if (searchQuery.length > 0) {
                        $('#restaurantList').show();

                        $('.restaurant-modal').each(function () {
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
                $('.restaurant-modal').click(function () {
                    var restaurantId = $(this).data('id');
                    var restaurantName = $(this).data('name');
                    $('#selectedRestaurantId').val(restaurantId);
                    $('#restaurantSearch').val(restaurantName);
                    $('.restaurant-modal').removeClass('selected');
                    $(this).addClass('selected');
                    $('.restaurant-modal').not(this).hide();
                });
            });


        </script>

        <!--for filter địa điểm-->
        <script>
            // Function to filter restaurants based on price range and open status
            function filterRestaurants() {
                var restaurants = document.getElementsByClassName('restaurant');
                var lowestPrice = parseInt(document.getElementById('lowestPrice').value);
                var highestPrice = parseInt(document.getElementById('highestPrice').value);
                var isOpen = document.getElementById('openNow').checked;

                for (var i = 0; i < restaurants.length; i++) {
                    var restaurant = restaurants[i];
                    var price = parseInt(restaurant.getAttribute('data-price'));
                    var isOpenNow = restaurant.getAttribute('data-open') === 'true';

                    if ((price < lowestPrice || price > highestPrice) || (isOpen && !isOpenNow)) {
                        restaurant.style.display = 'none';
                    } else {
                        restaurant.style.display = 'block';
                    }
                }
            }

            // Event listeners for input changes
            document.getElementById('lowestPrice').addEventListener('change', filterRestaurants);
            document.getElementById('highestPrice').addEventListener('change', filterRestaurants);
            document.getElementById('openNow').addEventListener('change', filterRestaurants);
        </script>

        <script src="js/main.js"></script>
        <script src="js/slider.js"></script>
    </body>

</html>
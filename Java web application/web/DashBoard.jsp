<%-- 
    Document   : DashBoard
    Created on : Jun 11, 2024, 1:52:05 AM
    Author     : Lenono
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Dashboard </title>
        <link href="assets/vendor/fontawesome/css/fontawesome.min.css" rel="stylesheet">
        <link href="assets/vendor/fontawesome/css/solid.min.css" rel="stylesheet">
        <link href="assets/vendor/fontawesome/css/brands.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/master.css" rel="stylesheet">
        <link href="assets/vendor/flagiconcss/css/flag-icon.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="wrapper">
            <nav id="sidebar" class="active">
                <div class="sidebar-header">
                    <!--                    <img src="assets/img/bootstraper-logo.png" alt="bootraper logo" class="app-logo">-->
                </div>
                <ul class="list-unstyled components text-secondary">
                    <li>
                        <a href="DashBoard"><i class="fas fa-chart-bar"></i>Trang quản lý</a>
                    </li>
                    <li>
                        <a href="UserList"><i class="fas fa-user-friends"></i>Quản lý người dùng</a>
                    </li>
                    <li>
                        <a href="RestaurantList"><i class="fas fa-home"></i>Quản lý nhà hàng</a>
                    </li>
                    <li>
                        <a href="PostRequest"><i class="fas fa-file-alt"></i>Yêu cầu tạo bài viết</a>
                    </li>
                    <li>
                        <a href="RestaurantRequest"><i class="fas fa-home"></i>Yêu cầu tạo nhà hàng</a>
                    </li>
                    <!--                    <li>
                                            <a href="tables.html"><i class="fas fa-table"></i> Tables</a>
                                        </li>
                                        <li>
                                            <a href="charts.html"><i class="fas fa-chart-bar"></i> Charts</a>
                                        </li>
                                        <li>
                                            <a href="icons.html"><i class="fas fa-icons"></i> Icons</a>
                                        </li>
                                        <li>
                                            <a href="#uielementsmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle no-caret-down"><i class="fas fa-layer-group"></i> UI Elements</a>
                                            <ul class="collapse list-unstyled" id="uielementsmenu">
                                                <li>
                                                    <a href="ui-buttons.html"><i class="fas fa-angle-right"></i> Buttons</a>
                                                </li>
                                                <li>
                                                    <a href="ui-badges.html"><i class="fas fa-angle-right"></i> Badges</a>
                                                </li>
                                                <li>
                                                    <a href="ui-cards.html"><i class="fas fa-angle-right"></i> Cards</a>
                                                </li>
                                                <li>
                                                    <a href="ui-alerts.html"><i class="fas fa-angle-right"></i> Alerts</a>
                                                </li>
                                                <li>
                                                    <a href="ui-tabs.html"><i class="fas fa-angle-right"></i> Tabs</a>
                                                </li>
                                                <li>
                                                    <a href="ui-date-time-picker.html"><i class="fas fa-angle-right"></i> Date & Time Picker</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#authmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle no-caret-down"><i class="fas fa-user-shield"></i> Authentication</a>
                                            <ul class="collapse list-unstyled" id="authmenu">
                                                <li>
                                                    <a href="login.html"><i class="fas fa-lock"></i> Login</a>
                                                </li>
                                                <li>
                                                    <a href="signup.html"><i class="fas fa-user-plus"></i> Signup</a>
                                                </li>
                                                <li>
                                                    <a href="forgot-password.html"><i class="fas fa-user-lock"></i> Forgot password</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#pagesmenu" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle no-caret-down"><i class="fas fa-copy"></i> Pages</a>
                                            <ul class="collapse list-unstyled" id="pagesmenu">
                                                <li>
                                                    <a href="blank.html"><i class="fas fa-file"></i> Blank page</a>
                                                </li>
                                                <li>
                                                    <a href="404.html"><i class="fas fa-info-circle"></i> 404 Error page</a>
                                                </li>
                                                <li>
                                                    <a href="500.html"><i class="fas fa-info-circle"></i> 500 Error page</a>
                                                </li>
                                            </ul>
                                        </li>-->
                    

                    <li>
                        <a href="editPostRequest"><i class="fas fa-edit"></i>Yêu cầu chỉnh sửa bài viết</a>
                    </li>

                    <li>
                        <a href="editRestaurantRequest"><i class="fas fa-edit"></i>Yêu cầu chỉnh sửa nhà hàng</a>
                    </li>
                    <li>
                        <a href="ReportedPost"><i class="fas fa-flag"></i>Yêu cầu báo cáo bài viết</a>
                    </li>
                    <li>
                        <a href="ReportedRestaurant"><i class="fas fa-flag"></i>Yêu cầu báo cáo nhà hàng</a>
                    </li>

<!--                <li>
                        <a href="settings.html"><i class="fas fa-cog"></i>Settings</a>
                    </li>-->
                </ul>
            </nav>
            <div id="body" class="active">
                <!-- navbar navigation component -->
                <nav class="navbar navbar-expand-lg navbar-white bg-white">
                    <button type="button" id="sidebarCollapse" class="btn btn-light">
                        <i class="fas fa-bars"></i><span></span>
                    </button>

                </nav>
                <!-- end of navbar navigation -->
                <div class="content">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 page-header">
                               
                                <h2 class="page-title">Dashboard</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="UserList">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="teal fas fa-user-friends"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Tổng số tài khoản người dùng</p>
                                                        <span class="number">${requestScope.accCount}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>

                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="RestaurantList">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="olive fas fa-home"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Tổng số nhà hàng</p>
                                                        <span class="number">${requestScope.resCount}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-calendar"></i> For this Month
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="PostRequest">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="violet fas fa-newspaper"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">

                                                        <p class="detail-subtitle">Yêu cầu đăng bài viết</p>
                                                        <span class="number">${requestScope.postCount}</span>

                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-stopwatch"></i> For this Month
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="RestaurantRequest">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="orange fas fa-home"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Yêu cầu tạo nhà hàng</p>
                                                        <span class="number">${requestScope.resRequestCount}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-envelope-open-text"></i> For this week
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--                        line 2                                              -->
                        <div class="row">
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="editPostRequest">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="gray fas fa-edit"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Yêu cầu chỉnh sửa bài viết</p>
                                                        <span class="number">${requestScope.totalPostEdit}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-calendar"></i> For this Week
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="editRestaurantRequest">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i class="gray fas fa-edit"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Yêu cầu chỉnh sửa nhà hàng</p>
                                                        <span class="number">${requestScope.totalRestaurantEdit}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-calendar"></i> For this Week
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="ReportedPost">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i style="color: gray" class=" fas fa-flag"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Yêu cầu báo cáo bài viết</p>
                                                        <span class="number">${requestScope.reportPost}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-calendar"></i> For this Week
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-3 mt-3">
                                <div class="card">
                                    <div class="content">
                                        <a href="ReportedRestaurant">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <div class="icon-big text-center">
                                                        <i style="color: gray" class=" fas fa-flag"></i>
                                                    </div>
                                                </div>
                                                <div class="col-sm-8">
                                                    <div class="detail">
                                                        <p class="detail-subtitle">Yêu cầu báo cáo nhà hàng</p>
                                                        <span class="number">${requestScope.reportRestaurant}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                        <!--                                        <div class="footer">
                                                                                    <hr />
                                                                                    <div class="stats">
                                                                                        <i class="fas fa-calendar"></i> For this Month
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="assets/vendor/jquery/jquery.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/chartsjs/Chart.min.js"></script>
        <script src="assets/js/dashboard-charts.js"></script>
        <script src="assets/js/script.js"></script>
    </body>

</html>

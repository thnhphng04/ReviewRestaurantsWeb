<%-- 
    Document   : UserList
    Created on : Jun 11, 2024, 1:54:29 AM
    Author     : Lenono
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="Models.*"%>
<%@page import="DAL.*"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Users list</title>
    <link href="assets/vendor/fontawesome/css/fontawesome.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/solid.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/brands.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/datatables/datatables.min.css" rel="stylesheet">
    <link href="assets/css/master.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper">
        <!-- sidebar navigation component -->
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
        <!-- end of sidebar component -->
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
                    <div class="page-title">
                        <h3>Danh sách người dùng
                           
                        </h3>
                    </div>
                    <div class="box box-primary">
                        <div class="box-body">
                            <table width="100%" class="table table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>Email</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Tổng bài viết</th>
                                        <th>Tổng bài viết bị ẩn</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.list}" var="c">
                                        <tr>
                                            <td>${c.email}</td>
                                            <td>${c.role}</td> 
                                            <td style="color: ${c.status == 1 ? 'blue' : 'red'}">${c.status == 1 ? 'Hoạt động' : 'Dừng hoạt động'}</td>
                                            <td>${c.numberOfPost}</td>
                                            <td>${c.numberOfHiddenPost}</td>
                                            <td class="text-end">
                                                <a href="ChangeUserStatus?email=${c.email}" class="btn btn-outline-info btn-rounded"><i class="fas fa-pen"></i></a>

                                            </td>
                                        </tr>
                                    </c:forEach> 

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>














    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/datatables/datatables.min.js"></script>
    <script src="assets/js/initiate-datatables.js"></script>
    <script src="assets/js/script.js"></script>
</body>

</html>

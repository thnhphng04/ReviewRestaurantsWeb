<%-- 
    Document   : UserList
    Created on : Jun 11, 2024, 1:54:29 AM
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
    <title>Edit post request</title>
    <link href="assets/vendor/fontawesome/css/fontawesome.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/solid.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/brands.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/datatables/datatables.min.css" rel="stylesheet">
    <link href="assets/css/master.css" rel="stylesheet">
    <style>
        /* unvisited link */
        .a:link {
            color: blue;
        }

        /* visited link */
        .a:visited {
            color: green;
        }

        /* mouse over link */
        .a:hover {
            color: red;
        }

        /* selected link */
        .a:active {
            color: blue;
        }
        #deny-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            max-width: 80%;
        }

        #deny-popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }

        #deny-popup-dialog {
            text-align: center;
        }

        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        .button-container {
            text-align: right; /* Align buttons to the right */
        }

        button {
            padding: 8px 20px;
            margin: 0 10px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }

        button.cancel {
            background: #f44336;
            color: #fff;
        }

        button.submit {
            background: #4caf50;
            color: #fff;
        }
        .button-container {
            text-align: right;
            margin-top: 20px;
        }

        .button-container a {
            text-decoration: none;
        }

        .button-container button {
            padding: 8px 20px;
            margin: 0 10px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .button-container button[data-button="accept"] {
            background-color: #28a745; /* Green color for Accept button */
        }

        .button-container button[data-button="accept"]:hover {
            background-color: #218838; /* Darker green on hover for Accept button */
        }

        .button-container button[data-button="deny"] {
            background-color: #dc3545; /* Red color for Deny button */
        }

        .button-container button[data-button="deny"]:hover {
            background-color: #c82333; /* Darker red on hover for Deny button */
        }
    </style>
    <script>



    </script>
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
                        <h3>Yêu cầu chỉnh sửa bài viết

                        </h3>
                    </div>
                    <div class="box box-primary">
                        <div class="box-body">
                            <table width="100%" class="table table-hover table-striped" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID bài viết</th>
                                        <th>ID tài khoản</th>
                                        <th>ID nhà hàng</th>
                                        <th>Date</th>
                                        <th>Xem bài viết chỉnh sửa</th>
                                        <th>Xem bài viết gốc</th>
                                        <th>...</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.postRequest}" var="c">
                                        <tr>
                                            <td>${c.postId}</td>
                                            <td>${c.accountId}</td> 
                                            <td>${c.restaurantId}</td>
                                            <td>${c.getFormattedDate()}</td>
                                            <td><a class="a" href="PostPage?postId=${c.postId}">Xem </a></td>
                                            <td><a class="a" href="PostPage?postId=${c.editOf}">Xem </a></td>
                                            <td class="text-end">
                                                <div class="button-container">
                                                <a href="acceptEditPost?edittedPostId=${c.postId}&editOfPostId=${c.editOf}&action=1"><button type="button" data-button="accept" onclick="accept()">Duyệt</button></a>
                                                <a href="acceptEditPost?edittedPostId=${c.postId}&editOfPostId=${c.editOf}&action=0"><button type="button" data-button="deny" onclick="accept()">Từ chối</button></a>
                                                <div>
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

    <!-- Deny popup -->
    <div id="deny-popup" style="display: none;">
        <div id="deny-popup-dialog">
            <h2>Reason for denying:</h2>
            <p>Confirm that you want to deny this request due to the following reason:</p>
            <form action="AcceptPostRequest" method="POST">
                <textarea id="deny-reason" name="deny-reason" placeholder="Please enter your reason"></textarea>
                <input type="hidden" id="post-id" name="post-id" value="" />
                <button type="button" data-button="cancel" onclick="hideDenyPopup()">Cancel</button>
                <button type="submit" data-button="submit" >Submit</button>
            </form>
        </div>
    </div>












    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/datatables/datatables.min.js"></script>
    <script src="assets/js/initiate-datatables.js"></script>
    <script src="assets/js/script.js"></script>
</body>

</html>


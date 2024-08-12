<%-- 
    Document   : test
    Created on : Jun 2, 2024, 8:55:05 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table class="historyTable" border="1px">
            <thead>
                <tr>
                    <th>Post_id</th>
                    <th>account_id</th>
                    <th>restaurant_id</th>
                    <th>title</th>
                    <th>date</th>
                    <th>text</th>
                    <th>rating</th>
                    <th>status</th>
                </tr>
            </thead>
            <c:forEach items="${requestScope.posts}" var="p">
                <tbody>
                    <tr>
                        <td>${p.postId}</td>
                        <td>${p.accountId}</td>
                        <td>${p.restaurantId}</td>
                        <td>${p.title}</td>
                        <td>${p.date}</td>
                        <td>${p.text}</td>
                        <td>${p.rating}</td>
                        <td>${p.status}</td>
                        <c:if test="${p.getImagePaths().size()!=0}">
                            <td><img src="${p.getImagePaths().get(0)}" alt="alt"/></td>
                        </c:if>
                    </tr>
                </tbody>
            </c:forEach>
        </table> 
    </body>
</html>

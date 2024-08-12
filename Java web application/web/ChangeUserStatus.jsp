<%-- 
    Document   : ChangeUserStatus
    Created on : Jun 17, 2024, 2:16:54 AM
    Author     : Lenono
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>form {
  /* Add some padding and margin to the form */
  padding: 20px;
  margin: 40px;
  border: 1px solid #ccc;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

form label {
  /* Make the labels look nicer */
  font-weight: bold;
  margin-bottom: 5px;
}

form input, form select, form button {
  /* Make the form fields look nicer */
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

form input[type="text"], form input[type="date"], form input[type="number"] {
  /* Customize the input fields */
  width: 250px;
}

form input[type="radio"] {
  /* Customize the radio buttons */
  margin-right: 10px;
}

form select {
  /* Customize the select dropdown */
  width: 250px;
  padding: 10px;
  border-radius: 5px;
  appearance: none;
  -moz-appearance: none;
  -webkit-appearance: none;
}

form button[type="submit"] {
  /* Customize the submit button */
  background-color: #4CAF50;
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}
.readOnly {
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  color: #666;
  cursor: not-allowed;
}

form button[type="submit"]:hover {
  /* Add some hover effect to the submit button */
  background-color: #3e8e41;
}</style>
    <body>
       <form action="ChangeUserStatus" method="post">

                        <label>ID tài khoản</label>
                        <input name="id" value="${requestScope.account.accountId}" class="readOnly" type="text"/><br/>
                        
                        <label>Tên tài khoản</label>
                        <input name="userName" value="${requestScope.account.name}" class="readOnly"  type="text"/><br/>

                        <label>Email</label>
                        <input name="email" value="${requestScope.account.email}" class="readOnly" type="text"><br/>


                        <label>Số điện thoại</label>
                        <input name="phoneNumber" value="${requestScope.account.phoneNumber}" class="readOnly" class="profile__right-input" type="number"><br/>


                        <label>Giới tính</label>
                        <input  type="radio"  name="gender" value="0"  ${requestScope.account.gender == "false" ? 'checked' : ""}  disabled='disabled'/>&nbsp;Nam
                        &nbsp;&nbsp; <input type="radio" name="gender" value="1"  ${requestScope.account.gender == "true" ? 'checked' : ""} disabled='disabled' />&nbsp;Nữ<br/>

                        <label>Ngày sinh</label>
                        <input  name="dob" value="${requestScope.account.dob}" class="readOnly" type="date"><br/>

                        <label>Trạng thái</label>
                        <select name="status">
                            <option value="1" ${requestScope.account.status == 1 ? 'selected' : ""}>Hoạt động</option>
                            <option value="0" ${requestScope.account.status == 0 ? 'selected' : ""}>Cấm</option>
                        </select>
                        
                        <button class="btn__save" type="submit"> Save</button>
       
        </form>
    </body>
</html>

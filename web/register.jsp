<%@ page import="Database.Countries" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Вика
  Date: 08.10.2020
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="head.jsp"%>
    <script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp"%>
<div class="container mt-3">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Register User</li>
        </ol>
    </nav>
</div>
<div class="container mt-3">
    <div class="row">
        <div class="col-sm-6 offset-3">
            <%
                String userError = request.getParameter("usererror");
                String email = request.getParameter("email");
                String fullName = request.getParameter("full_name");
                if(userError!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                User with email "<%=email%>" exists!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%
                }
            %>
            <%
                String passwordError = request.getParameter("passworderror");
                if(passwordError!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Passwords are not same!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%
                }
            %>
            <%
                String cityError = request.getParameter("cityerror");
                if(cityError!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Choose correct city!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%
                }
            %>
            <%
                String success = request.getParameter("success");
                if(success!=null){
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                User added successfully!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%
                }
            %>
            <form action="/register" method="post">
                <div class="form-group">
                    <label>
                        EMAIL :
                    </label>
                    <input type="email" name="email" class="form-control" value="<%=(email!=null?email:"")%>" required>
                </div>
                <div class="form-group">
                    <label>
                        PASSWORD :
                    </label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>
                        REPEAT PASSWORD :
                    </label>
                    <input type="password" name="re_password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>
                        FULL NAME :
                    </label>
                    <input type="text" name="full_name" class="form-control" value="<%=(fullName!=null?fullName:"")%>" required>
                </div>
                <div class="form-group">
                    <label>
                        COUNTRY :
                    </label>
                    <select class="form-control" id = "country_id">
                        <option value="0">Select Country</option>
                        <%
                            ArrayList<Countries> countries = (ArrayList<Countries>)request.getAttribute("countries");
                            if(countries!=null){
                                for(Countries cnt : countries){
                        %>
                        <option value="<%=cnt.getId()%>">
                            <%=cnt.getName()%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label>
                        CITY :
                    </label>
                    <select class="form-control" id = "city_id" name="city_id">

                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-success">SIGN UP</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#country_id").change(function(){
            cntId = $("#country_id").val();
            $.get("/ajaxcities", {
                country_id : cntId
            }, function(data){
                citiesArray = JSON.parse(data);
                opts = "";
                for(i=0;i<citiesArray.length;i++){
                    opts+="<option value = '"+citiesArray[i]["id"]+"'>"+citiesArray[i]["name"]+"</option>";
                }
                $("#city_id").html(opts);
            });
        });
    });
</script>
</html>

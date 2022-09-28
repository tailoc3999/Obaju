<%@page import="utils.StringUtil"%>
<%@page import="models.User"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="daos.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Obaju : e-commerce template</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Google fonts - Roboto -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/https://fonts.googleapis.com/css?family=Roboto:100,300,400,700">
    <!-- owl carousel-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/vendor/owl.carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/vendor/owl.carousel/assets/owl.theme.default.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/public/css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/public/favicon.png">
    
    <script src="<%=request.getContextPath() %>/resources/public/vendor/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resources/admin/assets/js/jquery.validate.js"></script>
    
    <style type="text/css">
		.form-group label.error {color:red; font-weight: bold}
	</style>
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>
  <body>
    <!-- navbar-->
    <header class="header mb-5">
      <!--
      *** TOPBAR ***
      _________________________________________________________
      -->
      <div id="top">
        <div class="container">
          <div class="row">
            <div class="col-lg-12 text-center text-lg-right">
              <ul class="menu list-inline mb-0">
              <%
              	User user = (User) session.getAttribute("userInfo");
              	if(user != null) {
              %>
              	<li class="list-inline-item"><a href="<%=request.getContextPath() %>/purchase"><%=user.getFullname() %></a></li>
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/logout">Logout</a></li>
              <%		
              	} else {
              %>
              	<li class="list-inline-item"><a href="#" data-toggle="modal" data-target="#login-modal">Login</a></li>
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/auth/login">Register</a></li>
              <%		
              	}
              %>
              	<li class="list-inline-item"><a href="<%=request.getContextPath() %>/contact">Contact</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true" class="modal fade">
          <div class="modal-dialog modal-sm">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">Customer login</h5>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">Ã</span></button>
              </div>
              <div class="modal-body">
                <form id="login" action="<%=request.getContextPath() %>/auth/login" method="post">
                  <div class="form-group">
                    <input id="email-modal" name="email" type="text" placeholder="email" class="form-control">
                  </div>
                  <div class="form-group">
                    <input id="password-modal" name="password" type="password" placeholder="password" class="form-control">
                  </div>
                  <p class="text-center">
                    <button class="btn btn-primary"><i class="fa fa-sign-in"></i> Log in</button>
                  </p>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#login').validate({
							rules: {
								"email": {
									required: true,
									minlength: 5,
								},
								"password": {
									required: true,
								},
							},
							messages: {
								"email": {
									required: "Vui lòng nhập email",
									minlength: "Email ít nhất 5 kí tự",
								},
								"password": {
									required: "Vui lòng nhập mật khẩu",
								},
							},
						});
					});	
				</script>
                
                <p class="text-center text-muted">Not registered yet?</p>
                <p class="text-center text-muted"><a href="<%=request.getContextPath() %>/resources/public/register.jsp"><strong>Register now</strong></a>! It is easy and done in 1Â minute and gives you access to special discounts and much more!</p>
              </div>
            </div>
          </div>
        </div>
        <!-- *** TOP BAR END ***-->
        
        
      </div>
      <nav class="navbar navbar-expand-lg">
        <div class="container"><a href="<%=request.getContextPath() %>/home" class="navbar-brand home"><img src="<%=request.getContextPath() %>/resources/public/img/logo.png" alt="Obaju logo" class="d-none d-md-inline-block"><img src="<%=request.getContextPath() %>/resources/public/img/logo-small.png" alt="Obaju logo" class="d-inline-block d-md-none"><span class="sr-only">Obaju - go to homepage</span></a>
          <div class="navbar-buttons">
            <button type="button" data-toggle="collapse" data-target="#navigation" class="btn btn-outline-secondary navbar-toggler"><span class="sr-only">Toggle navigation</span><i class="fa fa-align-justify"></i></button>
            <button type="button" data-toggle="collapse" data-target="#search" class="btn btn-outline-secondary navbar-toggler"><span class="sr-only">Toggle search</span><i class="fa fa-search"></i></button><a href="<%=request.getContextPath() %>/resources/public/basket.jsp" class="btn btn-outline-secondary navbar-toggler"><i class="fa fa-shopping-cart"></i></a>
          </div>
          <div id="navigation" class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item"><a id="home" href="<%=request.getContextPath() %>/home" class="nav-link ">Home</a></li>
      <%
      	CategoryDAO cattegoryDAO = new CategoryDAO();
      	List<Category> catList = cattegoryDAO.getAll();
      	if(catList != null && catList.size() > 0) {
      		for(Category item : catList) {
      			String urlSlug = request.getContextPath() + "/category/" + StringUtil.makeSlug(item.getName()) + "-" + item.getId() + ".html";
      %>			
            
              <li class="nav-item dropdown menu-large">
              	<a id="<%=item.getName() %>" href="<%=urlSlug %>" class=" nav-link"><%=item.getName() %><b class="caret"></b></a>
              </li>
      <%
       		}
      	}
      %>         
            </ul>
            <div class="navbar-buttons d-flex justify-content-end">
              <!-- /.nav-collapse-->
              <div id="search-not-mobile" class="navbar-collapse collapse"></div><a data-toggle="collapse" href="#search" class="btn navbar-btn btn-primary d-none d-lg-inline-block"><span class="sr-only">Toggle search</span><i class="fa fa-search"></i></a>
              <div id="basket-overview" class="navbar-collapse collapse d-none d-lg-block"><a href="<%=request.getContextPath() %>/basket" class="btn btn-primary navbar-btn"><i class="fa fa-shopping-cart"></i><span><%=session.getAttribute("size")!= null?session.getAttribute("size"):"0" %> items in cart</span></a></div>
            </div>
          </div>
        </div>
      </nav>
      <div id="search" class="collapse">
        <div class="container">
          <form action="/Fashion2/cat" method="get" role="search" class="ml-auto">
            <div class="input-group">	
              <input type="text" name="search" placeholder="Search" class="form-control">
              <input type="text" hidden="hidden" name="id" value="0">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </header>
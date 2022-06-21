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
		#form .form-group label.error {color:red; font-weight: bold}
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
            <div class="col-lg-6 offer mb-3 mb-lg-0"><a href="<%=request.getContextPath() %>/resources/public/#" class="btn btn-success btn-sm">Offer of the day</a><a href="<%=request.getContextPath() %>/resources/public/#" class="ml-1">Get flat 35% off on orders over $50!</a></div>
            <div class="col-lg-6 text-center text-lg-right">
              <ul class="menu list-inline mb-0">
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/resources/public/#" data-toggle="modal" data-target="#login-modal">Login</a></li>
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/resources/public/register.jsp">Register</a></li>
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/resources/public/contact.jsp">Contact</a></li>
                <li class="list-inline-item"><a href="<%=request.getContextPath() %>/resources/public/#">Recently viewed</a></li>
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
                <form action="customer-orders.jsp" method="post">
                  <div class="form-group">
                    <input id="email-modal" type="text" placeholder="email" class="form-control">
                  </div>
                  <div class="form-group">
                    <input id="password-modal" type="password" placeholder="password" class="form-control">
                  </div>
                  <p class="text-center">
                    <button class="btn btn-primary"><i class="fa fa-sign-in"></i> Log in</button>
                  </p>
                </form>
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
      %>			
            
              <li class="nav-item dropdown menu-large">
              	<a id="<%=item.getName() %>" href="<%=request.getContextPath() %>/cat?id=<%=item.getId() %>" class=" nav-link"><%=item.getName() %><b class="caret"></b></a>
              </li>
      <%
       		}
      	}
      %>         
              <li class="nav-item dropdown menu-large">
              	<a href="<%=request.getContextPath() %>/resources/public/#" data-toggle="dropdown" data-hover="dropdown" data-delay="200" class="dropdown-toggle nav-link">Template<b class="caret"></b></a>
                <ul class="dropdown-menu megamenu">
                  <li>
                    <div class="row">
                      <div class="col-md-6 col-lg-3">
                        <h5>Shop</h5>
                        <ul class="list-unstyled mb-3">
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/index.jsp" class="nav-link">Homepage</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/category.jsp" class="nav-link">Category - sidebar left</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/category-right.jsp" class="nav-link">Category - sidebar right</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/category-full.jsp" class="nav-link">Category - full width</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/detail.jsp" class="nav-link">Product detail</a></li>
                        </ul>
                      </div>
                      <div class="col-md-6 col-lg-3">
                        <h5>User</h5>
                        <ul class="list-unstyled mb-3">
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/register.jsp" class="nav-link">Register / login</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/customer-orders.jsp" class="nav-link">Orders history</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/customer-order.jsp" class="nav-link">Order history detail</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/customer-wishlist.jsp" class="nav-link">Wishlist</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/customer-account.jsp" class="nav-link">Customer account / change password</a></li>
                        </ul>
                      </div>
                      <div class="col-md-6 col-lg-3">
                        <h5>Order process</h5>
                        <ul class="list-unstyled mb-3">
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/basket.jsp" class="nav-link">Shopping cart</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/checkout1.jsp" class="nav-link">Checkout - step 1</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/checkout2.jsp" class="nav-link">Checkout - step 2</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/checkout3.jsp" class="nav-link">Checkout - step 3</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/checkout4.jsp" class="nav-link">Checkout - step 4</a></li>
                        </ul>
                      </div>
                      <div class="col-md-6 col-lg-3">
                        <h5>Pages and blog</h5>
                        <ul class="list-unstyled mb-3">
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/blog.jsp" class="nav-link">Blog listing</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/post.jsp" class="nav-link">Blog Post</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/faq.jsp" class="nav-link">FAQ</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/text.jsp" class="nav-link">Text page</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/text-right.jsp" class="nav-link">Text page - right sidebar</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/404.jsp" class="nav-link">404 page</a></li>
                          <li class="nav-item"><a href="<%=request.getContextPath() %>/resources/public/contact.jsp" class="nav-link">Contact</a></li>
                        </ul>
                      </div>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
            <div class="navbar-buttons d-flex justify-content-end">
              <!-- /.nav-collapse-->
              <div id="search-not-mobile" class="navbar-collapse collapse"></div><a data-toggle="collapse" href="#search" class="btn navbar-btn btn-primary d-none d-lg-inline-block"><span class="sr-only">Toggle search</span><i class="fa fa-search"></i></a>
              <div id="basket-overview" class="navbar-collapse collapse d-none d-lg-block"><a href="<%=request.getContextPath() %>/resources/public/basket.jsp" class="btn btn-primary navbar-btn"><i class="fa fa-shopping-cart"></i><span>3 items in cart</span></a></div>
            </div>
          </div>
        </div>
      </nav>
      <div id="search" class="collapse">
        <div class="container">
          <form role="search" class="ml-auto">
            <div class="input-group">
              <input type="text" placeholder="Search" class="form-control">
              <div class="input-group-append">
                <button type="button" class="btn btn-primary"><i class="fa fa-search"></i></button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </header>
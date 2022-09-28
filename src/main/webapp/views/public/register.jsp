<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>
    <div id="all">
      <div id="content">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              <!-- breadcrumb-->
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="#">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item active">New account / Sign in</li>
                </ol>
              </nav>
            </div>
            <div class="col-lg-6">
              <div class="box">
                <h1>New account</h1>
                <p class="lead">Not our registered customer yet?</p>
                <p>With registration with us new world of fashion, fantastic discounts and much more opens to you! The whole process will not take you more than a minute!</p>
                <p class="text-muted">If you have any questions, please feel free to <a href="contact.html">contact us</a>, our customer service center is working for you 24/7.</p>
                <hr>
                <form id="register" action="<%=request.getContextPath() %>/regis" method="post">
                  <div class="form-group">
                    <label for="fullname">Name</label>
                    <input id="fullname" name="fullname" type="text" class="form-control">
                  </div>
                  <div class="form-group">
                    <label for="email">Email</label>
                    <input id="emaill" name="email" type="text" class="form-control">
                  </div>
                  <div class="form-group">
                    <label for="password">Password</label>
                    <input id="passwordd" name="password" type="password" class="form-control">
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-user-md"></i> Register</button>
                  </div>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#register').validate({
							rules: {
								"fullname": {
									required: true,
									minlength: 10,
								},
								"email": {
									required: true,
									minlength: 5,
								},
								"password": {
									required: true,
									minlength: 3,
								},
							},
							messages: {
								"fullname": {
									required: "Vui lòng nhập họ tên",
									minlength: "Họ tên ít nhất 10 ký tự!",
								},
								"email": {
									required: "Vui lòng nhập email",
									minlength: "Email ít nhất 5 kí tự",
								},
								"password": {
									required: "Vui lòng nhập mật khẩu",
									minlength: "Mật khẩu ít nhất 3 ký tự",
								},
							},
						});
					});	
				</script>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="box">
                <h1>Login</h1>
                <p class="lead">Already our customer?</p>
                <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                <hr>
                <%
                	String err = request.getParameter("err");
                	if("1".equals(err)) {
                		out.print("<span style='color:red; font-weight:bold'>The email or password that you've entered is incorrect.</span>");
                	}
                %>
                <form id="login2" action="" method="post">
                  <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="text" class="form-control">
                  </div>
                  <div class="form-group">
                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" class="form-control">
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-sign-in"></i> Log in</button>
                  </div>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#login2').validate({
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
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/templates/public/inc/footer.jsp" %>
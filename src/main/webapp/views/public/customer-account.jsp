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
                  <li aria-current="page" class="breadcrumb-item active">My account</li>
                </ol>
              </nav>
            </div>
            <div class="col-lg-3">
              <!--
              *** CUSTOMER MENU ***
              _________________________________________________________
              -->
              <div class="card sidebar-menu">
                <div class="card-header">
                  <h3 class="h4 card-title">Customer section</h3>
                </div>
                <div class="card-body">
                  <ul class="nav nav-pills flex-column"><a href="/Fashion2/purchase" class="nav-link"><i class="fa fa-list"></i> My orders</a><a href="<%=request.getContextPath() %>/profile" class="nav-link active"><i class="fa fa-user"></i> My account</a><a href="<%=request.getContextPath() %>/logout" class="nav-link"><i class="fa fa-sign-out"></i> Logout</a></ul>
                </div>
              </div>
              <!-- /.col-lg-3-->
              <!-- *** CUSTOMER MENU END ***-->
            </div>
            <div class="col-lg-9">
              <div class="box">
              <%
              	String err = request.getParameter("err");
              	String msg = request.getParameter("msg");
              	if("1".equals(msg)) {
              		out.print("<h4 style='color:green;font-weight:bold'>Edit success</h4>");
              	}
              	
              	
              	if("1".equals(err)) {
              		out.print("<h4 style='color:red;font-weight:bold'>Edit error</h4>");
              	}
              	if("2".equals(err)) {
              		out.print("<h4 style='color:red;font-weight:bold'>The old password that you've entered is incorrect</h4>");
              	}
              %>
                <h1>My account</h1>
                <p class="lead">Change your personal details or your password here.</p>
                <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
                <h3>Change password</h3>
                <form id="changepw" action="/Fashion2/profile" method="post">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_old">Old password</label>
                        <input id="password_old" name="password_old" type="password" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_1">New password</label>
                        <input id="password_1" name="password_1" type="password" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_2">Retype new password</label>
                        <input id="password_2" name="password_2" type="password" class="form-control">
                      </div>
                    </div>
                  </div>
                  <!-- /.row-->
                  <div class="col-md-12 text-center">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Save new password</button>
                  </div>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#changepw').validate({
							rules: {
								"password_old": {
									required: true,
									minlength: 3,
								},
								"password_1": {
									required: true,
									minlength: 3,
								},
								"password_2": {
									required: true,
									minlength: 3,
									equalTo: "#password_1",
								},
							},
							messages: {
								"password_old": {
									required: "Vui lòng nhập mật khẩu cũ",
									minlength: "Mật khẩu ít nhất 3 ký tự!",
								},
								"password_1": {
									required: "Vui lòng nhập mật khẩu mới",
									minlength: "Mật khẩu ít nhất 3 số",
								},
								"password_2": {
									required: "Vui lòng nhập địa chỉ của bạn",
									minlength: "Mật khẩu ít nhất 3 ký tự",
									equalTo: "Mật khẩu mới phải giống nhau"
								},
							},
						});
					});	
				</script>
                <h3 class="mt-5">Personal details</h3>
                <%
                	User userLogin = (User) session.getAttribute("userInfo");
                %>
                <form id="info" method="get" action="/Fashion2/profile" autocomplete="off">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="fullname">Name</label>
                        <input id="fullname" name="fullname" value="<%=userLogin.getFullname() %>" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="email">Email</label>
                        <input disabled="disabled" id="email" name="email" value="<%=userLogin.getEmail() %>" type="text" class="form-control">
                      </div>
                    </div>
                  </div>
                  <!-- /.row-->
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="phonenumber">Phone number</label>
                        <input id="phonenumber" value="<%=userLogin.getPhone_number()!=null?userLogin.getPhone_number():"" %>" name="phonenumber" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="address">Address</label>
                        <input id="address" name="address" value="<%=userLogin.getAddress()!=null?userLogin.getAddress():"" %>" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <input hidden="hidden" name="fix" type="text" value="true" class="form-control">
                      </div>
                    </div>
                  </div>
                  <!-- /.row-->
                    </div>
                    <div class="col-md-12 text-center">
                      <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Save changes</button>
                    </div>
                  </div>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#info').validate({
							rules: {
								"fullname": {
									required: true,
									minlength: 10,
								},
								"phonenumber": {
									required: true,
									minlength: 10,
									maxlength: 11,
									number: true,
								},
								"address": {
									required: true,
									minlength: 15,
								},
							},
							messages: {
								"fullname": {
									required: "Vui lòng nhập họ tên",
									minlength: "Họ tên ít nhất 10 ký tự!",
								},
								"phonenumber": {
									required: "Vui lòng nhập email",
									minlength: "Số điện thoại ít nhất 10 số",
									maxlength: "Số điện thoại nhiều nhất 11 số",
									number: "Số điện thoại phải là ký tự số",
								},
								"address": {
									required: "Vui lòng nhập địa chỉ của bạn",
									minlength: "Vui lòng nhập ít nhất 15 ký tự",
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
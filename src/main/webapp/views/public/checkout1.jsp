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
                  <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/home">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item active">Checkout - Address</li>
                </ol>
              </nav>
            </div>
         <%
         	User userLogin = (User) session.getAttribute("userInfo");
         %>   
            <div id="checkout" class="col-lg-12">
              <div class="box">
                <form id="address" method="post" action="/Fashion2/checkout1" autocomplete="off">
                  <h1>Checkout - Address</h1>
                  <div class="nav flex-column flex-md-row nav-pills text-center"><a href="/Fashion2/checkout1" class="nav-link flex-sm-fill text-sm-center active"> <i class="fa fa-map-marker">                  </i>Address</a><a href="#" class="nav-link flex-sm-fill text-sm-center disabled"> <i class="fa fa-eye">                     </i>Order Review</a></div>
                  <div class="content py-3">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="fullname">Fullname</label>
                          <input id="fullname" name="fullname" value="<%=user!=null?user.getFullname():"" %>" type="text" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="email">Email</label>
                          <input id="email" name="email" value="<%=user!=null?user.getEmail():"" %>" type="text" class="form-control">
                        </div>
                      </div>
                    </div>
                    <!-- /.row-->
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="phonenumber">Phone Number</label>
                          <input id="phonenumber" name="phonenumber" value="<%=user!=null?user.getPhone_number():"" %>" type="text" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="note">Note</label>
                          <input id="note" name="note" type="text" class="form-control">
                        </div>
                      </div>
                    </div>
                    <!-- /.row-->
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label for="address">Address</label>
                          <input id="address" name="address" value="<%=user!=null?user.getAddress():"" %>" type="text" class="form-control">
                        </div>
                      </div>
                    </div>
                    <!-- /.row-->
                  </div>
                  <div class="box-footer d-flex justify-content-between"><a href="<%=request.getContextPath() %>/basket" class="btn btn-outline-secondary"><i class="fa fa-chevron-left"></i>Back to Basket</a>
                    <button type="submit" class="btn btn-primary">Continue to Order Review<i class="fa fa-chevron-right"></i></button>
                  </div>
                </form>
                <script type="text/javascript">
					$(document).ready(function () {
						$('#address').validate({
							rules: {
								"fullname": {
									required: true,
									minlength: 10,
								},
								"email": {
									required: true,
									minlength: 5,
								},
								"phonenumber": {
									required: true,
									number: true,
								},
								"address": {
									required: true,
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
								"phonenumber": {
									required: "Vui lòng nhập số điện thoại",
									number: "Số điện thoại chỉ chứa ký tự số",
								},
								"address": {
									required: "Vui lòng nhập địa chỉ người nhận",
								},
							},
						});
					});	
				</script>
              </div>
              <!-- /.box-->
            </div>
            <!-- /.col-lg-9-->
            <!-- /.col-lg-3-->
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/templates/public/inc/footer.jsp" %>
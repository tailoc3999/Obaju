<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Thêm người dùng</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
        	String fullname = request.getParameter("fullname");
        	String email = request.getParameter("email");
        	String phone_number = request.getParameter("phonenumber");
        	String address = request.getParameter("address");
        	int role_id = 0;
        	try {
        		role_id = Integer.parseInt(request.getParameter("role"));
        	} catch (NumberFormatException e) {
        		e.printStackTrace();
        	}
        	
        	String err = request.getParameter("err");
        	if("2".equals(err)) {
    			out.print("<span style='color:red; font-weight:bold; padding:5px'>Có lỗi khi thêm</span>");
    		}
        	if("3".equals(err)) {
    			out.print("<span style='color:red; font-weight:bold; padding:5px'>Email này đã đăng ký</span>");
    		}
        %>
        <div class="row">
            <div class="col-md-12">
                <!-- Form Elements -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <form role="form" method="post" id="form">
                                    <div class="form-group">
                                        <label for="fullname">Họ tên</label>
                                        <input type="text" id="fullname" value="<%=fullname!=null?fullname:"" %>" name="fullname" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="text" id="email" value="<%=email!=null?email:"" %>" name="email" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Mật khẩu</label>
                                        <input type="password" id="password" value="" name="password" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="phonenumber">Số điện thoại</label>
                                        <input type="text" id="phonenumber" value="<%=phone_number!=null?phone_number:"" %>" name="phonenumber" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Địa chỉ</label>
                                        <input type="text" id="address" value="<%=address!=null?address:"" %>" name="address" class="form-control" />
                                    </div>
                                    <div class="form-group">
										<label>Role</label>
										<div class="checkbox">
											<label> <input <%=role_id==1?"checked=\"checked\"":"" %> type="radio" value="1" name="role"/>Admin</label>
											<br>
											<label> <input <%=role_id==2?"checked=\"checked\"":"" %> type="radio" value="2" name="role" />Client</label>
										</div>
									<%
										if("1".equals(err)) {
									%>
											<label id="fullname-error" class="error" for="fullname">Vui lòng chọn role</label>
									<%		
										}
									%>	
									</div>
                                    <button type="submit" name="submit" class="btn btn-success btn-md">Thêm</button>
                                </form>
                                <script type="text/javascript">
									$(document).ready(function () {
										$('#form').validate({
											rules: {
												"fullname": {
													required: true,
													minlength: 10,
							 						maxlength: 50,
												},
												"email": {
													required: true,
													email: true,
												},
												"password": {
													required: true,
													minlength: 4,
												},
												"phonenumber": {
													required: true,
													number: true,
													maxlength: 13,
												},
												"address": {
													required: true,
												},
											},
											messages: {
												"fullname": {
													required: "Vui lòng nhập họ tên",
													minlength: "Họ và tên ít nhất 10 kí tự",
													maxlength: "Họ và tên nhiều nhất 50 kí tự",
												},
												"email": {
													required: "Vui lòng nhập email",
													email: "Email chưa đúng định dạng",
												},
												"password": {
													required: "Vui lòng nhập mật khẩu",
													minlength: "Mật khẩu ít nhất 4 ký tự",
												},
												"phonenumber": {
													required: "Vui lòng nhập số điện thoại",
													number: "Số điện thoại chưa đúng định dạng",
													maxlength: "Số điện thoại nhiều nhất 13 ký tự",
												},
												"address": {
													required: "Vui lòng nhập địa chỉ",
												},
											},
										});
									});	
								</script>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Form Elements -->
            </div>
        </div>
        <!-- /. ROW  -->
    </div>
    <!-- /. PAGE INNER  -->
</div>
<script>
    document.getElementById("user").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>
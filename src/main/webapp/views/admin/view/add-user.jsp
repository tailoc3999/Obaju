<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add User</title>
<!-- BOOTSTRAP STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/admin/static/js/jquery.validate.js"></script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="/templates/admin/nav-bar.jsp"></jsp:include>
		<!-- /. NAV TOP  -->
		<jsp:include page="/templates/admin/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<h2>Add User</h2>
						<h5>You can edit info user in here</h5>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				<div class="row">
					<div class="col-md-12">
						<!-- Form Elements -->
						<div class="panel panel-default">
							<div class="panel-heading">Add User</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6">
										<h3>User:</h3>
										
										<form id="form" role="form" action="" method="post">
											<div class="form-group">
												<label>Full name:</label> <input class="form-control"
													placeholder="please enter fullname" name="fullname" />
											</div>
											<div class="form-group">
												<label>Password</label> <input class="form-control"
													placeholder="please enter password" type="password"
													name="password" />
											</div>
											<div class="form-group">
												<label>Email:</label> <input class="form-control"
													placeholder="Please enter email" name="email" />
											</div>
											<div class="form-group">
												<label>Phone number:</label> <input class="form-control"
													placeholder="Please enter phone number" name="phonenumber" />
											</div>
											<div class="form-group">
												<label>Address:</label> <input class="form-control"
													placeholder="Please enter address" name="address" />
											</div>
											<div class="form-group">
												<label>Role</label>
												<div class="checkbox">
													<label> <input type="radio" value="1" name="role"/>Admin
													</label>
													<br>
													<label> <input type="radio" value="2" name="role" />Client
													</label>
												</div>
												
											</div>
											<button type="submit" class="btn btn-default">Add</button>
											<button type="reset" class="btn btn-primary">Reset</button>
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
											},
											messages: {
												"fullname": {
													required: "Vui lòng nhập họ tên",
													minlength: "Họ và tên ít nhất 10 kí tự",
													maxlength: "Họ và tên nhiều nhất 50 kí tự",
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
				<div class="row">
					<div class="col-md-12"></div>
				</div>
				<!-- /. ROW  -->
			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery.metisMenu.js"></script>
	<!-- CUSTOM SCRIPTS -->
<!--<script src="<%=request.getContextPath() %>/resources/admin/static/js/custom.js"></script>   -->	

</body>
</html>
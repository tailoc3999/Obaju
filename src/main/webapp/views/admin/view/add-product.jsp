<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add Product</title>
<!-- BOOTSTRAP STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
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
						<h2>Add Product</h2>
						<h5>Add product you can sell</h5>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				<div class="row">
					<div class="col-md-12">
						<!-- Form Elements -->
						<div class="panel panel-default">
							<div class="panel-heading">Add Product</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6">
										<h3>Info Product:</h3>

										<form role="form" action="add" method="post"
											enctype="multipart/form-data">
											<div class="form-group">
												<label>Name:</label> <input class="form-control"
													placeholder="please enter Product Name" name="name" />
											</div>
											<div class="form-group">
												<label>Price ($)</label> <input class="form-control"
													placeholder="please enter Price" type="number" name="price" />
											</div>
											<div class="form-group">
												<label>Description </label>
												<br>
												<textarea rows="4" cols="50" name="des" id="editer"></textarea>

											</div>

											<div class="form-group">
												<label>Category</label>
												<div class="checkbox">
													<select name="category">
														<c:forEach items="${categories}" var="c">
															<option value="${c.id}">${c.name}</option>
														</c:forEach>
													</select>
												</div>

											</div>
											<div class="form-group">
												<label>image</label> <input type="file" name="image" />
											</div>
											<button type="submit" class="btn btn-default">Add</button>
											<button type="reset" class="btn btn-primary">Reset</button>
										</form>


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
<%-- <script src="<%=request.getContextPath() %>/resources/admin/static/js/custom.js"></script> --%>	
</body>
</html>
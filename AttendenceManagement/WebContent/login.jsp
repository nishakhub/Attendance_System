<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Login</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="resources/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
<link href="resources/css/styles.css" rel="stylesheet">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/logo.ico" />
</head>
<body>
	<!--login modal-->
	<div id="loginModal" class="modal show" tabindex="-1" role="dialog"	aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>-->
					<h1 class="text-center">Login</h1>
				</div>
				<div class="modal-body">
					<form class="form col-md-12 center-block" action="login" method="post">
						<div class="form-group">
							<input type="text" name="userName" class="form-control input-lg" placeholder="Username">
						</div>
						<div class="form-group">
							<input type="password" name="password" class="form-control input-lg" placeholder="Password">
						</div>
						<div class="form-group">
							<input type="submit" class="btn btn-primary btn-lg btn-block" value="Sign In" />
							<span class="pull-right"><!-- a href="#">Register</a></span><span><a
								href="#">Need help?</a> --></span>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<div class="col-md-12">
						<!-- button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- script references -->
	<script
		src=resources/js/jquery.1.11.3.js"></script>
	<script src="resources/js/bootstrap.js"></script>
</body>
</html>
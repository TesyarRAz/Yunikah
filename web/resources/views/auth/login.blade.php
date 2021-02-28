<!DOCTYPE html>
<html class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>{{ config('app.name') }}</title>
	<link rel="stylesheet" type="text/css" href="{{ asset('assets/bootstrap/css/bootstrap.min.css') }}">
</head>
<body class="h-100">
<div class="container-fluid h-100">
	<div class="row justify-content-center align-items-center h-100">
		<div class="col-lg-4 col-md-6">
			<form class="card" action="{{ route('login.post') }}" method="post">
				@csrf

				<div class="card-header bg-primary">
					<span class="text-white">Login Yunikah</span>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label>Username</label>
						<input type="text" name="username" class="form-control" required>
						@error('username')
		                    <span class="invalid-feedback" role="alert">
		                        <strong>{{ $message }}</strong>
		                    </span>
		                @enderror
					</div>
					<div class="form-group">
						<label>Password</label>
						<input type="password" name="password" class="form-control" required>
						@error('password')
		                    <span class="invalid-feedback" role="alert">
		                        <strong>{{ $message }}</strong>
		                    </span>
		                @enderror
					</div>

					@error('login')
	                    <span class="invalid-feedback" role="alert">
	                        <strong>{{ $message }}</strong>
	                    </span>
	                @enderror

	                <div class="form-check">
	                	<input type="checkbox" id="rememberMe" name="remember_me" class="form-check-input">
	                	<label for="rememberMe" class="form-check-label">Remember Me</label>
	                </div>

					<div class="form-group" align="right">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="{{ asset('assets/js/jquery.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
</body>
</html>
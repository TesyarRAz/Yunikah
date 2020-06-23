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
	<div class="d-flex justify-content-center align-items-center h-100">
		<form action="{{ route('login.post') }}" method="post" class="form-group">
			<h2 class="text-center">Login Yunikah</h2>
			@csrf

			<div class="border p-5 rounded">
				<input type="text" name="username" placeholder="Username" class="form-control my-2" required>
				@error('username')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
				<input type="password" name="password" placeholder="Password" class="form-control my-2" required>
				@error('password')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror

				@error('login')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror
				<button type="submit" class="btn btn-success">Login</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="{{ asset('assets/js/jquery.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
</body>
</html>
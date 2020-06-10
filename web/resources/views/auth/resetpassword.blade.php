<!DOCTYPE html>
<html class="h-100">
<head>
	<title>{{ config('app.name') }}</title>
	<link rel="stylesheet" type="text/css" href="{{ asset('assets/bootstrap/css/bootstrap.min.css') }}">
</head>
<body class="h-100">
<div class="container-fluid h-100">
	<div class="d-flex justify-content-center align-items-center h-100">
		<form action="{{ route('user.changepassword.post') }}" method="post" class="form-group">
			<h2 class="text-center">Ganti Password</h2>
			@csrf

			<div class="border p-5 rounded">
				
				<input type="password" name="password" placeholder="Password Lama" class="form-control my-2 @error('password') is-invalid @enderror">
				@error('password')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror

                <input type="password" name="new_password" placeholder="Password Baru" class="form-control my-2 @error('new_password') is-invalid @enderror">
				@error('new_password')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror

				<input type="password" name="new_password_confirmation" placeholder="Konfirmasi Password Baru" class="form-control my-2 @error('new_password_confirmation') is-invalid @enderror">
				@error('new_password_confirmation')
                    <span class="invalid-feedback" role="alert">
                        <strong>{{ $message }}</strong>
                    </span>
                @enderror

				<button type="submit" class="btn btn-success">Ganti Password</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="{{ asset('assets/js/jquery.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
</body>
</html>
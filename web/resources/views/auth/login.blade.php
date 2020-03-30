@extends('layouts.app')

@section('content')
<div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-md-5 col-12 mx-auto">
            <div class="card p-5">
                <h2 align="center">Login Yunikah</h2>
                @if (Session::has('status'))
                    <div class="alert alert-warning">
                        {{ Session::get('status') }}
                    </div>
                @endif

                <form class="form-group my-3" action="{{ route('login') }}" method="POST">
                    @csrf
                    <div class="form-group">
                        <input class="form-control my-2 @error('username') is-invalid @enderror" type="text" name="username" placeholder="Username" value="{{ old('username') }}"  required autocomplete="username" autofocus>
                        @error('username')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>
                    <div class="form-group">
                        <input class="form-control my-2 @error('password') is-invalid @enderror" type="password" name="password" placeholder="Password"  required autocomplete="current-password">
                        @error('password')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>
                    <input class="btn btn-success w-100" type="submit" value="Login">
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
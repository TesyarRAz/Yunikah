@extends('layouts.app')

@section('content')
<div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-md-5 col-12 mx-auto">
            <div class="card p-3">
                <h2 align="center">Tambah Iklan</h2>

                <form enctype="multipart/form-data" class="form-group my-5" action="{{ route('iklan.store') }}" method="POST">
                    @csrf
                    <div class="form-group row">
                        <label for="name" class="col-md-4 col-form-label text-md-right">{{ __('Name') }}</label>

                        <div class="col-md-6">
                            <input id="name" type="text" class="form-control @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required autocomplete="name" autofocus>

                            @error('name')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="image" class="col-md-4 col-form-label text-md-right">{{ __('Gambar') }}</label>
                        <div class="col-md-6">
                            <input id="image" type="file" class="@error('image') is-invalid @enderror" name="image" accept="image/*">

                            @error('image')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="keterangan" class="col-md-4 col-form-label text-md-right">{{ __('Keterangan') }}</label>

                        <div class="col-md-6">
                            <textarea id="keterangan" type="text" class="form-control @error('keterangan') is-invalid @enderror" name="keterangan" required autocomplete="keterangan" autofocus>{{ old('keterangan') }}</textarea>

                            @error('keterangan')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <input class="btn btn-success w-100" type="submit" value="Tambah Data">
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
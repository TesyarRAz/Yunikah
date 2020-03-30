@extends('layouts.app')

@section('content')
<div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-md-5 col-12 mx-auto">
            <div class="card p-3">
                <h2 align="center">Tambah Pilihan {{ $kategori->name }}</h2>

                <form class="form-group my-5" action="{{ route('kategori.data.store', [request()->jenis, $kategori]) }}" method="POST">
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
                        <label for="harga" class="col-md-4 col-form-label text-md-right">{{ __('Harga') }}</label>

                        <div class="col-md-6">
                            <input id="harga" type="number" class="form-control @error('harga') is-invalid @enderror" name="harga" value="0" required autocomplete="harga" autofocus>

                            @error('harga')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="keterangan" class="col-md-4 col-form-label text-md-right">{{ __('Keterangan') }}</label>

                        <div class="col-md-6">
                            <textarea id="keterangan" class="form-control @error('keterangan') is-invalid @enderror" name="keterangan" required autocomplete="keterangan" autofocus></textarea>

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
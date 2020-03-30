@extends('layouts.app')

@section('content')
<div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-md-7 col-12 mx-auto">
            <div class="card p-3">
                <h2 align="center">Tambah Data {{ ucfirst($selected_kategori->keterangan) }}</h2>

                <form enctype="multipart/form-data" class="form-group my-5" action="{{ route('kategori.store', $selected_kategori->keterangan) }}" method="POST">
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
                            <input id="harga" type="number" class="form-control @error('harga') is-invalid @enderror" name="harga" value="{{ old('harga') ?? 0 }}" required autocomplete="harga" autofocus>

                            @error('harga')
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
                        <label for="mitra" class="col-md-4 col-form-label text-md-right">{{ __('Mitra') }}</label>
                        <div class="col-md-6">
                            <select class="form-control @error('mitra_id') is-invalid @enderror" id="mitra" name="mitra_id">
                                @foreach ($mitra as $m)
                                    <option value="{{ $m->id }}" {{ @old('mitra_id') == $m->id ? 'selected' : ''}}>{{ $m->name }}</option>
                                @endforeach
                            </select>
                            
                            @error('mitra_id')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="type" class="col-md-4 col-form-label text-md-right">{{ __('Type') }}</label>
                        <div class="col-md-6">
                            <select class="form-control @error('type') is-invalid @enderror" id="type" name="type">
                                @foreach (['CUSTOM', 'TERSEDIA', 'COMBO'] as $type)
                                    <option value="{{ $type }}" {{ @old('type') }}>{{ $type }}</option>
                                @endforeach
                            </select>

                            <script type="text/javascript">
                                (function(element, hargaElement) {
                                    element.onchange = function() {
                                        if (element.value === 'TERSEDIA') {
                                            hargaElement.value = 0;
                                            hargaElement.setAttribute('disabled', '');
                                        } else if (element.value === 'CUSTOM' || element.value === 'COMBO') {
                                            hargaElement.removeAttribute('disabled');
                                        }
                                    }
                                    element.onchange();
                                })(document.getElementById("type"), document.getElementById('harga'));
                            </script>
                            
                            @error('type')
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
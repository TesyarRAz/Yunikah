@extends('layouts.app')

@section('content')
<div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-md-5 col-12 mx-auto">
            <div class="container">
                <h2 align="center">Tambah Data Paket</h2>

                <form class="form-group my-5" action="{{ route('paket.data.store', request()->paket) }}" method="POST">
                    @csrf

                    <div class="form-group row">
                        <label for="statusKategori" class="col-md-4 col-form-label text-md-right">{{ __('Kategori Barang') }}</label>
                        <div class="col-md-6">
                            <select class="form-control @error('status_kategori_id') is-invalid @enderror" id="statusKategori" name="status_kategori_id">
                                @foreach ($status_kategori as $m)
                                    <option {{ @old('status_kategori_id') == $m->id ? 'selected' : ''}}>{{ ucfirst(strtolower($m->keterangan)) }}</option>
                                @endforeach
                            </select>
                            
                            @error('status_kategori_id')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="kategori" class="col-md-4 col-form-label text-md-right">{{ __('Nama Barang') }}</label>
                        <div class="col-md-6">
                            <select class="form-control @error('kategori_id') is-invalid @enderror" id="kategori" name="kategori_id">
                                
                            </select>
                            
                            @error('kategori_id')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <input class="btn btn-success w-100" type="submit" value="Tambah Data">
                </form>

                <script type="text/javascript">
                    (function() {
                        var _s = document.getElementById('statusKategori');
                        var _k = document.getElementById('kategori');

                        var _search = (str) => {
                            fetch('{{ url('api/kategori') }}' + '/' + str)
                            .then((e) => e.json())
                            .then((result) => {
                                if (result.length > 0)
                                {
                                    let data = result.map((e) => {
                                        return '<option>' + e.name + '</option>';
                                    }).reduce((e, a) => e + a);

                                    console.log(data);

                                    _k.disabled = false;
                                    _k.innerHTML = data;
                                }
                                else
                                {
                                    _k.disabled = true;
                                    _k.innerHTML = '';
                                }
                            });
                        }

                        _s.onchange = () => {
                            let kategori = _s.value.toLowerCase();

                            _search(kategori);
                        }

                        _search('{{ $status_kategori[0]->keterangan }}');
                    })();
                </script>
            </div>
        </div>
    </div>
</div>
@endsection
@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Pilihan {{ $produk->name }}</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
            <div class="my-2 row justify-content-between">
                <div class="col">
                    <a class="btn btn-sm btn-secondary" href="{{ route('produk.index', $mitra->id) }}">Kembali</a>
                </div>
                <div class="col" align="right">
                    <a class="btn btn-sm btn-primary" href="{{ route('produk.pilihan.create', [$mitra->id, $produk->id]) }}">
                        Tambah
                    </a>
                </div>
            </div>
        	<table class="table table-stripped table-white table-bordered table-responsive-sm">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama</th>
                        <th>Harga</th>
                        <th>Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i++ }}</td>
                            <td>{{ $d->name }}</td>
                            <td>Rp. {{ number_format($d->harga, 2, ',', '.') }}</td>
                            <td>
                                <a class="btn btn-sm btn-danger" href="{{ route('produk.pilihan.edit', [$mitra->id, $produk->id, $d->id]) }}">Edit</a>
                                <button onclick="$('#form-delete-{{ $d->id }}').submit()" class="btn btn-sm btn-warning">Hapus</button>
                                <form action="{{ route('produk.pilihan.destroy', [$mitra->id, $produk->id, $d->id]) }}" id="form-delete-{{ $d->id }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
                                    @csrf
                                    @method('DELETE')
                                </form>
                            </td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>

            {{ $data->render() }}
        </div>
    </div>
</div>

@endsection
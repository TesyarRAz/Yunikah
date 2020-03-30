@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Pilihan {{ $kategori->name }}</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-white table-bordered">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama</th>
                        <th>Harga</th>
                        <th colspan="2">Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $d->name }}</td>
                            <td>Rp. {{ number_format($d->harga, 2, ',', '.') }}</td>
                            <td>
                                <a class="btn btn-danger" href="{{ route('kategori.data.edit', [request()->jenis, $d->kategori_id, $d->id]) }}">Edit</a>
                            </td>
                            <td>
                                <form action="{{ route('kategori.data.destroy', [request()->jenis, $d->kategori_id, $d->id]) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-warning">Hapus</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>

            <a class="btn btn-primary" href="{{ route('kategori.data.create', [request()->jenis, request()->kategori]) }}">
                Tambah Data Baru
            </a>
        </div>
    </div>
</div>

@endsection
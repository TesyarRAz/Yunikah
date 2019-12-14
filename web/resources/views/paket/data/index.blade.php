@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Data Paket</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-white table-bordered">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
                        <th>Nama Kategori</th>
                        <th>Mitra</th>
        				<th>Jenis</th>
                        <th colspan="2">Opsi</th>
        			</tr>
        		</thead>
        		<tbody>
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $d->kategori->name }}</td>
                            <td>{{ $d->kategori->mitra->name }}</td>
                            <td>{{ ucfirst(strtolower($d->kategori->status->keterangan)) }}</td>
                            <td>
                                <a class="btn btn-danger" href="{{ route('paket.data.edit', [request()->paket, $d->id]) }}">Edit</a>
                            </td>
                            <td>
                                <form action="{{ route('paket.data.destroy', [request()->paket, $d->id]) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-warning">Hapus</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>

            <a class="btn btn-primary" href="{{ route('paket.data.create', request()->paket) }}">
                Tambah Data Paket Baru
            </a>
        </div>
    </div>
</div>

@endsection
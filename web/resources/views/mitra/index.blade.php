@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Mitra</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-white table-bordered table-responsive-sm">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama</th>
                        <th>Gambar</th>
                        <th colspan="3">Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i++ }}</td>
                            <td>{{ $d->name }}</td>
                            <td>
                                <button class="btn btn-success" @if(!empty($d->image)) onclick="showModal('{{ asset('assets/images/' . $d->image->name)}}')" @endif>Buka</button>
                            </td>
                            <td>
                                <a class="btn btn-secondary" href="{{ route('produk.index', $d->id) }}">Kelola Produk</a>
                            </td>
                            <td>
                                <a class="btn btn-danger" href="{{ route('mitra.edit', $d->id) }}">Edit</a>
                            </td>
                            <td>
                                <form action="{{ route('mitra.destroy', $d->id) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-warning">Hapus</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>

            {{ $data->render() }}

            <a class="btn btn-primary" href="{{ route('mitra.create') }}">
                Tambah Data Baru
            </a>
        </div>
    </div>
</div>

@endsection
@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Data {{ $paket->name }}</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-white table-bordered">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
                        <th>Nama Kategori</th>
                        <th>Mitra</th>
        				<th>Jenis</th>
                        <th>Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $d->produk->name }}</td>
                            <td>{{ $d->produk->mitra->name }}</td>
                            <td>{{ ucfirst(strtolower($d->produk->kategori->label)) }}</td>
                            <td>
                                <form action="{{ route('paket.detail.destroy', [$paket->id, $d->id]) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
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
        </div>
    </div>
</div>

@endsection
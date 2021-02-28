@extends('layouts.app')

@section('content')

<div class="container">
    @if (Session::has('status'))
        <div class="alert alert-warning">
            {{ Session::get('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Iklan</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
            <div class="my-2" align="right">
                <a class="btn btn-sm btn-primary" href="{{ route('iklan.create') }}">
                    Tambah
                </a>
            </div>
        	<table class="table table-stripped table-white table-bordered table-responsive-sm">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama</th>
                        <th>Gambar</th>
                        <th>Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $d->name }}</td>
                            <td>
                                <a class="btn btn-sm btn-success" href="#" @if(!empty($d->image)) onclick="showModal('{{ asset('assets/images/' . $d->image->name)}}')" @endif>Buka</a>
                            </td>
                            <td>
                                <a class="btn btn-sm btn-danger" href="{{ route('iklan.edit', $d->id) }}">Edit</a>

                                <button class="btn btn-sm btn-warning" onclick="$('#form-delete-{{ $d->id }}').submit()">Hapus</button>
                                <form id="form-delete-{{ $d->id }}" action="{{ route('iklan.destroy', $d->id) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
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
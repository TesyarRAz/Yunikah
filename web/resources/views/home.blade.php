@extends('layouts.app')

@section('content')
<div class="container">
	<h2 class="text-center">Daftar Pemesanan</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-dark bg-dark table-bordered">
        		<thead>
        			<tr>
        				<th>#</th>
        				<th>Nama Pemesan</th>
        				<th>Jenis Pesanan</th>
                        <th>No. Telp</th>
                        <th>Pembelian</th>
                        <th>Opsi</th>
        			</tr>
        		</thead>
        		<tbody>
        			@php $i = 1; @endphp

                    @foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ ucfirst(strtolower($d->jenis)) }}</td>
                            <td>{{ $d->user->name }}</td>
                            <td>{{ $d->user->telp }}</td>
                            <td>{{ number_format($d->total(), ',', '.', 2) }}</td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>
        </div>
    </div>
</div>
@endsection

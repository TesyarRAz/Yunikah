@extends('layouts.app')

@section('content')
<div class="container">
	<h2 class="text-center">Daftar Pemesanan Yang {{ $status_name }}</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
        	<table class="table table-stripped table-white table-bordered">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama Pemesan</th>
        				<th>Jenis Pesanan</th>
                        <th>No. Telp</th>
                        <th>Pembelian</th>
                        <th @if(!empty($prev_status) && !empty($next_status)) colspan="2" @endif>Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
        			@php $i = 1; @endphp

                    @foreach ($data as $d)
                        <tr>
                            <td>{{ $i }}</td>
                            <td>{{ $d->user->name  }}</td>
                            <td>{{ ucfirst(strtolower($d->jenis)) }}</td>
                            <td>{{ $d->user->telp }}</td>
                            <td>{{ number_format($d->total_harga, 2, ',', '.') }}</td>
                            @if (!empty($prev_status))
                                <td>
                                    <a class="btn btn-primary" href="{{ route('home.rubahpesanan', [$d->id, $prev_status->id]) }}">
                                        &lt;- Kembali
                                    </a>
                                </td>
                            @endif

                            @if (!empty($next_status))
                                <td>
                                    <a class="btn btn-primary" href="{{ route('home.rubahpesanan', [$d->id, $next_status->id]) }}">
                                        @php
                                        switch($next_status->keterangan)
                                        {
                                            case 'dikonfirmasi': {
                                                echo 'Konfirmasi';
                                                break;
                                            }
                                            case 'diproses' : {
                                                echo 'Proses';
                                                break;
                                            }
                                            case 'selesai' : {
                                                echo 'Selesai';
                                                break;
                                            }
                                            default: {
                                                echo $next_status->keterangan;
                                                break;
                                            }
                                        }
                                        @endphp
                                        -&gt;
                                    </a>
                                </td>
                            @endif
                        </tr>
                    @endforeach
        		</tbody>
        	</table>
        </div>
    </div>
</div>
@endsection

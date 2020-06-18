@extends('layouts.app')

@section('content')
<div class="container">
    <ul class="breadcrumb">
        @foreach (['dikirim', 'dikonfirmasi', 'diproses', 'selesai'] as $d)
            <li class="breadcrumb-item">
                <a href="{{ route("pemesanan.index.$type", $d) }}" @if($status->name == $d) class="active" @endif>{{ ucfirst($d) }}</a>
            </li>
        @endforeach
    </ul>

    <h2 class="text-center">Daftar {{ ucfirst($type) }} Yang {{ $status->label }}</h2>

    <div class="row align-items-center">
        <div class="col-12 mx-auto">
            <table class="table table-stripped table-white table-bordered">
                <thead class="bg-dark text-white">
                    <tr>
                        <th>#</th>
                        <th>Nama Pemesan</th>
                        @if ($type == 'produk')
                        <th>Produsen</th>
                        <th>Produk</th>
                        @else
                        <th>Paket</th>
                        @endif
                        <th>Total Biaya</th>
                        <th>No.Telp</th>
                        <th>Opsi</th>
                    </tr>
                </thead>
                <tbody class="bg-white">
                    @php $i = 1; @endphp

                    @foreach ($data as $d)
                        <tr>
                            <td>{{ $i++ }}</td>
                            <td>{{ $d->user->name }}</td>
                            @if ($type == 'produk')
                            <td>{{ $d->produk->mitra->name }}</td>
                            <td>{{ $d->produk->name }}</td>
                            @else
                            <td>{{ $d->paket->name }}</td>
                            @endif
                            <td>Rp. {{ number_format($d->harga, 2, ',', '.') }}</td>
                            <td>{{ $d->user->phone }}</td>
                            <td>
                                <a class="btn btn-primary @if($status->sebelum == null) disabled" href="#" @else "href="{{ route("pemesanan.post.$type", [$status->sebelum->name, $d->id]) }}" @endif>
                                    &lt;-
                                </a>
                                <a class="btn btn-success @if($status->setelah == null) disabled" href="#" @else "href="{{ route("pemesanan.post.$type", [$status->setelah->name, $d->id]) }}" @endif>
                                    -&gt;
                                </a>
                                <a class="btn btn-danger" href="{{ route("pemesanan.destroy.$type", $d->id) }}" onclick="return confirm('Yakin ingin ditolak?')">Tolak</a>
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

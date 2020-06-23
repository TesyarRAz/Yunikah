@extends('layouts.app')
@php

use App\Model\Mitra;
use App\Model\Produk;
use App\Model\Iklan;
use App\Model\Paket;
use App\Model\PemesananProduk;
use App\Model\PemesananPaket;

@endphp
@section('content')
<div class="container">
    <h2 class="text-center">Dashboard</h2>

    <div class="row">
        <div class="col-12 col-md-4 my-2">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <h3>Total Data</h3>
                    </div>
                </div>
                <div class="card-body">
                    <table cellpadding="10">
                        <tr>
                            <td>Total Mitra</td>
                            <td>:</td>
                            <td>{{ Mitra::count() }}</td>
                        </tr>
                        <tr>
                            <td>Total Produk</td>
                            <td>:</td>
                            <td>{{ Produk::count() }}</td>
                        </tr>
                        <tr>
                            <td>Total Paket</td>
                            <td>:</td>
                            <td>{{ Paket::count() }}</td>
                        </tr>
                        <tr>
                            <td>Total Iklan</td>
                            <td>:</td>
                            <td>{{ Iklan::count() }}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-8 my-2">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <h3>Pemesanan berdasarkan status</h3>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <table class="col-5 mx-auto" cellpadding="10">
                            <tr class="border-bottom">
                                <td colspan="3">Paket</td>
                            </tr>
                            <tr>
                                <td>Dikirim</td>
                                <td>:</td>
                                <td>{{ PemesananPaket::where('status_pemesanan_id', 2)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Dikonfirmasi</td>
                                <td>:</td>
                                <td>{{ PemesananPaket::where('status_pemesanan_id', 3)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Diproses</td>
                                <td>:</td>
                                <td>{{ PemesananPaket::where('status_pemesanan_id', 4)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Selesai</td>
                                <td>:</td>
                                <td>{{ PemesananPaket::where('status_pemesanan_id', 5)->count() }}</td>
                            </tr>
                        </table>

                        <table class="col-5 mx-auto" cellpadding="10">
                            <tr class="border-bottom">
                                <td colspan="3">Produk</td>
                            </tr>
                            <tr>
                                <td>Dikirim</td>
                                <td>:</td>
                                <td>{{ PemesananProduk::where('status_pemesanan_id', 2)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Dikonfirmasi</td>
                                <td>:</td>
                                <td>{{ PemesananProduk::where('status_pemesanan_id', 3)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Diproses</td>
                                <td>:</td>
                                <td>{{ PemesananProduk::where('status_pemesanan_id', 4)->count() }}</td>
                            </tr>
                            <tr>
                                <td>Selesai</td>
                                <td>:</td>
                                <td>{{ PemesananProduk::where('status_pemesanan_id', 5)->count() }}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

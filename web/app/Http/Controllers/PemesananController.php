<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\StatusPemesanan;
use App\Model\PemesananProduk;
use App\Model\PemesananPaket;

class PemesananController extends Controller
{
    public function index_paket($status = 'dikirim')
    {
        $status = StatusPemesanan::where('name', $status)
        ->firstOrFail();

        $data = $status
        ->pemesanan_paket()
        ->paginate(10);

        return view('pemesanan', ['status' => $status, 'data' => $data, 'type' => 'paket']);
    }

    public function index_produk($status = 'dikirim')
    {
    	$status = StatusPemesanan::where('name', $status)
        ->firstOrFail();

        $data = $status
        ->pemesanan_produk()
        ->paginate(10);

        return view('pemesanan', ['status' => $status, 'data' => $data, 'type' => 'produk']);
    }

    public function post_produk(StatusPemesanan $status, PemesananProduk $pemesanan)
    {
    	$pemesanan->status_pemesanan_id = $status->id;
    	$pemesanan->save();

    	return redirect()->route('pemesanan.index', $status->name);
    }

    public function post_paket(StatusPemesanan $status, PemesananPaket $pemesanan)
    {
    	$pemesanan->status_pemesanan_id = $status->id;
    	$pemesanan->save();

    	return redirect()->route('pemesanan.index', $status->name);
    }

    public function destroy_produk(PemesananProduk $pemesanan)
    {
    	$pemesanan->delete();

    	return back();
    }

    public function destroy_paket(PemesananPaket $pemesanan)
    {
    	$pemesanan->delete();

    	return back();
    }
}

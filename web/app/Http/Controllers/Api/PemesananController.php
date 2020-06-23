<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\PilihanProduk;
use App\Model\Produk;
use App\Model\Paket;
use App\Model\PemesananProduk;
use App\Model\PemesananPaket;

class PemesananController extends Controller
{
    public function show_pemesanan_produk()
    {
        $data = auth()->user()->pemesanan_produk;

        return response($data, 200);
    }

    public function show_pemesanan_paket()
    {
        $data = auth()->user()->pemesanan_paket;

        return response($data, 200);
    }

    public function produk(Request $request, Produk $produk)
    {
    	if ($produk->type == 'tersedia')
        {
            $request->validate([
                'pilihan_produk_id' => 'required|exists:pilihan_produks,id'
            ]);

            $pilihan_produk = PilihanProduk::findOrFail($request->pilihan_produk_id);
            $pemesanan_produk = PemesananProduk::create([
                'user_id' => auth()->id(),
				// Menggunakan Default Keranjang Dengan ID 1
                'status_pemesanan_id' => 1,
                'produk_id' => $produk->id,
                'alamat' => '',
                'harga' => $pilihan_produk->harga,
                'tanggal_pernikahan' => now(),
                'kuantitas' => 1,
                'pilihan_produk_id' => $pilihan_produk->id
            ]);
        }
        else if ($produk->type == 'custom')
        {
            $this->validate($request, [
                'kuantitas' => 'required|numeric'
            ]);

			$pemesanan_produk = PemesananProduk::create([
                'user_id' => auth()->id(),
				// Menggunakan Default Keranjang Dengan ID 1
                'status_pemesanan_id' => 1,
                'produk_id' => $produk->id,
                'alamat' => '',
                'harga' => $produk->harga * (int) $request->kuantitas,
                'tanggal_pernikahan' => now(),
                'kuantitas' => $request->kuantitas
            ]);
        }
        else if ($produk->type == 'combo')
        {
            if (!empty($request->kuantitas))
            {
                $pemesanan_produk = PemesananProduk::create([
	                'user_id' => auth()->id(),
					// Menggunakan Default Keranjang Dengan ID 1
	                'status_pemesanan_id' => 1,
	                'produk_id' => $produk->id,
	                'alamat' => '',
	                'harga' => $produk->harga * (int) $request->kuantitas,
	                'tanggal_pernikahan' => now(),
	                'kuantitas' => $request->kuantitas
	            ]);
            }
            elseif (!empty($request->pilihan_produk_id))
            {
                $pilihan_produk = PilihanProduk::findOrFail($request->pilihan_produk_id);
	            $pemesanan_produk = PemesananProduk::create([
	                'user_id' => auth()->id(),
					// Menggunakan Default Keranjang Dengan ID 1
	                'status_pemesanan_id' => 1,
	                'produk_id' => $produk->id,
	                'alamat' => '',
	                'harga' => $pilihan_produk->harga,
	                'tanggal_pernikahan' => now(),
	                'kuantitas' => 1
	            ]);
            }
            else
            {
                return response(['message' => 'Harus pilih salah satu'], 402);
            }
        }

        return response(['message' => 'Berhasil masukan keranjang'], 200);
    }

    public function paket(Request $request, Paket $paket)
    {
    	PemesananPaket::create([
    		'user_id' => auth()->id(),
			// Menggunakan Default Keranjang Dengan ID 1
            'status_pemesanan_id' => 1,
            'paket_id' => $paket->id,
            'alamat' => '',
            'harga' => $paket->harga,
            'tanggal_pernikahan' => now(),
    	]);

    	return response(['message' => 'Berhasil masukan keranjang'], 200);
    }

    public function checkout_produk(Request $request, PemesananProduk $pemesanan)
    {
    	$request->validate([
			'alamat' => 'required',
            'tanggal_pernikahan' => 'required|date'
    	]);

    	if ($pemesanan->user_id != auth()->id())
        {
            return response([], 401);
        }

        if ($pemesanan->status_pemesanan_id != 1)
        {
            return response([], 401);
        }

    	$pemesanan->status_pemesanan_id = 2;
        $pemesanan->tanggal_pernikahan = $request->tanggal_pernikahan;
        $pemesanan->alamat = $request->alamat;

        $pemesanan->save();

    	return response(['message' => 'Berhasil Checkout'], 200);
    }

    public function checkout_paket(Request $request, PemesananPaket $pemesanan)
    {
    	$request->validate([
			'alamat' => 'required',
            'tanggal_pernikahan' => 'required|date'
    	]);

        if ($pemesanan->user_id != auth()->id())
        {
            return response([], 401);
        }

        if ($pemesanan->status_pemesanan_id != 1)
        {
            return response([], 401);
        }

    	$pemesanan->status_pemesanan_id = 2;
        $pemesanan->tanggal_pernikahan = $request->tanggal_pernikahan;
        $pemesanan->alamat = $request->alamat;

        $pemesanan->save();

    	return response(['message' => 'Berhasil Checkout'], 200);
    }

    public function hapus_produk(Request $request, PemesananProduk $pemesanan)
    {
        $pemesanan->delete();

        return response(['message' => 'Berhasil dihapus'], 200);
    }

    public function hapus_paket(Request $request, PemesananPaket $pemesanan)
    {
        $pemesanan->delete();

        return response(['message' => 'Berhasil dihapus'], 200);
    }
}

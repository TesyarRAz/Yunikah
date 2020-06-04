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
        $data = auth()->user()->pemesanan_produk()->paginate(10);

        return response($data, 200);
    }

    public function show_pemesanan_paket()
    {
        $data = auth()->user()->pemesanan_paket()->paginate(10);

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
                'kuantitas' => 1
            ]);
        }
        else if ($kategori->type == 'custom')
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
        else if ($kategori->type == 'combo')
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

    public function checkout_produk(Request $request, Produk $produk)
    {
    	$request->validate([
			'alamat' => 'required',
            'tanggal_pernikahan' => 'required|date'
    	]);

    	$pemesanans = auth()->user()->pemesanan_produk()
    	// Menggunakan Default Keranjang Dengan ID 1
    	->where('status_pemesanan_id', 1)
    	->where('produk_id', $produk->id)
    	->get();

    	foreach ($pemesanans as $pemesanan)
    	{
    		$pemesanan->status_pemesanan_id = 2;
    		$pemesanan->tanggal_pernikahan = $request->tanggal_pernikahan;
    		$pemesanan->alamat = $request->alamat;

    		$pemesanan->save();
    	}

    	return response(['message' => 'Berhasil Checkout'], 200);
    }

    public function checkout_paket(Request $request, Paket $paket)
    {
    	$request->validate([
			'alamat' => 'required',
            'tanggal_pernikahan' => 'required|date'
    	]);

    	$pakets = auth()->user()->pemesanan_paket()
    	// Menggunakan Default Keranjang Dengan ID 1
    	->where('status_pemesanan_id', 1)
    	->where('paket_id', $paket->id)
    	->get();

    	foreach ($pakets as $paket)
    	{
    		$paket->status_pemesanan_id = 2;
    		$paket->tanggal_pernikahan = $request->tanggal_pernikahan;
    		$paket->alamat = $request->alamat;

    		$paket->save();
    	}

    	return response(['message' => 'Berhasil Checkout'], 200);
    }
}

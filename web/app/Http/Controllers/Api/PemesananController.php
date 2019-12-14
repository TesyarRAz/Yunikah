<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\Pemesanan;
use App\Model\DataPemesanan;
use App\Model\StatusPemesanan;
use App\Model\Paket;
use App\Model\Kategori;

use Auth;

class PemesananController extends Controller
{
    public function index()
    {
        $pemesanan = Pemesanan::with('data')->where([
            'user_id' => Auth::id()
        ])->get();

        $total_harga = 0;
        foreach ($pemesanan as $p)
        {
            $total_harga += $p->harga;
        }

        return response(array_merge($pemesanan, compact('total_harga')), 200);
    }

    public function show($pemesanan_id)
    {
        $pemesanan = Pemesanan::with('data')->where([
            'user_id' => Auth::id(),
            'id' => $pemesanan_id
        ])->first()->toArray();

        $harga = $pemesanan->harga();

        return response(array_merge($pemesanan, compact('harga')), 200);
    }

    public function pesan_satuan(Request $request, $jenis, $kategori_id)
    {
    	$kategori = Kategori::findOrFail($kategori_id);
    	$status = StatusPemesanan::where('keterangan', 'keranjang')->first();

    	$pemesanan = Pemesanan::updateOrCreate([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id
    	], [
    			'user_id' => Auth::id(),
				'status_pemesanan_id' => $status->id,
				'alamat' => '',
				'tanggal_pernikahan' => date('Y-m-d'),
				'jenis' => 'SATUAN',
				'harga' => 0
    		]
    	);

    	$data_pemesanan = DataPemesanan::create([
    		'pemesanan_id' => $pemesanan->id,
    		'kategori_id' => $kategori_id
    	]);

    	return response(['message' => 'Berhasil masukan keranjang'], 200);
    }

    public function pesan_paket(Request $request, $paket_id)
    {
    	$paket = Paket::findOrFail($paket_id);
    	$status = StatusPemesanan::where('keterangan', 'diterima')->first();

    	$pemesanan = Pemesanan::create([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id,
    		'alamat' => $request->alamat,
    		'tanggal_pernikahan' => $request->tanggal_pernikahan,
    		'jenis' => 'PAKET',
    		'harga' => $paket->harga
    	]);

        foreach ($paket->data as $d)
        {
            DataPemesanan::create([
                'pemesanan_id' => $pemesanan->id,
                'kategori_id' => $d->id
            ]);
        }

    	return response(['message' => 'Berhasil masukan keranjang'], 200);
    }

    public function checkout(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'alamat' => 'required',
            'tanggal_pernikahan' => 'required|date'
        ]);

        if ($validator->fails())
        {
            return response(['error' => $validator->errors()], 422);
        }

    	$status = StatusPemesanan::where('keterangan', 'keranjang')->first();
    	$status_dikirim = StatusPemesanan::where('keterangan' => 'dikirim')->first();

    	$pemesanan = Pemesanan::where([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id
    	])->first();

        $pemesanan->status_pemesanan_id = $status_dikirim->id;
        $pemesanan->alamat = $request->alamat;
        $pemesanan->tanggal_pernikahan = $request->tanggal_pernikahan;
        $pemesanan->save();

        return response(['message' => 'Berhasil checkout, tinggal tunggu respon admin'], 200);
    }
}

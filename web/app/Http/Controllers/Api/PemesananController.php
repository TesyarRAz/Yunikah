<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\Pemesanan;
use App\Model\DataPemesanan;
use App\Model\StatusPemesanan;
use App\Model\Paket;
use App\Model\Kategori;
use App\User;

use Auth;
use DB;
use Validator;

class PemesananController extends Controller
{
    public function index()
    {
        $pemesanan = Pemesanan::with('data')->with('status')->where([
            'user_id' => Auth::id()
        ])->get();

        return response($pemesanan, 200);
    }

    public function show($pemesanan_id)
    {
        $pemesanan = Pemesanan::with('data')->with('status')->where([
            'user_id' => Auth::id(),
            'id' => $pemesanan_id
        ])->first();

        return response($pemesanan, 200);
    }

    public function pesan_satuan(Request $request, $jenis, $kategori_id)
    {
    	$kategori = Kategori::findOrFail($kategori_id);
    	$status = StatusPemesanan::where('keterangan', 'keranjang')->first();

    	$pemesanan = Pemesanan::updateOrCreate([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id,
            'jenis' => 'SATUAN'
    	], [
    			'user_id' => Auth::id(),
				'status_pemesanan_id' => $status->id,
				'alamat' => '',
				'tanggal_pernikahan' => date('Y-m-d'),
				'jenis' => 'SATUAN',
				'harga' => 0
    		]
    	);

        $pemesanan->harga = $pemesanan->harga + $kategori->harga;
        $pemesanan->save();

    	$data_pemesanan = DataPemesanan::create([
    		'pemesanan_id' => $pemesanan->id,
    		'kategori_id' => $kategori_id
    	]);

    	return response(['message' => 'Berhasil masukan keranjang'], 200);
    }

    public function pesan_paket(Request $request, $paket_id)
    {
    	$paket = Paket::findOrFail($paket_id);
    	$status = StatusPemesanan::where('keterangan', 'keranjang')->first();

    	$pemesanan = Pemesanan::create([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id,
    		'alamat' => '',
    		'tanggal_pernikahan' => date('Y-m-d'),
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
    	$status_dikirim = StatusPemesanan::where('keterangan', 'dikirim')->first();

    	$pemesanan = Pemesanan::where([
    		'user_id' => Auth::id(),
    		'status_pemesanan_id' => $status->id
    	])->get();

        foreach ($pemesanan as $p)
        {
            $p->status_pemesanan_id = $status_dikirim->id;
            $p->alamat = $request->alamat;
            $p->tanggal_pernikahan = $request->tanggal_pernikahan;
            $p->save();
        }

        return response(['message' => 'Berhasil checkout, tinggal tunggu respon admin'], 200);
    }

    public function hapus_pemesanan($id_pemesanan)
    {
        $pemesanan = Pemesanan::with('data')->where([
            'user_id' => Auth::id(),
            'id' => $id_pemesanan
        ])->firstOrFail();

        DB::table('data_pemesanans')->where('pemesanan_id', $id_pemesanan)->delete();
        $pemesanan->delete();

        return response(['message' => 'Berhasil hapus pemesanan']);
    }

    public function hapus_satuan($id_data_pemesanan)
    {
        $data_pemesanan = DataPemesanan::findOrFail($id_data_pemesanan);
        $pemesanan = $data_pemesanan->pemesanan;
        
        if ($pemesanan->user_id == Auth::id())
        {
            if ($pemesanan->jenis == 'PAKET')
            {
                return response(['message' => '1 paket, tidak bisa dihapus'], 200);
            }

            $data_pemesanan->delete();

            if (count($pemesanan->data) < 1)
            {
                $pemesanan->delete();
            }

            return response(['message' => 'Berhasil hapus data pemesanan'], 200);
        }

        return response(['error' => 'Unauthorized User'], 401);
    }
}

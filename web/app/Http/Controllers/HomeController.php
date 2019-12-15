<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Pemesanan;
use App\Model\StatusPemesanan;
use App\Model\StatusKategori;

use App\User;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */

    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index($status_name = 'dikirim')
    {
        $status = StatusPemesanan::where('keterangan', $status_name)->firstOrFail();
        $data = Pemesanan::where('status_pemesanan_id', $status->id)->get();

        $prev_status = StatusPemesanan::where('id', '<', $status->id)->where('keterangan', '!=', 'keranjang')->orderBy('id', 'desc')->first();
        $next_status = StatusPemesanan::where('id', '>', $status->id)->orderBy('id', 'asc')->first();

        return view('home', compact(['data', 'status_name', 'status', 'next_status', 'prev_status']));
    }

    public function rubahPesanan($id, $status_id)
    {
        $pemesanan = Pemesanan::findOrFail($id);
        $status = StatusPemesanan::findOrFail($status_id);

        $pemesanan->status_pemesanan_id = $status->id;
        $pemesanan->save();

        return redirect()->route('home', $status->keterangan);
    }
}

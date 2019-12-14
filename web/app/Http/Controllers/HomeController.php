<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Pemesanan;
use App\Model\StatusPemesanan;
use App\Model\StatusKategori;

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
    public function index()
    {
        $status = StatusPemesanan::where('keterangan', 'dikirim')->firstOrFail();
        $data = Pemesanan::where('status_pemesanan_id', $status->id)->get();
        $status_kategori = StatusKategori::all();

        return view('home', compact(['data', 'status_kategori']));
    }
}

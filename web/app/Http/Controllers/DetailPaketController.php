<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\CreateDetailPaketRequest;

use App\Model\Paket;
use App\Model\DetailPaket;
use App\Model\Kategori;

class DetailPaketController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Paket $paket)
    {
        $data = $paket->details()->paginate(10);

        return view('paket.detail.index', compact('paket', 'data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Paket $paket)
    {
        $kategori = kategori::all();
        return view('paket.detail.create', compact('paket', 'kategori'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CreateDetailPaketRequest $request)
    {
        $data = new DetailPaket;
        $data->fill($request->only(['produk_id', 'paket_id']));

        $data->save();

        return back()->with('status', 'Berhasil Menambahkan ke paket');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Paket $paket, DetailPaket $detail)
    {
        $detail->delete();

        return redirect()
        ->route('paket.detail.index', $paket->id)
        ->with('status', 'Berhasil menghapus data');
    }
}

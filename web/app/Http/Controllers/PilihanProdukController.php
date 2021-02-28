<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\PilihanProdukRequest;

use App\Model\Mitra;
use App\Model\Produk;
use App\Model\PilihanProduk;

class PilihanProdukController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Mitra $mitra, Produk $produk)
    {
        $data = $produk->pilihans()->paginate(10);

        return view('produk.pilihan.index', compact('mitra', 'produk', 'data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Mitra $mitra, Produk $produk)
    {
        return view('produk.pilihan.create', compact('mitra', 'produk'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(PilihanProdukRequest $request, Mitra $mitra, Produk $produk)
    {
        $request->merge(['produk_id' => $produk->id]);

        $pilihan = PilihanProduk::create($request->all());

        return redirect()
        ->route('produk.pilihan.index', [$mitra->id, $produk->id])
        ->with('status', 'Berhasil Tambah Data');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Mitra $mitra, Produk $produk, PilihanProduk $pilihan)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Mitra $mitra, Produk $produk, PilihanProduk $pilihan)
    {
        return view('produk.pilihan.edit', compact('mitra', 'produk', 'pilihan'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(PilihanProdukRequest $request, Mitra $mitra, Produk $produk, PilihanProduk $pilihan)
    {
        $pilihan->update($request->all());

        return redirect()
        ->route('produk.pilihan.index', [$mitra->id, $produk->id])
        ->with('status', 'Berhasil Edit Data');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Mitra $mitra, Produk $produk, PilihanProduk $pilihan)
    {
        //
    }
}

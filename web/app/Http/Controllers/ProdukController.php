<?php

namespace App\Http\Controllers;

use Str;

use Illuminate\Http\Request;

use App\Http\Requests\ProdukRequest;

use App\Model\Mitra;
use App\Model\Kategori;
use App\Model\Produk;
use App\Model\Paket;

class ProdukController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Mitra $mitra)
    {
        $data = $mitra->produks()->paginate(10);
        $paket = Paket::all();

        return view('produk.index', compact('mitra', 'data', 'paket'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Mitra $mitra)
    {
        $kategori = Kategori::all();

        return view('produk.create', compact('mitra', 'kategori'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ProdukRequest $request, Mitra $mitra)
    {
        $request->merge(['mitra_id' => $mitra->id]);

        $produk = Produk::make($request->all());

        if ($request->image != null)
        {
            $asset = Asset::createNewFile($request->image, [
                'type' => 'image'
            ], 'assets/produk');
            
            $produk->image_id = $asset->id;
        }

        $produk->save();

        return redirect()
        ->route('produk.index', $mitra->id)
        ->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Mitra $mitra, Produk $produk)
    {
        $kategori = Kategori::all();

        return view('produk.edit', compact('produk', 'mitra', 'kategori'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(ProdukRequest $request, Mitra $mitra, Produk $produk)
    {
        $produk->fill($request->all());

        if ($request->image != null)
        {
            $asset = Asset::createNewFile($request->image, [
                'type' => 'image'
            ], 'assets/produk');
            
            $produk->image_id = $asset->id;
        }

        $produk->save();

        return redirect()
        ->route('produk.index', $mitra->id)
        ->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Mitra $mitra, Produk $produk)
    {
        $produk->delete();

        return redirect()
        ->route('produk.index', $mitra->id)
        ->with('status', 'Berhasil dihapus');
    }
}

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\Kategori;
use App\Model\Produk;

class ProdukController extends Controller
{
    public function search(Request $request)
    {
        $data = Produk::where('name', 'rlike', $request->q)->paginate(10);

        return response($data, 200);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Kategori $kategori)
    {
        $data = Produk::with('pilihans')->with('mitra')
        ->where('kategori_id', $kategori->id)
        ->paginate(10);

        return response($data, 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Produk $produk)
    {
        $data = Produk::with('status')->with('mitra')
        ->join('kategoris', 'kategoris.id', '=', 'produks.kategori_id')
        ->findOrFail($id);

        return response($data, 200);
    }
}

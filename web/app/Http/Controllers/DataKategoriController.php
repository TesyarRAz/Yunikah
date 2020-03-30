<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Kategori;
use App\Model\DataKategori;

class DataKategoriController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $kategori = Kategori::findOrFail($request->kategori);
        $data = request()->filterQuery->where('kategori_id', $request->kategori)->get();

        if (request()->routeIs('api'))
        {
            return response($data, 200);
        }

        return view('kategori.data.index', compact('kategori', 'data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('kategori.data.create', ['kategori' => Kategori::findOrFail(request()->kategori)]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {   
        $this->validate($request, [
            'name' => 'required',
            'harga' => 'required|numeric',
            'keterangan' => 'required'
        ]);

        $data = new DataKategori;
        $data->kategori_id = $request->kategori;
        $data->name = $request->name;
        $data->harga = $request->harga;
        $data->keterangan = $request->keterangan;
        $data->save();

        return redirect()
        ->route('kategori.data.index', [$request->jenis, $request->kategori])
        ->with('status', 'Berhasil disimpan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($jenis, $kategori, $id)
    {
        return view('kategori.data.edit', [
            'data' => DataKategori::findOrFail($id),
            'kategori' => Kategori::findOrFail($kategori)
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $jenis, $kategori, $id)
    {
        $this->validate($request, [
            'name' => 'required',
            'harga' => 'required|numeric',
            'keterangan' => 'required'
        ]);

        $data = DataKategori::findOrFail($id);
        $data->name = $request->name;
        $data->harga = $request->harga;
        $data->keterangan = $request->keterangan;
        $data->save();

        return redirect()
        ->route('kategori.data.index', [$request->jenis, $request->kategori])
        ->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($jenis, $kategori, $id)
    {
        $data = DataKategori::findOrFail($id);

        return back()
        ->with('status', $data->delete() ? 'Berhasil Dihapus' : 'Gagal dihapus');
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\StatusKategori;
use App\Model\Kategori;
use App\Model\DataPaket;

class DataPaketController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = request()->filterQuery->get();

        if (request()->routeIs('api'))
        {
            return response($data, 200);
        }

        $status_kategori = StatusKategori::all();

        return view('paket.data.index', compact('data', 'status_kategori'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('paket.data.create', compact('data'));
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
            'kategori_id' => 'required|exists:kategoris,name'
        ]);

        $kategori = Kategori::where('name', $request->kategori_id)->first();

        $data = new DataPaket;
        $data->kategori_id = $kategori->id;
        $data->paket_id = $request->paket;
        $data->save();

        return redirect()->route('paket.data.index', request()->paket)->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($paket, $id)
    {
        $data = DataPaket::find($id);

        if (request()->routeIs('api'))
        {
            return response($data, 200);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($paket, $id)
    {
        $data = DataPaket::findOrFail($id);
        $status_kategori = StatusKategori::all();

        return view('paket.data.edit', compact('data', 'mitra'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'kategori_id' => 'required|exists:kategoris,id'
        ]);

        $data = DataPaket::findOrFail($request->paket);
        $data->kategori_id = $request->kategori_id;
        $data->save();

        return redirect()->route('paket.data.index', request()->paket)->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = DataPaket::findOrFail($id);

        return redirect()->route('paket.data.index', request()->paket)
        ->with('status', $data->delete() ? 'Berhasil dihapus' : 'Gagal dihapus');
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Kategori;
use App\Model\StatusKategori;
use App\Model\Asset;
use App\Model\Mitra;

use DB;
use File;
use Str;

class KategoriController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $jenis = strtolower(request()->jenis);
        $data = [];

        $status_kategori = StatusKategori::where('keterangan', $jenis)->firstOrFail();

        if (!empty($status_kategori))
        {
            $data = request()->filterQuery->where('status_kategori_id', $status_kategori->id)->get();
        }

        if (request()->routeIs('api'))
        {
            return response($data, 200);
        }

        $status_kategori = StatusKategori::all();

        return view('kategori.index', compact('data', 'jenis', 'status_kategori'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $selected_kategori = StatusKategori::where('keterangan', strtolower(request()->jenis))->firstOrFail();
        $status_kategori = StatusKategori::all();
        $mitra = Mitra::all();

        return view('kategori.create', compact('selected_kategori', 'status_kategori', 'mitra'));
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
            'mitra_id' => 'required|exists:mitras,id',
            'image' => 'required|file|image|mimes:jpg,png,jpeg'
        ]);

        $status_kategori = StatusKategori::where('keterangan', strtolower(request()->jenis))->firstOrFail();

        $data = new Kategori;
        $data->name = $request->name;
        $data->harga = $request->harga;
        $data->status_kategori_id = $status_kategori->id;
        $data->mitra_id = $request->mitra_id;

        if ($request->hasFile('image') && $request->image->isValid())
        {
            $asset = Asset::create([
                'name' => Str::random(50) . '.' . $request->image->getClientOriginalExtension(),
                'type' => 'image'
            ]);

            $data->image_id = $asset->id;
            $request->image->move(public_path('uploads/images'), $asset->name);
        }

        $data->save();

        return redirect()->route('kategori.index', request()->jenis)->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Kategori::find($id);

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
    public function edit($jenis, $id)
    {
        $data = Kategori::findOrFail($id);
        $selected_kategori = StatusKategori::where('keterangan', strtolower(request()->jenis))->firstOrFail();
        $status_kategori = StatusKategori::all();
        $mitra = Mitra::all();

        return view('kategori.edit', compact('selected_kategori', 'status_kategori', 'data', 'mitra'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $jenis, $id)
    {
        $this->validate($request, [
            'name' => 'required',
            'harga' => 'required|numeric',
            'mitra_id' => 'required|exists:mitras,id',
            'image' => 'file|image|mimes:jpg,png,jpeg'
        ]);

        $status_kategori = StatusKategori::where('keterangan', strtolower(request()->jenis))->firstOrFail();

        $data = Kategori::findOrFail($id);
        $data->name = $request->name;
        $data->harga = $request->harga;
        $data->status_kategori_id = $status_kategori->id;
        $data->mitra_id = $request->mitra_id;

        if ($request->hasFile('image') && $request->image->isValid())
        {
            $asset = Asset::create([
                'name' => Str::random(50) . '.' . $request->image->getClientOriginalExtension(),
                'type' => 'image'
            ]);

            $data->image_id = $asset->id;
            $request->image->move(public_path('uploads/images'), $asset->name);
        }

        $data->save();

        return redirect()->route('kategori.index', request()->jenis)->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = Kategori::findOrFail($id);

        return redirect()->route('kategori.index', request()->jenis)
        ->with('status', $data->delete() ? 'Berhasil dihapus' : 'Gagal dihapus');
    }
}

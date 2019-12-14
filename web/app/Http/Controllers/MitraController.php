<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Mitra;
use App\Model\StatusKategori;
use App\Model\Asset;

use DB;
use File;
use Str;

class MitraController extends Controller
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

        return view('mitra.index', compact('data', 'status_kategori'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $status_kategori = StatusKategori::all();

        return view('mitra.create', compact('status_kategori'));
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
            'image' => 'required|file|image|mimes:jpg,png,jpeg'
        ]);

        $data = new Mitra;
        $data->name = $request->name;

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

        return redirect()->route('mitra.index')->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Mitra::find($id);

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
    public function edit($id)
    {
        $data = Mitra::findOrFail($id);
        $status_kategori = StatusKategori::all();

        return view('mitra.edit', compact('status_kategori', 'data'));
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
            'name' => 'required',
            'image' => 'file|image|mimes:jpg,png,jpeg'
        ]);

        $data = Mitra::findOrFail($id);
        $data->name = $request->name;
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

        return redirect()->route('mitra.index')->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = Mitra::findOrFail($id);

        return redirect()->route('mitra.index')
        ->with('status', $data->delete() ? 'Berhasil dihapus' : 'Gagal dihapus');
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Model\Iklan;
use App\Model\StatusKategori;
use App\Model\Asset;

use DB;
use File;
use Str;

class IklanController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = request()->filterQuery->with('image')->get();

        if (request()->routeIs('api'))
        {
            return response($data, 200);
        }

        return view('iklan.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('iklan.create');
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

        $data = new Iklan;
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

        if ($request->filled('keterangan'))
        {
            $data->keterangan = $request->keterangan;
        }

        $data->save();

        return redirect()->route('iklan.index')->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Iklan::with('image')->find($id);

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
        $data = Iklan::findOrFail($id);
        $status_kategori = StatusKategori::all();

        return view('iklan.edit', compact('status_kategori', 'data'));
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

        $data = Iklan::findOrFail($id);
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

        if ($request->filled('keterangan'))
        {
            $data->keterangan = $request->keterangan;
        }

        $data->save();

        return redirect()->route('iklan.index')->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = Iklan::findOrFail($id);

        return redirect()->route('iklan.index')
        ->with('status', $data->delete() ? 'Berhasil dihapus' : 'Gagal dihapus');
    }
}

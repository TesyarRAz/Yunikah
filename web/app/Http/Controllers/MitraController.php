<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\MitraRequest;

use App\Model\Mitra;

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
        $data = Mitra::paginate(10);

        return view('mitra.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('mitra.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(MitraRequest $request)
    {
        $mitra = Mitra::make($request->validate());

        if ($request->image != null)
        {
            $asset = Asset::createNewFile($request->image, [
                'type' => 'image'
            ], 'assets/mitra');
            
            $mitra->image_id = $asset->id;
        }

        $mitra->save();

        return redirect()
        ->route('mitra.index')
        ->with('status', 'Berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Mitra $mitra)
    {
        return view('mitra.edit', ['data' => $mitra]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(MitraRequest $request, Mitra $mitra)
    {
        $mitra->fill($request->validate());

        if ($request->image != null)
        {
            $asset = Asset::createNewFile($request->image, [
                'type' => 'image'
            ], 'assets/mitra');

            $mitra->image_id = $asset->id;
        }

        $mitra->save();

        return redirect()
        ->route('mitra.index')
        ->with('status', 'Berhasil diedit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Mitra $mitra)
    {
        $mitra->delete();

        return redirect()
        ->route('mitra.index')
        ->with('status', 'Berhasil dihapus');
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\MitraRequest;

use App\Model\Mitra;

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
        $mitra = new Mitra;
        $mitra->fill($request->only(['name', 'alamat', 'keterangan']));

        $this->fillAssetImage($mitra);

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
        $mitra->fill($request->only(['name', 'alamat', 'keterangan']));

        $this->fillAssetImage($mitra);

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

    private function fillAssetImage($model)
    {
        if (request()->hasFile('image') && request()->image->isValid())
        {
            $asset = Asset::create([
                'name' => Str::random(50) . '.' . request()->image->getClientOriginalExtension(),
                'type' => 'image'
            ]);

            $model->image_id = $asset->id;
            request()->image->move(public_path('assets/images'), $asset->name);
        }
    }
}

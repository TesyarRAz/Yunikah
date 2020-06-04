<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\PaketRequest;

use Str;

use App\Model\Paket;
use App\Model\Asset;

class PaketController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = Paket::paginate(10);

        return view('paket.index', compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('paket.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(PaketRequest $request)
    {
        $paket = new Paket;

        $paket->fill($request->only(['name', 'harga', 'keterangan']));

        $this->fillAssetImage($paket);

        $paket->save();

        return redirect()
        ->route('paket.index')
        ->with('status', 'Berhasil tambah data');
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
    public function edit(Paket $paket)
    {
        return view('paket.edit', compact('paket'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(PaketRequest $request, Paket $paket)
    {
        $paket->fill($request->only(['name', 'harga', 'keterangan']));

        $this->fillAssetImage($paket);

        $paket->save();

        return redirect()
        ->route('paket.index')
        ->with('status', 'Berhasil edit data');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Paket $paket)
    {
        $paket->delete();

        return redirect()
        ->route('paket.index')
        ->with('status', 'Berhasil hapus data');
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

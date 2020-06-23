<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\IklanRequest;

use App\Model\Iklan;
use App\Model\Asset;

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
        $data = Iklan::paginate(10);

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
    public function store(IklanRequest $request)
    {
        $iklan = new Iklan;
        $iklan->fill($request->only(['name', 'keterangan']));

        $this->fillAssetImage($iklan);

        $iklan->save();

        return redirect()->route('iklan.index')->with('status', 'Berhasil menambah iklan');
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
    public function edit(Iklan $iklan)
    {
        return view('iklan.edit', compact('iklan'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(IklanRequest $request, Iklan $iklan)
    {
        $iklan->fill($request->only(['name', 'keterangan']));

        $this->fillAssetImage($iklan);

        $iklan->save();

        return redirect()->route('iklan.index')->with('status', 'Berhasil mengedit iklan');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Iklan $iklan)
    {
        $iklan->delete();

        return redirect()->route('iklan.index')->with('status', 'Berhasil menghapus iklan');
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

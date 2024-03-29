<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\Mitra;
use App\Model\Produk;

class MitraController extends Controller
{
    public function search(Request $request)
    {
        $data = Mitra::where('name', 'rlike', $request->q)->paginate(10);

        return response($data, 200);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = Mitra::paginate(10);

        return response($data, 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Mitra::findOrFail($id);

        return response($data, 200);
    }

    public function produk($id)
    {
        $data = Produk::with('mitra')->where('mitra_id', $id)->paginate(10);

        return response($data, 200);
    }

}

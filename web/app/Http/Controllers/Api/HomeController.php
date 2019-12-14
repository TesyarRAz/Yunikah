<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Model\Paket;
use App\Model\AlatPesta;

class HomeController extends Controller
{
    public function paket()
    {
    	$pakets = Paket::all();

    	return response($pakets, 200);
    }

    public function alat()
    {
    	$alats = AlatPesta::all();

    	return response($alats, 200);
    }
}

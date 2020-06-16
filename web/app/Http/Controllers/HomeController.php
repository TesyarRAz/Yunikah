<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
    	return redirect()->route('dashboard');
    }

    public function api_test()
    {
    	return view('apitest');
    }
}

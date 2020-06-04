<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Auth;
use Hash;

class UserController extends Controller
{
	public function index()
	{
		return response(auth()->user(), 200);
	}

    public function post(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);
        
    	if (auth()->check()) abort(404);

		if (auth()->attempt($request->only(['username', 'password'])))
    	{
            $token = auth()->user()->createToken($request->getClientIp())->plainTextToken;

            return response(['token' => $token], 200);
    	}

    	return response(['error' => 'username atau password salah'], 401);
    }
}

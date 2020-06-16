<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\User;

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
            auth()->user()->token = auth()->user()->createToken($request->getClientIp())->plainTextToken;

            return response(auth()->user(), 200);
    	}

    	return response(['error' => 'username atau password salah'], 401);
    }

    public function logout()
    {
        auth()->logout();

        return response([], 200);
    }
}

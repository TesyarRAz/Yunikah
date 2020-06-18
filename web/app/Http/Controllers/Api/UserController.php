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

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'phone' => 'required',
            'email' => 'required|email',
            'username' => 'required|min:5|',
            'password' => 'required|min:5'
        ]);

        if (User::where('username', $request->username)->orWhere('email', $request->email)->count() > 0)
        {
            return response(['message' => 'email sudah ada'], 401);
        }

        $request->replace(['password' => Hash::make($request->password)]);

        User::create($request->only([
            'name', 'phone', 'email', 'username'
        ]));

        return response(['message' => 'Berhasil'], 200);
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

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

        $user = new User;
        $user->fill($request->only(['name', 'phone', 'email', 'username']));
        $user->password = Hash::make($request->password);
        $user->save();

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

    public function update(Request $request)
    {
        $data = $request->validate([
            'name' => 'required',
            'phone' => 'required'
        ]);

        auth()->user()->update($data);

        return response(['message' => 'berhasil'], 401);
    }

    public function change_password(Request $request)
    {
        $request->validate([
            'password' => 'required',
            'new_password' => 'required|confirmed|min:5'
        ]);

        if (Hash::check($request->password, auth()->user()->password))
        {
            auth()->user()->password = Hash::make($request->new_password);
            auth()->user()->save();

            auth()->logout();

            return response(['message' => 'success'], 200);
        }

        return response(['message' => 'Password Lama Salah'], 401);
    }

    public function logout()
    {
        auth()->logout();

        return response([], 200);
    }
}

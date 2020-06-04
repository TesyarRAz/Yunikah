<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Auth;
use Hash;

class UserController extends Controller
{

    public function show()
    {
    	if (auth()->check()) return redirect()->route('home');

    	return view('auth.login');
    }

    public function post(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        if (auth()->check()) return redirect()->route('home');

    	if (auth()->attempt($request->only(['username', 'password'])))
    	{
            if (auth()->user()->level == 'user')
            {
                auth()->logout();

                return back()->withErrors(['login' => 'anda tidak punya hak akses']);
            }

    		return redirect()->route('home');
    	}

    	return back()->withErrors(['login' => 'username atau password salah']);
    }

    public function logout()
    {
        auth()->logout();

        return redirect()->route('home');
    }

    public function change_password_view()
    {
        return view('auth.resetpassword');
    }

    public function change_password_post(Request $request)
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

            return redirect()->route('login');
        }

        return back()->withErrors(['password' => 'Password Lama Salah']);
    }
}

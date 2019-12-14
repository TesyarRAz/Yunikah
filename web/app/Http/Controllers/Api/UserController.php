<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\User;

use Validator;
use Auth;

class UserController extends Controller
{
	public function register(Request $request)
	{
		$validator = Validator::make($request->all(), [
			'name' => 'required',
			'telp' => 'required|numeric',
    		'username' => 'required|unique:users',
    		'password' => 'required',
    		'alamat' => 'required'
    	]);

    	if ($validator->fails())
    	{
    		return response(['error' => $validator->errors()]);
    	}

        $status_user = StatusUser::where('keterangan', 'user')->first();

    	$user = User::create(
            array_merge($request->all(), ['status_user_id' => $status_user->id])
        );

    	return response(['message' => 'Berhasil Register'], 201);
	}

    public function login(Request $request)
    {
    	$validator = Validator::make($request->all(), [
    		'username' => 'required',
    		'password' => 'required'
    	]);

    	if ($validator->fails())
    	{
    		return response(['error' => $validator->errors()]);
    	}

    	if (Auth::attempt(['username' => $request->username, 'password' => $request->password]))
    	{
    		$user = Auth::user();
    		$user['token'] = $user->createToken('nApp')->accessToken;

    		return response($user, 200);
    	}

    	return response(['error' => 'Invalid User'], 401);
    }

    public function logout()
    {
    	if (Auth::check())
    	{
    		Auth::user()->token()->revoke();

    		return response(['message' => 'Success Logout'], 200);
    	}

    	return response(['error' => 'Unauthorized User'], 401);
    }
}

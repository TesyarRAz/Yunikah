<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\User;
use App\Model\StatusUser;

use Validator;
use Auth;
use Hash;

class UserController extends Controller
{
    public function index()
    {
        return Auth::user();
    }
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

        $status_user = StatusUser::where('keterangan', 'user')->firstOrFail();

        $data = $request->all();
        $data['password'] = Hash::make($request->password);
        $data['status_user_id'] = $status_user->id;

    	$user = User::create($data);
        $data['token'] = $user->createToken('nApp')->accessToken;

    	return response(['message' => 'Berhasil Register', 'data' => $user], 201);
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

    public function changePassword(Request $request)
    {
        $rules = [
            'old_password' => 'required',
            'new_password' => 'required|confirmed'
        ];

        $validator = $request->routeIs('api') ? Validator::make($request->all(), $rules) : $request->validate($rules);

        if ($request->routeIs('api'))
        {
            if ($validator->fails())
            {
                return response($validator->errors(), 422);
            }
        }

        $user = Auth::user();
        if (Hash::check($request->old_password, $user->password))
        {
            $user->password = Hash::make($request->new_password);
            $user->save();

            if ($request->routeIs('api'))
            {
                return response($validator->errors(), 422);
            }

            return back()->with('status', 'Berhasil Ganti Password');
        }

        if ($request->routeIs('api'))
        {
            return response(['message' => 'Password lama salah!'], 401);
        }

        return back()->with('status', 'Password lama salah!');
    }

    public function updateData(Request $request)
    {
        $rules = [
            'name' => 'required',
            'telp' => 'required|numeric',
            'alamat' => 'required'
        ];

        if ($validator->fails())
        {
            return response(['error' => $validator->errors()]);
        }

        $user = Auth::user();
        $user->name = $request->name;
        $user->telp = $request->telp;
        $user->alamat = $request->alamat;

        $user->save();

        return response(['message' => 'Berhasil edit data']);
    }
}

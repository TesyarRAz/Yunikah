<?php

namespace App\Http\Middleware;

use Closure;
use Auth;
use Route;

use App\User;
use App\Model\StatusUser;

class AccessMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $guard)
    {
        $user = Auth::user();
        $status = StatusUser::where('keterangan', $guard)->first();

        if (!empty($status))
        {
            if ($user->status->id != $status->id)
            {
                if (Route::is('api'))
                {
                    return response(['error' => 'Unauthorized User'], 401);
                }
                else
                {
                    Auth::logout();

                    return redirect()->route('login')->with('status', 'Kau bukan admin');
                }
            }
        }

        return $next($request);
    }
}

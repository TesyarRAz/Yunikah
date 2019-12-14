<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

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
                return response(['error' => 'Unauthorized User'], 401);
        }

        return $next($request);
    }
}

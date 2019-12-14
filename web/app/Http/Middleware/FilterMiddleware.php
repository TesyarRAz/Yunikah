<?php

namespace App\Http\Middleware;

use Closure;

use DB;

class FilterMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $model)
    {
        $query = ('\App\Model\\' . $model)::select('*');

        if (request()->has('_limit'))
        {
            $query->limit(request()->_limit);
            
            if (request()->has('_offset'))
            {
                $query->offset(request()->_offset);
            }
        }

        $request->filterQuery = $query;

        return $next($request);
    }
}

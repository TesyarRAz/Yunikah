<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Asset extends Model
{
    protected $guarded = ['id'];
    protected $appends = ['link'];

    public function getLinkAttribute()
    {
    	return asset('assets/images/' . $this->name);
    }
}

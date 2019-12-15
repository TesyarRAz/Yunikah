<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Asset extends Model
{
    protected $fillable = [
    	'name', 'type'
    ];
    protected $appends = [
    	'image_link'
    ];

    public function getImageLinkAttribute()
    {
    	return asset('uploads/images') . '/' . $this->name;
    }
}

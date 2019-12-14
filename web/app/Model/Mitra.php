<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Mitra extends Model
{
    protected $fillable = [
    	'image_id', 'name'
    ];

    public function image()
	{
		return $this->belongsTo(Asset::class, 'image_id');
	}
}

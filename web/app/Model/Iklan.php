<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Iklan extends Model
{
    protected $fillable = [
    	'image_id', 'name', 'keterangan'
    ];

    public function image()
	{
		return $this->belongsTo(Asset::class, 'image_id');
	}
}

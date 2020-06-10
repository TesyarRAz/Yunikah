<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Mitra extends Model
{
    protected $guarded = ['id'];

    public function produks()
    {
    	return $this->hasMany('App\Model\Produk');
    }

    public function image()
    {
    	return $this->belongsTo('App\Model\Asset', 'image_id');
    }
}

<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Paket extends Model
{
    protected $guarded = ['id'];
    protected $with = ['image'];

    public function image()
    {
        return $this->belongsTo('App\Model\Asset', 'image_id');
    }

    public function details()
    {
    	return $this->hasMany('App\Model\DetailPaket');
    }
}

<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class PemesananProduk extends Model
{
    protected $guarded = ['id'];

    public function produk()
    {
    	return $this->belongsTo('App\Model\Produk');
    }

    public function user()
    {
    	return $this->belongsTo('App\User');
    }

    public function status()
    {
    	return $this->belongsTo('App\Model\StatusPemesanan');
    }
}

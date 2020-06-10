<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class PilihanProduk extends Model
{
    protected $guarded = ['id'];

    public function produk()
    {
    	return $this->belongsTo('App\Model\Produk');
    }
}

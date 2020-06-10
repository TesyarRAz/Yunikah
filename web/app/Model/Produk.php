<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Produk extends Model
{
    protected $guarded = ['id'];
    protected $with = ['image'];

    public function kategori()
    {
    	return $this->belongsTo('App\Model\Kategori');
    }

    public function mitra()
    {
    	return $this->belongsTo('App\Model\Mitra');
    }

    public function pilihans()
    {
    	return $this->hasMany('App\Model\PilihanProduk');
    }

    public function image()
    {
    	return $this->belongsTo('App\Model\Asset', 'image_id');
    }
}

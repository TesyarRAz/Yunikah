<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class StatusPemesanan extends Model
{
    protected $guarded = ['id'];

    public function getSetelahAttribute()
    {
    	return static::orderBy('id', 'asc')
    	->firstWhere('id', '>', $this->id);
    }

    public function getSebelumAttribute()
    {
    	return static::orderBy('id', 'desc')
    	->where('name', '!=', 'keranjang')
    	->firstWhere('id', '<', $this->id);
    }

    public function pemesanan_produk()
    {
        return $this->hasMany('App\Model\PemesananProduk');
    }

    public function pemesanan_paket()
    {
        return $this->hasMany('App\Model\PemesananPaket');
    }
}

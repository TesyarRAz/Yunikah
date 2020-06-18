<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

use App\Model\PemesananProduk;

class Produk extends Model
{
    protected $guarded = ['id'];
    protected $with = ['image', 'mitra'];
    protected $appends = ['total_transaksi'];

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

    public function getTotalTransaksiAttribute()
    {
        // Status Pemesanan Selesai ID nya 
        return PemesananProduk::join('produks', 'produks.id', '=', 'produk_id')
        ->where('produk_id', $this->id)
        ->where('status_pemesanan_id', 5)
        ->count();
    }
}

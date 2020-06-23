<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

use App\Model\PemesananProduk;

class Mitra extends Model
{
    protected $guarded = ['id'];
    protected $with = ['image'];
    protected $appends = ['total_transaksi'];

    public function produks()
    {
    	return $this->hasMany('App\Model\Produk');
    }

    public function image()
    {
    	return $this->belongsTo('App\Model\Asset', 'image_id');
    }

    public function getTotalTransaksiAttribute()
    {
        // Status Pemesanan Selesai ID nya 
        return PemesananProduk::join('produks', 'produks.id', '=', 'produk_id')
        ->join('mitras', 'mitras.id', '=', 'produks.mitra_id')
        ->where('mitra_id', $this->id)
        ->where('status_pemesanan_id', 5)
        ->count();
    }
}

<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class DataPemesanan extends Model
{
    protected $fillable = [
    	'pemesanan_id', 'kategori_id', 'data_kategori_id', 'qty'
    ];

    public function pemesanan()
    {
    	return $this->belongsTo(Pemesanan::class);
    }

    public function kategori()
    {
    	return $this->belongsTo(Kategori::class);
    }

    public function dataKategori()
    {
        return $this->belongsTo(DataKategori::class);
    }
}

<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class DataPemesanan extends Model
{
    protected $fillable = [
    	'pemesanan_id', 'kategori_id'
    ];

    public function pemesanan()
    {
    	return $this->belongsTo(Pemesanan::class);
    }

    public function kategori()
    {
    	return $this->belongsTo(Kategori::class);
    }
}

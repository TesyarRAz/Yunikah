<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class DataPaket extends Model
{
    protected $fillable = [
    	'paket_id', 'kategori_id'
    ];

    public function paket()
    {
    	return $this->belongsTo(Paket::class);
    }

    public function kategori()
    {
    	return $this->belongsTo(Kategori::class);
    }
}

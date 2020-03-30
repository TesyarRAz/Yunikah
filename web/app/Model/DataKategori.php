<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class DataKategori extends Model
{
    protected $fillable = [
        'kategori_id', 'name', 'harga', 'keterangan'
    ];

    public function kategori()
    {
        return $this->belongsTo(Kategori::class);
    }
}

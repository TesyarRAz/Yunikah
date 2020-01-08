<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Kategori extends Model
{
    protected $fillable = [
    	'image_id', 'mitra_id', 'status_kategori_id', 'name', 'harga'
    ];
    
    protected $with = ['image', 'status'];

    public function image()
    {
        return $this->belongsTo(Asset::class, 'image_id');
    }

    public function mitra()
    {
    	return $this->belongsTo(Mitra::class);
    }

    public function status()
    {
    	return $this->belongsTo(StatusKategori::class, 'status_kategori_id');
    }
}

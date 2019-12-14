<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Paket extends Model
{
    protected $fillable = [
    	'image_id', 'name', 'harga'
	];

	public function data()
	{
		return $this->hasMany(DataPaket::class, 'paket_id');
	}

	public function image()
	{
		return $this->belongsTo(Asset::class, 'image_id');
	}
}

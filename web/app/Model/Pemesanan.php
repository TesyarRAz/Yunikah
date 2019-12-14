<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Pemesanan extends Model
{
    protected $fillable = [
    	'user_id', 'status_pemesanan_id', 'alamat', 'tanggal_pernikahan', 'harga', 'jenis'
    ];

	public function data()
	{
		return $this->hasMany(DataPemesanan::class, 'pemesanan_id');
	}

	public function status()
	{
		return $this->belongsTo(StatusPemesanan::class, 'status_pemesanan_id');
	}

	public function user()
	{
		return $this->belongsTo(User::class, 'user_id');
	}

	public function harga()
	{
		if ($this->jenis == 'PAKET')
			return $this->harga;

		$total_harga = 0;
		foreach ($this->data as $d)
		{
			$total_harga += $d->harga;
		}

		return $total_harga;
	}
}

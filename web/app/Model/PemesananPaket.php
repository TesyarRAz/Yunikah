<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class PemesananPaket extends Model
{
    protected $guarded = ['id'];
    protected $with = ['status', 'paket'];

    public function paket()
    {
    	return $this->belongsTo('App\Model\Paket');
    }

    public function user()
    {
    	return $this->belongsTo('App\User');
    }
    
    public function status()
    {
    	return $this->belongsTo('App\Model\StatusPemesanan', 'status_pemesanan_id');
    }
}

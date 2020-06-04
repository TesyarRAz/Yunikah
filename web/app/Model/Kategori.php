<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Kategori extends Model
{
    protected $guarded = ['id'];

    public function produks()
    {
        return $this->hasMany('App\Model\Produk');
    }
}

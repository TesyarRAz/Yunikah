<?php

use Illuminate\Database\Seeder;

use App\Model\Asset;
use App\Model\Paket;
use App\Model\DetailPaket;
use App\Model\Produk;

class PaketSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $image = Asset::create([
        	'name' => 'paket-1.jpg',
        	'type' => 'image'
        ]);

        $paket = Paket::create([
        	'name' => 'Paket Murah Meriah',
        	'harga' => 1000000,
        	'keterangan' => 'Paket Murah Meriah Tersedia Dari Paket Ketring Nanas 500porsi dan Ketring Petis 200porsi',
        	'image_id' => $image->id
        ]);

        DetailPaket::create([
        	'paket_id' => $paket->id,
        	'produk_id' => Produk::findOrFail(1)->id
        ]);

        DetailPaket::create([
        	'paket_id' => $paket->id,
        	'produk_id' => Produk::findOrFail(2)->id
        ]);
    }
}

<?php

use Illuminate\Database\Seeder;

use App\Model\Asset;
use App\Model\Mitra;
use App\Model\Kategori;
use App\Model\Produk;

class ProdukSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $mitra = Mitra::findOrFail(1);
        $ketring = Kategori::where('name', 'ketring')->first();
        $image1 = Asset::create([
        	'name' => 'ketring-1.jpg'
        ]);
        $image2 = Asset::create([
        	'name' => 'ketring-2.jpg'
        ]);

        Produk::create([
        	'name' => 'Petis',
        	'harga' => 0,
        	'type' => 'tersedia',
        	'kategori_id' => $ketring->id,
        	'keterangan' => 'Petis Nikmat Dibuat Dengan Hati',
        	'mitra_id' => $mitra->id,
        	'image_id' => $image1->id
        ]);

        Produk::create([
        	'name' => 'Nanas Petis',
        	'harga' => 5000,
        	'type' => 'custom',
        	'kategori_id' => $ketring->id,
        	'keterangan' => 'Petis Nanas Muda, Enak. Untuk Pemesanan Dihitung per satu mangkok',
        	'mitra_id' => $mitra->id,
        	'image_id' => $image2->id
        ]);
    }
}

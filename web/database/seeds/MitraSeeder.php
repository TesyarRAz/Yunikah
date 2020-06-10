<?php

use Illuminate\Database\Seeder;

use App\Model\Asset;
use App\Model\Mitra;

class MitraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$image = Asset::create([
    		'name' => 'mitra-1.jpg',
    		'type' => 'image'
    	]);

        Mitra::create([
        	'name' => 'Ketring Mamah Saya',
        	'alamat' => 'Jln Cianjur Km 8',
        	'keterangan' => 'Ketring Mamah Yang Terpercaya, Berdiri sejak 2019',
        	'image_id' => $image->id
        ]);
    }
}

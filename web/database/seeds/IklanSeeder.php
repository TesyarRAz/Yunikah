<?php

use Illuminate\Database\Seeder;

use App\Model\Asset;
use App\Model\Iklan;

class IklanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$image = Asset::create([
    		'name' => 'ketring-1.jpg',
    		'type' => 'image'
    	]);
        Iklan::create([
        	'name' => 'Iklan Petis',
        	'keterangan' => '{ "redirect" : "kategori", "params" : { "jenis" : "ketring", "id" : "1" } }',
        	'image_id' => $image->id
        ]);
    }
}

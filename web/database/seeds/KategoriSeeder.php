<?php

use Illuminate\Database\Seeder;

use App\Model\Kategori;

class KategoriSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$data = [
    		'hiburan' => 'Hiburan Ketika Pernikahan',
    		'rias' => 'Rias Ketika Pernikahan', 
    		'undangan' => 'Undangan Ketika Pernikahan', 
    		'photo' => 'Photo Ketika Pernikahan', 
    		'gedung' => 'Gedung Ketika Pernikahan', 
    		'tenda' => 'Tenda Ketika Pernikahan', 
    		'ketring' => 'Ketring Ketika Pernikahan'
    	];

        foreach ($data as $name => $keterangan)
        {
        	Kategori::create([
        		'name' => $name,
        		'label' => ucfirst($name),
        		'keterangan' => $keterangan
        	]);
        }
    }
}

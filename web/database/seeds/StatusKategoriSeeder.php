<?php

use Illuminate\Database\Seeder;

use App\Model\StatusKategori;

class StatusKategoriSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $status = [
            'rias', 
            'hiburan', 
            'undangan', 
            'gedung', 
            'tenda', 
            'photo'
        ];

        foreach ($status as $d)
        {
        	StatusKategori::create([
        		'keterangan' => $d
        	]);
        }
    }
}

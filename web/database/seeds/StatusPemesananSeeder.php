<?php

use Illuminate\Database\Seeder;

use App\Model\StatusPemesanan;

class StatusPemesananSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $status = ['keranjang', 'dikirim', 'dikonfirmasi', 'diproses', 'selesai'];

        foreach ($status as $d)
        {
        	StatusPemesanan::create([
        		'keterangan' => $d
        	]);
        }
    }
}

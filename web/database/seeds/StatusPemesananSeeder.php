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
    	$status = [
            'keranjang' => 'Barang dimasukan keranjang, belum dikonfirmasi benar atau tidaknya', 
            'dikirim' => 'Barang sudah dikonfirmasi akan dibeli, tinggal menunggu admin mengkonfirmasi', 
            'dikonfirmasi' => 'Barang sudah dikonfirmasi oleh admin, admin akan melakukan pendataan pada pembeli', 
            'diproses' => 'Barang sudah diproses dan siap di kirim pada hari H', 
            'selesai' => 'Barang sudah selesai'
        ];

        foreach ($status as $name => $keterangan)
        {
        	StatusPemesanan::create([
        		'name' => $name,
        		'label' => ucfirst($name),
        		'keterangan' => $keterangan
        	]);
        }
    }
}

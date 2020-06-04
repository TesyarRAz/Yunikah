<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePemesananProduksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pemesanan_produks', function (Blueprint $table) {
            $table->id();
            
            $table->foreignId('user_id')->constrained();
            $table->foreignId('status_pemesanan_id')->constrained();
            $table->foreignId('produk_id')->constrained();

            $table->longText('alamat');
            $table->date('tanggal_pernikahan');
            $table->bigInteger('harga')->unsigned();
            $table->integer('kuantitas');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pemesanan_produks');
    }
}

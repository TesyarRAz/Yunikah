<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDataPemesanansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('data_pemesanans', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('pemesanan_id')->unsigned();
            $table->bigInteger('kategori_id')->unsigned();
            $table->bigInteger('data_kategori_id')->unsigned()->nullable();
            $table->integer('qty')->nullable();
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
        Schema::dropIfExists('data_pemesanans');
    }
}

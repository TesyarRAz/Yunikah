<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProduksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('produks', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->bigInteger('harga')->unsigned();
            $table->text('keterangan');
            $table->enum('type', ['combo', 'tersedia', 'custom'])->default('combo');

            $table->foreignId('mitra_id')->constrained();
            $table->foreignId('kategori_id')->constrained();
            $table->foreignId('image_id')->constrained('assets');

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
        Schema::dropIfExists('produks');
    }
}

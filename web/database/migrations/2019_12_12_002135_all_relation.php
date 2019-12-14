<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AllRelation extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function(Blueprint $table) {
            $table->foreign('status_user_id')->references('id')->on('status_users');
        });

        Schema::table('mitras', function(Blueprint $table) {
            $table->foreign('image_id')->references('id')->on('assets');
        });

        Schema::table('kategoris', function(Blueprint $table) {
            $table->foreign('image_id')->references('id')->on('assets');
            $table->foreign('mitra_id')->references('id')->on('mitras');
            $table->foreign('status_kategori_id')->references('id')->on('status_kategoris');
        });

        Schema::table('pakets', function(Blueprint $table) {
            $table->foreign('image_id')->references('id')->on('assets');
        });

        Schema::table('pemesanans', function(Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('status_pemesanan_id')->references('id')->on('status_pemesanans');
        });

        Schema::table('data_pakets', function(Blueprint $table) {
            $table->foreign('paket_id')->references('id')->on('pakets');
            $table->foreign('kategori_id')->references('id')->on('kategoris');
        });

        Schema::table('data_pemesanans', function(Blueprint $table) {
            $table->foreign('pemesanan_id')->references('id')->on('pemesanans');
            $table->foreign('kategori_id')->references('id')->on('kategoris');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        
    }
}

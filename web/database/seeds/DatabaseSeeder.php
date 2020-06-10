<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(UserSeeder::class);
        $this->call(KategoriSeeder::class);
        $this->call(MitraSeeder::class);
        $this->call(ProdukSeeder::class);
        $this->call(PaketSeeder::class);
        $this->call(IklanSeeder::class);
        $this->call(StatusPemesananSeeder::class);
    }
}

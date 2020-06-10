<?php

use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\Hash;

use App\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
        	'name' => 'Admin Tamvan',
            'username' => 'admin',
        	'email' => 'admin@localhost',
        	'email_verified_at' => now(),
        	'password' => Hash::make('admin'),
            'phone' => '+6233448494839',
        	'level' => 'admin'
        ]);

        User::create([
            'name' => 'User Tamvan',
            'username' => 'user',
            'email' => 'user@localhost',
            'email_verified_at' => now(),
            'password' => Hash::make('user'),
            'phone' => '+6281332332245',
            'level' => 'user'
        ]);
    }
}

<?php

use Illuminate\Database\Seeder;
use App\Model\StatusUser;
use App\User;

use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $status_admin = StatusUser::create([
    		'keterangan' => 'admin'
    	]);
        $status_user = StatusUser::create([
            'keterangan' => 'user'
        ]);

        User::create([
        	'name' => 'Kosim',
        	'telp' => '08697332332',
        	'username' => 'admin',
        	'password' => Hash::make('admin'),
            'alamat' => 'Kota Sukabumi',
            'gender' => 'L',
            'dob' => '2000-01-01',
        	'status_user_id' => $status_admin->id
        ]);

        User::create([
            'name' => 'Budi Irawan',
            'telp' => '086687756552',
            'username' => 'user',
            'password' => Hash::make('admin'),
            'alamat' => 'Kota Sukabumi',
            'gender' => 'L',
            'dob' => '1999-01-01',
            'status_user_id' => $status_user->id
        ]);
    }
}

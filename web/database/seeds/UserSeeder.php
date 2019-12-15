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
        $status_user = StatusUser::create([
    		'keterangan' => 'admin'
    	]);
        $status_user = StatusUser::create([
            'keterangan' => 'user'
        ]);

        $user = User::create([
        	'name' => 'DAADasdsd',
        	'telp' => '123123123123',
        	'username' => 'admin',
        	'password' => Hash::make('admin'),
        	'alamat' => 'dsadsaadssdasdasad',
        	'status_user_id' => $status_user->id
        ]);
    }
}

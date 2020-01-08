<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('auth')->group(function() {
	Route::post('/login', 'UserController@login');
	Route::post('/register', 'UserController@register');
	
	Route::middleware('auth:api')->group(function() {
		Route::put('/user/update', 'UserController@updateData');
		Route::post('/auth/logout', 'UserController@logout');
	});

});

Route::namespace('\App\Http\Controllers')->name('api')->group(function() {

	Route::prefix('/kategori/{jenis}')->group(function() {
		Route::get('/', 'KategoriController@index')->middleware('filter.request:Kategori');
		Route::get('/{id}', 'KategoriController@show');

		Route::middleware('auth:api')->get('/{id}/pesan', 'Api\PemesananController@pesan_satuan');
	});

	Route::prefix('/mitra')->group(function() {
		Route::get('/', 'MitraController@index')->middleware('filter.request:Mitra');
		Route::get('/{id}', 'MitraController@show');
	});

	Route::prefix('/paket')->group(function() {
		Route::get('/', 'PaketController@index')->middleware('filter.request:Paket');
		Route::get('/{paket}', 'PaketController@show');
		Route::get('/{paket}/data', 'DataPaketController@index')->middleware('filter.request:DataPaket');
		Route::get('/{paket}/data/{id}', 'DataPaketController@show');

		Route::middleware('auth:api')->get('/{paket}/pesan', 'Api\PemesananController@pesan_paket');
	});

	Route::middleware('auth:api')->prefix('/pemesanan')->group(function() {
		Route::get('/', 'Api\PemesananController@index')->middleware('filter.request:Pemesanan');
		Route::get('/{id_pemesanan}', 'Api\PemesananController@show');
		Route::delete('/hapus/{id_pemesanan}', 'Api\PemesananController@hapus_pemesanan');
		Route::delete('/hapus/satuan/{id_data_pemesanan}', 'Api\PemesananController@hapus_satuan');

		Route::post('/checkout', 'Api\PemesananController@checkout');
	});

	Route::prefix('/iklan')->group(function() {
		Route::get('/', 'IklanController@index')->middleware('filter.request:Iklan');
		Route::get('/{id}', 'IklanController@show');
	});

	Route::get('/status/kategori', function() {
		$status = \App\Model\StatusKategori::all();

		return response($status, 200);
	});
});
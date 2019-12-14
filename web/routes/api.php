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
});

Route::namespace('\App\Http\Controllers')->name('api')->group(function() {
	Route::prefix('/kategori/{jenis}')->group(function() {
		Route::get('/', 'KategoriController@index')->middleware('filter.request:Kategori');
		Route::get('/{id}', 'KategoriController@show');

		Route::prefix('')
	});

	Route::prefix('/mitra')->group(function() {
		Route::get('/', 'MitraController@index')->middleware('filter.request:Mitra');
		Route::get('//{id}', 'MitraController@show');
	});

	Route::prefix('/paket')->group(function() {
		Route::get('/', 'PaketController@index')->middleware('filter.request:Paket');
		Route::get('/{paket}', 'PaketController@show');
		Route::get('/{paket}/data', 'DataPaketController@index')->middleware('filter.request:DataPaket');
		Route::get('/{paket}/data/{id}', 'DataPaketController@show');
	});

	Route::prefix('/pemesanan')->group(function() {
		Route::get('/', 'PemesananController@index')->middleware('filter.request:Pemesanan');
	});
});

Route::middleware('auth:api')->group(function() {
	Route::get('/auth/logout', 'UserController@logout');
});

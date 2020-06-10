<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

Route::namespace('Api')->group(function() {
	Route::prefix('/auth')->group(function() {
		Route::post('/login', 'UserController@post');
		Route::get('/user', 'UserController@index');
	});

	Route::prefix('/produk/{kategori:name}/')->group(function() {
		Route::get('/', 'ProdukController@index');
		Route::get('/{produk:id}', 'ProdukController@show');
	});

	Route::prefix('/iklan')->group(function() {
		Route::get('/', 'IklanController@index');
		Route::get('/{id}', 'IklanController@show');
	});

	Route::prefix('/paket')->group(function() {
		Route::get('/', 'PaketController@index');
		Route::get('/{id}', 'PaketController@show');
	});

	Route::prefix('/mitra')->group(function() {
		Route::get('/', 'MitraController@index');
		Route::get('/{id}', 'MitraController@show');
	});

	Route::prefix('/pemesanan')->middleware('auth')->group(function() {
		Route::post('/produk/{produk}', 'PemesananController@produk');
		Route::post('/paket/{paket}', 'PemesananController@paket');

		Route::post('/produk/checkout/{produk}', 'PemesananController@checkout_produk');
		Route::post('/paket/checkout/{paket}', 'PemesananController@checkout_paket');
	});
});
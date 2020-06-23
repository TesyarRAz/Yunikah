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
		Route::post('/register', 'UserController@register');
		
		Route::middleware('auth:api')->group(function() {
			Route::get('/user', 'UserController@index');
			Route::post('/update', 'UserController@update');
			Route::post('/logout', 'UserController@logout');
			Route::post('/changepassword', 'UserController@change_password');
		});
	});

	Route::get('/produk/search', 'ProdukController@search');
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
		Route::get('/search', 'PaketController@search');

		Route::get('/{id}', 'PaketController@show');
	});

	Route::prefix('/mitra')->group(function() {
		Route::get('/', 'MitraController@index');
		Route::get('/search', 'MitraController@search');
		
		Route::get('/{id}', 'MitraController@show');
		Route::get('/{id}/produk', 'MitraController@produk');
	});

	Route::prefix('/pemesanan')->middleware('auth:api')->group(function() {
		Route::post('/produk/{produk}', 'PemesananController@produk');
		Route::post('/paket/{paket}', 'PemesananController@paket');

		Route::get('/produk', 'PemesananController@show_pemesanan_produk');
		Route::get('/paket', 'PemesananController@show_pemesanan_paket');

		Route::post('/produk/checkout/{pemesanan}', 'PemesananController@checkout_produk');
		Route::post('/paket/checkout/{pemesanan}', 'PemesananController@checkout_paket');

		Route::delete('/produk/{pemesanan}', 'PemesananController@hapus_produk');
		Route::delete('/paket/{pemesanan}', 'PemesananController@hapus_paket');
	});
});
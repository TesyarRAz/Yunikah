<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Auth::routes(['register' => false, 'passwordRequest' => false]);

Route::get('/', function() {
	return redirect()->route('login');
});

Route::middleware(['auth:web', 'user.access:admin'])->group(function() {
	Route::prefix('/kategori/{jenis}')->name('kategori')->group(function() {
		Route::get('/create', 'KategoriController@create')->name('.create');
		Route::get('/', 'KategoriController@index')->middleware('filter.request:Kategori')->name('.index');
		Route::get('/{id}', 'KategoriController@edit')->name('.edit');
		Route::post('/', 'KategoriController@store')->name('.store');
		Route::put('/{id}', 'KategoriController@update')->name('.update');
		Route::delete('/{id}', 'KategoriController@destroy')->name('.destroy');
	});

	Route::middleware('filter.request:Paket')->resource('paket', 'PaketController');
	Route::prefix('paket/{paket}')
	->middleware('filter.request:DataPaket')->resource('paket.data', 'DataPaketController');

	Route::middleware('filter.request:Mitra')->resource('mitra', 'MitraController');
});

Route::get('/home', 'HomeController@index')->name('home');
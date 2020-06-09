<?php

use Illuminate\Support\Facades\Route;

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

Route::name('login')->get('/login', 'UserController@show');
Route::name('login.post')->post('/login', 'UserController@post');

Route::middleware('auth')->group(function() {
	Route::name('home')->get('/', 'HomeController@index');
	Route::name('logout')->post('/logout', 'UserController@logout');
	Route::name('user.changepassword')->get('/changepassword', 'UserController@change_password_view');
	Route::name('user.changepassword.post')->post('/changepassword/post', 'UserController@change_password_post');
	Route::name('apitest')->get('/apitest', function() {
		return view('apitest');
	});

	Route::name('dashboard')->get('/dashbord', 'DashboardController@index');

	Route::prefix('/pemesanan')->group(function() {
		Route::name('pemesanan.index.paket')->get('/paket/{status?}', 'PemesananController@index_paket');
		Route::name('pemesanan.index.produk')->get('/produk/{status?}', 'PemesananController@index_produk');
		
		Route::name('pemesanan.post.paket')->get('/post/paket/{status:name}/{pemesanan}', 'PemesananController@post_paket');
		Route::name('pemesanan.post.produk')->get('/post/produk/{status:name}/{pemesanan}', 'PemesananController@post_produk');

		Route::name('pemesanan.destroy.produk')->get('/destroy/produk/{pemesanan}', 'PemesananController@destroy_produk');
		Route::name('pemesanan.destroy.paket')->get('/destroy/paket/{pemesanan}', 'PemesananController@destroy_paket');
	});

	Route::prefix('/iklan')->group(function() {
		Route::name('iklan.index')->get('/', 'IklanController@index');
		Route::name('iklan.create')->get('/create', 'IklanController@create');
		Route::name('iklan.store')->post('/store', 'IklanController@store');

		Route::name('iklan.edit')->get('/{iklan}/edit', 'IklanController@edit');
		Route::name('iklan.update')->put('/{iklan}/update', 'IklanController@update');
		Route::name('iklan.destroy')->delete('/{iklan}/destroy', 'IklanController@destroy');
	});

	Route::prefix('/paket')->group(function() {
		Route::name('paket.index')->get('/', 'PaketController@index');
		Route::name('paket.create')->get('/create', 'PaketController@create');
		Route::name('paket.store')->post('/store', 'PaketController@store');

		Route::name('paket.edit')->get('/{paket}/edit', 'PaketController@edit');
		Route::name('paket.update')->put('/{paket}/update', 'PaketController@update');
		Route::name('paket.destroy')->delete('/{paket}/destroy', 'PaketController@destroy');

		Route::prefix('/{paket}/detail')->group(function() {
			Route::name('paket.detail.index')->get('/', 'DetailPaketController@index');

			Route::name('paket.detail.destroy')->delete('/{detail}/destroy', 'DetailPaketController@destroy');
		});
		Route::name('paket.detail.store')->post('/detail/store', 'DetailPaketController@store');
	});

	Route::prefix('/mitra')->group(function() {
		Route::name('mitra.index')->get('/', 'MitraController@index');
		Route::name('mitra.create')->get('/create', 'MitraController@create');
		Route::name('mitra.store')->post('/store', 'MitraController@store');

		Route::name('mitra.edit')->get('/{mitra}/edit', 'MitraController@edit');
		Route::name('mitra.update')->put('/{mitra}/update', 'MitraController@update');
		Route::name('mitra.destroy')->delete('/{mitra}/destroy', 'MitraController@destroy');

		Route::prefix('/{mitra}/produk')->group(function() {
			Route::name('produk.index')->get('/', 'ProdukController@index');
			Route::name('produk.create')->get('/create', 'ProdukController@create');
			Route::name('produk.store')->post('/store', 'ProdukController@store');

			Route::name('produk.edit')->get('/{produk}/edit', 'ProdukController@edit');
			Route::name('produk.update')->put('/{produk}/update', 'ProdukController@update');
			Route::name('produk.destroy')->delete('/{produk}/destroy', 'ProdukController@destroy');

			Route::prefix('/{produk}/pilihan')->group(function() {
				Route::name('produk.pilihan.index')->get('/', 'PilihanProdukController@index');
				Route::name('produk.pilihan.create')->get('/create', 'PilihanProdukController@create');
				Route::name('produk.pilihan.store')->post('/store', 'PilihanProdukController@store');

				Route::name('produk.pilihan.edit')->get('/{pilihan}/edit', 'PilihanProdukController@edit');
				Route::name('produk.pilihan.update')->put('/{pilihan}/update', 'PilihanProdukController@update');
				Route::name('produk.pilihan.destroy')->delete('/{pilihan}/destroy', 'PilihanProdukController@destroy');
			});
		});
	});
});
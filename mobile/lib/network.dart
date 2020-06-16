import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/pemesanan.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/model/user.dart';

class Network {
  static final instance = Network._();

  static const RANDOM_IMAGE_LINK = "https://source.unsplash.com/random";
  static const API_URL = "http://192.168.43.126/api/";

  Network._();

  final _client = Client();

  Future<ApiData<PemesananProduk>> getPemesananProduk(String token) async {
    return ApiData.parseFromJson(
      await _client.get(
        API_URL + "pemesanan/produk",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) => jsonDecode(response.body)),
      parsePemesananProduk
    );
  }

  Future<bool> pesanProdukTersedia(String token, Produk produk, DetailProduk detail) async {
    return await _client.post(
      API_URL + "pemesanan/produk/${produk.id}",
      headers: {
        HttpHeaders.authorizationHeader : 'Bearer $token'
      },
      body: {
        "pilihan_produk_id" : detail.id
      }
    )
    .then((response) => response.statusCode == 200);
  }

  Future<bool> pesanProdukCustom(String token, Produk produk, int jumlah) async {
    return await _client.post(
      API_URL + "pemesanan/produk/${produk.id}",
      headers: {
        HttpHeaders.authorizationHeader : 'Bearer $token'
      },
      body: {
        "kuantitas" : jumlah
      }
    )
    .then((response) => response.statusCode == 200);
  }

  Future<bool> pesanPaket(Paket paket) async {
    return await Future.delayed(Duration(seconds: 5), () {

      return true;
    });
  }

  Future<ApiData<Produk>> mitraProduk(Mitra mitra, int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "mitra/${mitra.id}/produk")
      .then((response) => jsonDecode(response.body)),
      parseProdukFromJson
    );
  }

  Future<ApiData<Produk>> neighbordProduk(Produk produk, int page) async {
    var data =  ApiData.parseFromJson(
      await _client.get(API_URL + "mitra/${produk.mitra.id}/produk")
      .then((response) => jsonDecode(response.body)),
      parseProdukFromJson
    );

    data.data.removeWhere((neighboard) => produk.id == neighboard.id);

    return data;
  }

  Future<ApiData<Paket>> allPaket(int page) async {
    return await _client.get(API_URL + "paket/?page=$page")
    .then((response) => jsonDecode(response.body))
    .then((json) => ApiData.parseFromJson(json, parsePaketFromJson));
  }
  
  Future<ApiData<Mitra>> allMitra(int page) async {
    return await _client.get(API_URL + "mitra/?page=$page")
    .then((response) => jsonDecode(response.body))
    .then((json) => ApiData.parseFromJson(json, parseMitraFromJson));
  }

  Future<ApiData<Iklan>> allIklan(int page) async {
    return await _client.get(API_URL + "iklan/?page=$page")
    .then((response) => jsonDecode(response.body))
    .then((json) => ApiData.parseFromJson(json, parseIklanFromJson));
  }

  Future<ApiData<Produk>> allProduk(String kategori, int page) async {
    return await _client.get(API_URL + "produk/$kategori/?page=$page")
    .then((response) => jsonDecode(response.body))
    .then((json) => ApiData.parseFromJson(json, parseProdukFromJson));
  }

  Future<User> login(String username, String password) async {
    var result = await _client.post(
      API_URL + "auth/login", 
      body: {
        'username' : username,
        'password' : password
      }
    );

    return result.statusCode == 200 ? User.parseFromJson(jsonDecode(result.body)) : null;
  }

  Future<bool> logout(String token) async {
    return await _client.get(
      API_URL + "auth/logout",
      headers: {
        HttpHeaders.authorizationHeader : "Bearer $token"
      }
    )
    .then((response) {
      return response.statusCode == 200;
    });
  }

  Future<User> userData(String token) async {
    return await _client.get(
      API_URL + "auth/user",
      headers: {
        HttpHeaders.authorizationHeader : "Bearer $token"
      }
    )
    .then((response) {
      return response.statusCode == 200 ? User.parseFromJson(jsonDecode(response.body)) : null;
    });
  }
}
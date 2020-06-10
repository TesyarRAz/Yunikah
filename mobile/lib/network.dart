import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/model/user.dart';

class Network {
  static final instance = Network._();

  static const RANDOM_IMAGE_LINK = "https://source.unsplash.com/random";
  static const API_URL = "http://192.168.43.126/api/";

  Network._();

  final _client = Client();

  Future<bool> pesanProduk(Produk produk) async {
    return Future.delayed(Duration(seconds: 5), () {

      return true;
    });
  }

  Future<ApiData<Produk>> mitraProduk(Mitra mitra, int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "mitra/${mitra.id}")
      .then((response) => jsonDecode(response.body))
      .then((data) => data['produks']),
      parseProdukFromJson
    );
  }

  Future<ApiData<Produk>> neighbordProduk(Produk produk, int page) async {
    return Future.delayed(Duration(seconds: 5), () {

      return null;
    });
    // return parseProdukFromJson(
    //   await _client.get(API_URL + "mitra/${produk.mitra.id}/?page=$page")
    //   .then((response) => jsonDecode(response.body))
    //   .then((data) => data['produks'])
    // )
    // .where((neighboard) => produk.id != neighboard.id).toList();
  }

  Future<ApiData<Paket>> allPaket(int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "paket/?page=$page").then((response) => jsonDecode(response.body)),
      parsePaketFromJson
    );
  }
  
  Future<ApiData<Mitra>> allMitra(int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "mitra/?page=$page").then((response) => jsonDecode(response.body)),
      parseMitraFromJson
    );
  }

  Future<ApiData<Iklan>> allIklan(int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "iklan/?page=$page").then((response) => jsonDecode(response.body)),
      parseIklanFromJson
    );
  }

  Future<ApiData<Produk>> allProduk(String kategori, int page) async {
    return ApiData.parseFromJson(
      await _client.get(API_URL + "produk/$kategori/?page=$page").then((response) => jsonDecode(response.body)),
      parseProdukFromJson
    );
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
}
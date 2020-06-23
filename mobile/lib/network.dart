import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:intl/intl.dart';
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

  Future<bool> checkoutProduk(String token, PemesananProduk pemesanan) async {
    try {
      return await _client.post(
        API_URL + "pemesanan/produk/checkout/${pemesanan.id}",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        },
        body: {
          'alamat': pemesanan.alamat,
          'tanggal_pernikahan' : DateFormat("y-M-d").format(pemesanan.tanggal)
        }
      )
      .then((response) => response.statusCode == 200);
    } catch (ex) {
      return null;
    }
  }

  Future<bool> checkoutPaket(String token, PemesananPaket pemesanan) async {
    try {
      return await _client.post(
        API_URL + "pemesanan/paket/checkout/${pemesanan.id}",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        },
        body: {
          'alamat': pemesanan.alamat,
          'tanggal_pernikahan' : DateFormat("y-M-d").format(pemesanan.tanggal)
        }
      )
      .then((response) => response.statusCode == 200);
    } catch (ex) {
      return null;
    }
  }

  Future<bool> hapusPemesananProduk(String token, PemesananProduk pemesanan) async {
    try {
      return await _client.delete(
        API_URL + "pemesanan/produk/${pemesanan.id}",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) => response.statusCode == 200);
    } catch (ex) {
      return null;
    }
  }

  Future<bool> hapusPemesananPaket(String token, PemesananPaket pemesanan) async {
    try {
      return await _client.delete(
        API_URL + "pemesanan/paket/${pemesanan.id}",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) => response.statusCode == 200);
    } catch (ex) {
      return null;
    }
  }

  Future<List<PemesananProduk>> getPemesananProduk(String token) async {
    try {
      return await _client.get(
        API_URL + "pemesanan/produk",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) => jsonDecode(response.body))
      .then((json) => parsePemesananProdukFromJson(json));
    } catch (ex) {
      return [];
    }
  }

  Future<List<PemesananPaket>> getPemesananPaket(String token) async {
    try {
      return await _client.get(
        API_URL + "pemesanan/paket",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) => jsonDecode(response.body))
      .then((json) => parsePemesananPaketFromJson(json));
    } catch (ex) {
      return [];
    }
  }

  Future<bool> pesanProdukTersedia(String token, Produk produk, DetailProduk detail) async {
    try {
      return await _client.post(
        API_URL + "pemesanan/produk/${produk.id}",
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer $token'
        },
        body: {
          "pilihan_produk_id" : detail.id.toString()
        }
      )
      .then((response) {
        print(response.body);

        return response.statusCode == 200;
      });
    } catch (ex) {
      return null;
    }
  }

  Future<bool> pesanProdukCustom(String token, Produk produk, int jumlah) async {
    try {
      return await _client.post(
        API_URL + "pemesanan/produk/${produk.id}",
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer $token'
        },
        body: {
          "kuantitas" : jumlah.toString()
        }
      )
      .then((response) {
        print(response.body);
        return response.statusCode == 200;
      });
    } catch (ex) {
      return false;
    }
  }

  Future<bool> pesanPaket(String token, Paket paket) async {
    try {
      return await _client.post(
        API_URL + "pemesanan/paket/${paket.id}",
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer $token'
        }
      )
      .then((response) => response.statusCode == 200);
    } catch (ex) {
      return null;
    }
  }

  Future<ApiData<Produk>> mitraProduk(Mitra mitra, int page) async {
    try {
      return ApiData.parseFromJson(
        await _client.get(API_URL + "mitra/${mitra.id}/produk")
        .then((response) => jsonDecode(response.body)),
        parseProdukFromJson
      );
    } catch (ex) {
      return null;
    }
  }

  Future<ApiData<Produk>> neighbordProduk(Produk produk, int page) async {
    try {
      var data =  ApiData.parseFromJson(
        await _client.get(API_URL + "mitra/${produk.mitra.id}/produk")
        .then((response) => jsonDecode(response.body)),
        parseProdukFromJson
      );

      data.data.removeWhere((neighboard) => produk.id == neighboard.id);

      return data;
    } catch (ex) {
      return null;
    }
  }

  Future<ApiData<Paket>> allPaket(int page) async {
    try {
      return await _client.get(API_URL + "paket/?page=$page")
      .then((response) => jsonDecode(response.body))
      .then((json) => ApiData.parseFromJson(json, parsePaketFromJson));
    } catch (ex) {
      return null;
    }
  }
  
  Future<ApiData<Mitra>> allMitra(int page) async {
    try {
      return await _client.get(API_URL + "mitra/?page=$page")
      .then((response) => jsonDecode(response.body))
      .then((json) => ApiData.parseFromJson(json, parseMitraFromJson));
    } catch (ex) {
      return null;
    }
  }

  Future<ApiData<Iklan>> allIklan(int page) async {
    try {
      return await _client.get(API_URL + "iklan/?page=$page")
      .then((response) => jsonDecode(response.body))
      .then((json) => ApiData.parseFromJson(json, parseIklanFromJson));
    } catch (ex) {
      return null;
    }
  }

  Future<ApiData<Produk>> allProduk(String kategori, int page) async {
    try {
      return await _client.get(API_URL + "produk/$kategori/?page=$page")
      .then((response) => jsonDecode(response.body))
      .then((json) => ApiData.parseFromJson(json, parseProdukFromJson));
    } catch (ex) {
      return null;
    }
  }

  Future<Map<String, dynamic>> register(User user) async {
    try {
      var result = await _client.post(
        API_URL + "auth/register", 
        body: {
          'username' : user.username,
          'password' : user.password,
          'email' : user.email,
          'phone': user.phone,
          'name' : user.name
        }
      );

      return {
        'message' : jsonDecode(result.body)['message'],
        'status' : result.statusCode
      };
    } catch (ex) {
      return null;
    }
  }

  Future<User> login(String username, String password) async {
    try {
      var result = await _client.post(
        API_URL + "auth/login", 
        body: {
          'username' : username,
          'password' : password
        }
      );

      return result.statusCode == 200 ? User.parseFromJson(jsonDecode(result.body)) : null;
    } catch (ex) {
      return null;
    }
  }

  Future<bool> logout(String token) async {
    try {
      return await _client.get(
        API_URL + "auth/logout",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) {
        return response.statusCode == 200;
      });
    } catch (ex) {
      return false;
    }
  }

  Future<User> userData(String token) async {
    try {
      return await _client.get(
        API_URL + "auth/user",
        headers: {
          HttpHeaders.authorizationHeader : "Bearer $token"
        }
      )
      .then((response) {
        return response.statusCode == 200 ? User.parseFromJson(jsonDecode(response.body)) : null;
      });
    } catch (ex) {
      return null;
    }
  }

  Future<List<ApiData<dynamic>>> search(String text) async {
    try {
      return await Future.wait([
        _client.get(
          API_URL + "mitra/search?q=$text",
        )
        .then((response) => ApiData.parseFromJson(
          jsonDecode(response.body),
          parseMitraFromJson)
        ),
        _client.get(
          API_URL + "paket/search?q=$text"
        )
        .then((response) => ApiData.parseFromJson(
          jsonDecode(response.body),
          parsePaketFromJson)
        ),
        _client.get(
          API_URL + "produk/search?q=$text"
        )
        .then((response) => ApiData.parseFromJson(
          jsonDecode(response.body),
          parseProdukFromJson)
        )
      ]);
    } catch (ex) {
      return null;
    }
  }
}
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/pemesanan.dart';
import 'package:yunikah/model/user.dart';

class ApiResult<T> {
  final T data;

  ApiResult(this.data);
}

class ApiSuccess<T> extends ApiResult<T> {
  ApiSuccess(T data) : super(data);
}

class ApiError<T> extends ApiResult<T> {
  final String message;
  final int statusCode;

  ApiError(this.message, [this.statusCode]) : super(null);
}

abstract class ApiInterface {
  Future<ApiResult<User>> login(String username, String password);
  Future<ApiResult<User>> register(User user);

  // Need Auth
  Future<ApiResult<bool>> logout(User authUser);
  Future<ApiResult<bool>> pesanSatuan(User authUser, Kategori kategori);
  Future<ApiResult<bool>> hapusSatuan(User authUser, int idDataPemesanan);
  Future<ApiResult<bool>> checkout(User authUser, Pemesanan pemesanan);
  Future<ApiResult<List<Pemesanan>>> allPesanan(User authUser);

  Future<ApiResult<List<Kategori>>> allKategori(String kategoriName);
  Future<ApiResult<List<Paket>>> allPaket();
  Future<ApiResult<List<Iklan>>> allIklan();
  Future<ApiResult<List<Mitra>>> allMitra();
}

class ApiService extends ApiInterface {
  static const BASE_HOST = 'http://192.168.43.14/';
  // static const BASE_HOST = "http://192.168.10.105/";
  static const HOST_API = BASE_HOST + 'api/';

  static ApiService _instance = ApiService._();
  static ApiService get instance => _instance;

  final Client _client = Client();

  ApiService._();

  @override
  Future<ApiResult<List<Iklan>>> allIklan() async {
    try {
      var _response = await _client.get(HOST_API + 'iklan');
      if (_response.statusCode == 200) {
        return ApiSuccess(iklanFromJson(jsonDecode(_response.body)));
      }

      return ApiError<List<Iklan>>('Tidak ada iklan', _response.statusCode);
    } on SocketException {
      return ApiError<List<Iklan>>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<List<Kategori>>> allKategori(String kategoriName) async {
    try {
      var _response = await _client.get(HOST_API + 'kategori/$kategoriName');

      if (_response.statusCode == 200) {
        return ApiSuccess(kategoriFromJson(jsonDecode(_response.body)));
      }

      return ApiError<List<Kategori>>('Tidak ada kategori', _response.statusCode);
    } on SocketException {
      return ApiError<List<Kategori>>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<List<Paket>>> allPaket() async {
    try {
      var _response = await _client.get(HOST_API + 'paket');
      if (_response.statusCode == 200) {
        return ApiSuccess(paketFromJson(jsonDecode(_response.body)));
      }

      return ApiError<List<Paket>>('Tidak ada paket', _response.statusCode);
    } on SocketException {
      return ApiError<List<Paket>>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<List<Mitra>>> allMitra() async {
    try {
      var _response = await _client.get(HOST_API + 'mitra');
      if (_response.statusCode == 200) {
        return ApiSuccess(mitraFromJson(jsonDecode(_response.body)));
      }

      return ApiError<List<Mitra>>('Tidak ada mitra', _response.statusCode);
    } on SocketException {
      return ApiError<List<Mitra>>('Connection Error', -1);
    }
  }
    
  @override
  Future<ApiResult<User>> login(String username, String password) async {
    try {
      var _response = await _client.post(HOST_API + 'auth/login', body: {
        'username' : username,
        'password' : password
      });
      if (_response.statusCode == 200) {
        var map = jsonDecode(_response.body);
        var user = User.parseFromJson(map);

        return ApiResult(user);
      } else if (_response.statusCode == 401) {
        return ApiError<User>('Username atau password salah!', _response.statusCode);
      }

      return ApiError<User>('Error', 500);
    } on SocketException {
      return ApiError<User>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<bool>> logout(User authUser) async {
    try {
      var _response = await _client.post(HOST_API + 'auth/logout', headers: {
        'Authorization' : 'Bearer ${authUser.token}'
      });
      if (_response.statusCode == 200) {
        return ApiResult(true);
      } else if (_response.statusCode == 401) {
        return ApiError<bool>('Gagal Logout', _response.statusCode);
      }

      return ApiError<bool>('Error', 500);
    } on SocketException {
      return ApiError<bool>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<bool>> pesanSatuan(User authUser, Kategori kategori) async {
    try {
      var _response = await _client.get(HOST_API + 'kategori/${kategori.statusKategori.keterangan}/${kategori.id}/pesan', 
        headers: {
          'Authorization' : 'Bearer ${authUser.token}'
        }
      );
      
      if (_response.statusCode == 200) {
        return ApiResult(true);
      } else if (_response.statusCode == 401) {
        return ApiError<bool>('Gagal Pesan', _response.statusCode);
      }

      return ApiError<bool>('Error', 500);
    } on SocketException {
      return ApiError<bool>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<bool>> hapusSatuan(User authUser, int idDataPemesanan) async {
    try {
      var _response = await _client.delete(HOST_API + 'pemesanan/hapus/satuan/$idDataPemesanan', 
        headers: {
          'Authorization' : 'Bearer ${authUser.token}'
        }
      );
      
      if (_response.statusCode == 200) {
        return ApiResult(true);
      } else if (_response.statusCode == 401) {
        return ApiError<bool>('Gagal Pesan', _response.statusCode);
      }

      return ApiError<bool>('Error', 500);
    } on SocketException {
      return ApiError<bool>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<List<Pemesanan>>> allPesanan(User authUser) async {
    try {
      var _response = await _client.get(HOST_API + 'pemesanan', headers: {
        'Authorization' : 'Bearer ${authUser.token}'
      });

      if (_response.statusCode == 200) {
        return ApiSuccess(pemesananFromJson(jsonDecode(_response.body)));
      }

      return ApiError<List<Pemesanan>>('Tidak ada pesanan', _response.statusCode);
    } on SocketException {
      return ApiError<List<Pemesanan>>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<User>> register(User user) async {
    try {
      var _response = await _client.post(HOST_API + 'auth/register', body: {
        'name' : user.name,
        'telp' : user.telp,
        'alamat' : user.alamat,
        'username' : user.username,
        'password' : user.password
      });
      if (_response.statusCode == 200) {
        var map = jsonDecode(_response.body);
        var user = User.parseFromJson(map);

        return ApiResult(user);
      } else if (_response.statusCode == 401) {
        return ApiError<User>('Error', _response.statusCode);
      }

      return ApiError<User>('Error', 500);
    } on SocketException {
      return ApiError<User>('Connection Error', -1);
    }
  }

  @override
  Future<ApiResult<bool>> checkout(User authUser, Pemesanan pemesanan) async {
    try {
      var _response = await _client.post(HOST_API + 'pemesanan/checkout', body: {
        'alamat' : pemesanan.alamat,
        'tanggal_pernikahan' : pemesanan.tanggalPernikahan.toString()
      }, headers: {
        'Authorization' : 'Bearer ' + authUser.token
      });
      if (_response.statusCode == 200) {
        var map = jsonDecode(_response.body);

        return ApiResult(map);
      } else if (_response.statusCode == 401) {
        return ApiError<bool>('Error', _response.statusCode);
      }

      return ApiError<bool>('Error', 500);
    } on SocketException {
      return ApiError<bool>('Connection Error', -1);
    }
  }
}
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/user.dart';

abstract class ApiInterface {
  Future<User> login(String username, String password);
  Future<List<Kategori>> allKategori(String kategoriName);
  Future<List<Paket>> allPaket();
  Future<List<Iklan>> allIklan();
}

class ApiService extends ApiInterface {
  static const BASE_HOST = 'http://192.168.43.14/';
  static const HOST_API = BASE_HOST + 'api/';

  final Client _client = Client();

  final User authUser;

  ApiService({
    this.authUser
  });

  @override
  Future<List<Iklan>> allIklan() async =>
    await _client.get(HOST_API + 'iklan').then((_response) {
      
      if (_response.statusCode == 200) {
        return iklanFromJson(jsonDecode(_response.body));
      }

      return null;
    });

  @override
  Future<List<Kategori>> allKategori(String kategoriName) async =>
    await _client.get(HOST_API + 'kategori/$kategoriName')
    .then((_response) {
       if (_response.statusCode == 200) {
        return kategoriFromJson(jsonDecode(_response.body));
      }

      return null;
    });

  @override
  Future<List<Paket>> allPaket() async =>
    await _client.get(HOST_API + 'paket')
    .then((_response) {

      if (_response.statusCode == 200) {
        return paketFromJson(jsonDecode(_response.body));
      }

      return null;
    });
  @override
  Future<User> login(String username, String password) async =>
    await _client.post(HOST_API + 'auth/login', body: {
      'username' : username,
      'password' : password
    }).then((_response) {
      if (_response.statusCode == 200) {
        var map = jsonDecode(_response.body);
        var user = User.parseFromJson(map);

        return user;
      }

      return null;
    });

  
}
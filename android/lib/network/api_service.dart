import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/user.dart';

abstract class ApiInterface {
  Future<User> login(User user);
  Future<List<Rias>> allRias();
  Future<List<Asset>> allImage(int albumId);
  Future<List<Paket>> allPaket();
  Future<List<Iklan>> allIklan();
}

class ApiService extends ApiInterface {
  static const HOST_API = 'https://jsonplaceholder.typicode.com/';

  final Client _client = Client();

  @override
  Future<List<Asset>> allImage(int albumId) async =>
    _client.get(HOST_API + 'photos/$albumId').then((e) => assetsFromJson(jsonDecode(e.body)));

  @override
  Future<List<Rias>> allRias() async =>
    _client.get(HOST_API + 'albums/1').then((e) => riasesFromJson(jsonDecode(e.body)));

  @override
  Future<User> login(User user) async {
    return await Future.delayed(Duration(seconds: 2), () {
      return users.singleWhere((e) => user.isSameIdentity(e));
    });
  }

  @override
  Future<List<Paket>> allPaket() async {
    return await Future.delayed(Duration(seconds: 2), () {
      return List.generate(5, (index) => Paket(id: index, name: 'Paket ${index + 1}', userId: 1, harga: 10000000));
    });
  }

  @override
  Future<List<Iklan>> allIklan() async {
    return await Future.delayed(Duration(seconds: 2), () {
      return List.generate(2, (index) => Iklan(asset: 'iklan_${index + 1}.jpg'));
    });
  }
}
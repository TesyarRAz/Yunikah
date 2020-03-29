import 'dart:math';

import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/sample.dart';
import 'package:yunikah/model/user.dart';

class Network {
  static final instance = Network._();
  static const RANDOM_IMAGE_LINK = "https://source.unsplash.com/random";

  Network._();
  
  Future<List<Mitra>> allMitra() async {
    return Future.delayed(Duration(seconds: 5), () async {
      return kListMitra;
    });
  }

  Future<List<Iklan>> allIklan() async {
    return Future.delayed(Duration(seconds: 5), () async {
      return kListIklan;
    });
  }

  Future<List<Kategori>> allKategori(String kategori, [int limit, int prefix]) async {
    return List.generate(10, (index) {
      return Kategori(
        id: index,
        harga: 10000 * index,
        name: "$kategori #$index",
        type: KategoriType.TERSEDIA,
        status: StatusKategori(
          id: Random().nextInt(100),
          name: kategori
        ),
      );
    });
  }

  Future<User> login(String username, String password) async {
    return Future.delayed(Duration(seconds: 5), () {
      return User(
        username: username,
        password: password
      );
    });
  }
}
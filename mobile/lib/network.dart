import 'dart:math';

import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/pemesanan.dart';
import 'package:yunikah/model/sample.dart';
import 'package:yunikah/model/user.dart';

class Network {
  static final instance = Network._();
  static const RANDOM_IMAGE_LINK = "https://source.unsplash.com/random";

  Network._();

  Future<bool> pesanSatuan(Kategori kategori) async {
    return Future.delayed(Duration(seconds: 5), () {
      kListPemesanan[0].data.add(DataPemesanan(
        id: Random().nextInt(999),
        kategori: kategori
      ));

      return true;
    });
  }

  Future<List<Pemesanan>> allPemesanan() async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListPemesanan;
    });
  }

  Future<List<Kategori>> mitraKategori(Mitra mitra, [int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListKategori.where((kategori) => kategori.mitra.id == mitra.id).toList();
    });
  }

  Future<List<Kategori>> neighbordKategori(Kategori kategori, [int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListKategori.where((neighbord) => kategori.mitra.id == neighbord.mitra.id && kategori.id != neighbord.id).toList();
    });
  }

  Future<List<Paket>> allPaket([int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListPaket;
    });
  }
  
  Future<List<Mitra>> allMitra([int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListMitra;
    });
  }

  Future<List<Iklan>> allIklan([int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListIklan;
    });
  }

  Future<List<Kategori>> allKategori(String kategori, [int limit = 10, int offset = 0]) async {
    return Future.delayed(Duration(seconds: 5), () {
      return kListKategori;
    });
  }

  Future<User> login(String username, String password) async {
    return Future.delayed(Duration(seconds: 5), () {
      return User(
        name: username,
        username: username,
        password: password,
        token: "uidsjauisad9-1312"
      );
    });
  }
}
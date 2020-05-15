import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/kategori.dart';

class DataPaket {
  int id;
  String name;

  Kategori kategori;

  DataPaket({this.id, this.name, this.kategori});
}

class Paket {
  int id;
  String name;
  int harga;

  Asset image;
  List<DataPaket> data;

  Paket({this.id, this.name, this.harga, this.image, this.data});
}
import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/kategori.dart';

class Mitra {
  int id;
  String name;

  Asset image;
  List<Kategori> kategori;

  Mitra({this.id, this.name, this.image, this.kategori});
}
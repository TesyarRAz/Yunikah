import 'package:yunikah/model/asset.dart';

class StatusKategori {
  int id;
  String name;

  // Very Optional, only for system
  Asset image;

  StatusKategori({this.id, this.name, this.image});
  
  factory StatusKategori.parseFromJson(Map<String, dynamic> map) => StatusKategori(
    id: map['id'],
    name: map['name']
  );
}

enum KategoriType {
  CUSTOM,
  TERSEDIA,
  COMBO
}

class Kategori {
  int id;
  int harga;
  String name;

  Asset image;
  KategoriType type;
  StatusKategori status;

  Kategori({this.id, this.harga, this.name, this.image, this.type, this.status});

  factory Kategori.parseFromJson(Map<String, dynamic> map) => Kategori(
    id: map['id'],
    harga: map['harga'],
    name: map['name'],
    image: Asset.parseFromJson(map['image']),
    type: KategoriType.values.singleWhere((type) => type.toString() == map['kategori'])
  );
}

List<Kategori> kategoriFromJson(List<dynamic> list) => list.map((map) => Kategori.parseFromJson(map)).toList();

final List<StatusKategori> kStatusKategori = [
  StatusKategori(name: 'Rias'),
  StatusKategori(name: 'Hiburan'),
  StatusKategori(name: 'Tenda'),
  StatusKategori(name: 'Photo'),
  StatusKategori(name: 'Undangan'),
  StatusKategori(name: 'Katering')
];
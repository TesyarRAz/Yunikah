import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/mitra.dart';

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

class DataKategori {
  int id;
  String name;

  int harga;

  DataKategori({this.id, this.name, this.harga});

  factory DataKategori.parseFromJson(Map<String, dynamic> map) => DataKategori(
    id: map['id'],
    name: map['name'],
    harga: map['harga']
  );
}

class Kategori {
  int id;
  int harga;
  String name;
  String keterangan;

  Mitra mitra;
  Asset image;
  KategoriType type;
  StatusKategori status;
  List<DataKategori> data;

  Kategori({
    this.id, 
    this.harga, 
    this.name, 
    this.keterangan, 
    this.mitra,
    this.image, 
    this.type, 
    this.status, 
    this.data
  });

  factory Kategori.parseFromJson(Map<String, dynamic> map) => Kategori(
    id: map['id'],
    harga: map['harga'],
    name: map['name'],
    keterangan: map['keterangan'],
    image: Asset.parseFromJson(map['image']),
    type: KategoriType.values.singleWhere((type) => type.toString() == map['kategori']),
    data: List.from(map['data']).map((json) => DataKategori.parseFromJson(json)).toList()
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
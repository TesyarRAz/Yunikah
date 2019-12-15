import 'package:yunikah/model/asset.dart';

class StatusKategori {
  static const Rias = 'rias';
  static const Photo = 'photo';
  static const Gedung = 'gedung';
  static const AlatPesta = 'alat';
  static const Undangan = 'undangan';

  int id;
  String keterangan;

  StatusKategori({
    this.id,
    this.keterangan,
  });

  factory StatusKategori.parseFromJson(Map<String, dynamic> data) => StatusKategori(
    id: data['id'],
    keterangan: data['keterangan'],
  );
}

class Kategori {
  int id;
  String name;
  int harga;

  Asset image;

  StatusKategori statusKategori;

  Kategori({
    this.id,
    this.name,
    this.harga,
    this.image,
    this.statusKategori
  });

  factory Kategori.parseFromJson(Map<String, dynamic> data) => Kategori(
    id: data['id'],
    name: data['name'],
    harga: data['harga'],
    image: Asset.parseFromJson(data['image']),
    // statusKategori: StatusKategori.parseFromJson(data['status'])
  );
}

List<Kategori> kategoriFromJson(List<dynamic> data) => data.map((e) => Kategori.parseFromJson(e)).toList();
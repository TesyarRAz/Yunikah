import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/produk.dart';

class DataPaket {
  int id;

  Produk? produk;

  DataPaket({required this.id, this.produk});

  factory DataPaket.parseFromJson(Map<String, dynamic> map) => DataPaket(
    id: map['id'],
    produk: map['produk'] != null ? Produk.parseFromJson(map['produk']) : null,
  );
}

List<DataPaket> parseDataPaketFromJson(List<dynamic> data) => data.map((map) => DataPaket.parseFromJson(map)).toList();

class Paket {
  int id;
  String name;
  int harga;
  String? keterangan;

  Asset image;
  List<DataPaket>? data;

  Paket({required this.id, required this.name, required this.harga, required this.image,  this.data, required this.keterangan});

  factory Paket.parseFromJson(Map<String, dynamic> data) => Paket(
    id: data['id'],
    name: data['name'],
    harga: data['harga'],
    image: Asset.parseFromJson(data['image']),
    keterangan: data['keterangan'],
    data: data['details'] == null ? null : parseDataPaketFromJson(data['details'])
  );
}

List<Paket> parsePaketFromJson(List<dynamic> data) => data.map((map) => Paket.parseFromJson(map)).toList();
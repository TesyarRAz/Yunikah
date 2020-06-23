import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/produk.dart';

class DataPaket {
  int id;
  String name;

  Produk produk;

  DataPaket({this.id, this.name, this.produk});

  factory DataPaket.parseFromJson(Map<String, dynamic> map) => DataPaket(
    id: map['id'],
    name: map['name'],
    produk: Produk.parseFromJson(map['produk'])
  );
}

List<DataPaket> parseDataPaketFromJson(List<dynamic> data) => data.map((map) => DataPaket.parseFromJson(map)).toList();

class Paket {
  int id;
  String name;
  int harga;
  String keterangan;

  Asset image;
  List<DataPaket> data;

  Paket({this.id, this.name, this.harga, this.image, this.data, this.keterangan});

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
import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/produk.dart';

class DataPaket {
  int id;
  String name;

  Produk produk;

  DataPaket({this.id, this.name, this.produk});
}

class Paket {
  int id;
  String name;
  int harga;

  Asset image;
  List<DataPaket> data;

  Paket({this.id, this.name, this.harga, this.image, this.data});

  factory Paket.parseFromJson(Map<String, dynamic> data) => Paket(
    id: data['id'],
    name: data['name'],
    harga: data['harga'],
    image: Asset.parseFromJson(data['image'])
  );
}

List<Paket> parsePaketFromJson(List<dynamic> data) => data.map((map) => Paket.parseFromJson(map)).toList();
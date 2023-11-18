import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/produk.dart';

class Mitra {
  int id;
  String name;
  int transaksi;

  Asset image;
  List<Produk>? produk;

  Mitra({required this.id, required this.name, required this.transaksi, required this.image, this.produk});

  factory Mitra.parseFromJson(Map<String, dynamic> data) => Mitra(
    id: data['id'],
    name: data['name'],
    image: Asset.parseFromJson(data['image']),
    transaksi: data['total_transaksi']
  );
}

List<Mitra> parseMitraFromJson(List<dynamic> data) => data.map((map) => Mitra.parseFromJson(map)).toList();
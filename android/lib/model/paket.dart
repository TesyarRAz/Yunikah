import 'package:yunikah/model/asset.dart';

class DataPaket {
  int id;
  int idKategori;
  int idPaket;

  DataPaket({
    this.id,
    this.idKategori,
    this.idPaket
  });

  factory DataPaket.parseFromJson(Map<String, dynamic> data) => DataPaket(
    id: data['id'],
    idKategori: data['kategori_id'],
    idPaket: data['paket_id']
  );
}

List<DataPaket> dataPaketFromJson(List<dynamic> data) => data.map((e) => DataPaket.parseFromJson(e)).toList();

class Paket {
  int id;
  String name;
  int harga;

  Asset image;

  List<DataPaket> dataPaket;

  Paket({
    this.id,
    this.name,
    this.harga,
    this.image,
    this.dataPaket
  });

  factory Paket.parseFromJson(Map<String, dynamic> data) => Paket(
    id: data['id'],
    name: data['name'],
    harga: data['harga'],
    image: Asset.parseFromJson(data['image']),
    dataPaket: dataPaketFromJson(data['data'])
  );

  @override
  String toString() => "Paket: {id: $id}";
}

List<Paket> paketFromJson(List<dynamic> data) => data.map((e) => Paket.parseFromJson(e)).toList();
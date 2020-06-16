import 'package:yunikah/model/produk.dart';

class StatusPemesanan {
  int id;
  String name;
  String label;
  String keterangan;

  StatusPemesanan({this.id, this.name, this.label, this.keterangan});

  factory StatusPemesanan.parseFromJson(Map<String, dynamic> map) => StatusPemesanan(
    id: map['id'],
    name: map['name'],
    label: map['label'],
    keterangan: map['keterangan']
  );
}

class PemesananProduk {
  int id;
  String alamat;
  DateTime tanggal;
  int harga;
  int kuantitas;

  Produk produk;
  StatusPemesanan status;
  
  PemesananProduk({this.id, this.alamat, this.tanggal, this.harga, this.kuantitas, this.produk, this.status});
  factory PemesananProduk.parseFromJson(Map<String, dynamic> map) => PemesananProduk(
    id: map['id'],
    alamat: map['alamat'],
    tanggal: map['tanggal_pernikahan'],
    harga: map['harga'],
    status: StatusPemesanan.parseFromJson(map['status']),
    produk: Produk.parseFromJson(map['produk'])
  );
}

List<PemesananProduk> parsePemesananProduk(List<dynamic> list) => list.map((map) => PemesananProduk.parseFromJson(map)).toList();

class PemesananPaket {
  
}
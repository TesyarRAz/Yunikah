import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/produk.dart';

class StatusPemesanan {
  int id;
  String name;
  String label;
  String keterangan;

  StatusPemesanan({required this.id, required this.name, required this.label, required this.keterangan});

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
  DetailProduk? pilihan;
  
  PemesananProduk({required this.id, required this.alamat, required this.tanggal, required this.harga, required this.kuantitas, required this.produk, required this.status, this.pilihan});
  factory PemesananProduk.parseFromJson(Map<String, dynamic> map) => PemesananProduk(
    id: map['id'],
    alamat: map['alamat'],
    tanggal: DateTime.parse(map['tanggal_pernikahan']),
    harga: map['harga'],
    status: StatusPemesanan.parseFromJson(map['status']),
    produk: Produk.parseFromJson(map['produk']),
    kuantitas: map['kuantitas'],
    pilihan: map['pilihan'] == null ? null : DetailProduk.parseFromJson(map['pilihan'])
  );
}

List<PemesananProduk> parsePemesananProdukFromJson(List<dynamic> list) => list.map((map) => PemesananProduk.parseFromJson(map)).toList();

class PemesananPaket {
  int id;
  String alamat;
  DateTime tanggal;
  int harga;

  StatusPemesanan status;
  Paket paket;

  PemesananPaket({
    required this.id, required this.alamat, required this.tanggal, required this.harga, required this.status, required this.paket
  });

  factory PemesananPaket.parseFromJson(Map<String, dynamic> map) => PemesananPaket(
    id: map['id'],
    alamat: map['alamat'],
    tanggal: DateTime.parse(map['tanggal_pernikahan']),
    harga: map['harga'],
    status: StatusPemesanan.parseFromJson(map['status']),
    paket: Paket.parseFromJson(map['paket'])
  );
}

List<PemesananPaket> parsePemesananPaketFromJson(List<dynamic> list) => list.map((map) => PemesananPaket.parseFromJson(map)).toList();
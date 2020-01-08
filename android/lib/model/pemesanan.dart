import 'package:intl/intl.dart';
import 'package:yunikah/model/kategori.dart';

class StatusPemesanan {
  int id;
  String keterangan;

  StatusPemesanan({
    this.id,
    this.keterangan,
  });

  factory StatusPemesanan.parseFromJson(Map<String, dynamic> data) => StatusPemesanan(
    id: data['id'],
    keterangan: data['keterangan'],
  );
}

class DataPemesanan {
  int id;
  int idKategori;
  int idPemesanan;
  Kategori kategori;

  DataPemesanan({
    this.id,
    this.idKategori,
    this.idPemesanan,
    this.kategori
  });

  factory DataPemesanan.parseFromJson(Map<String, dynamic> data) => DataPemesanan(
    id: data['id'],
    idKategori: data['kategori_id'],
    idPemesanan: data['pemesanan_id'],
    kategori: Kategori.parseFromJson(data['kategori'])
  );
}

List<DataPemesanan> dataPemesananFromJson(List<dynamic> data) => data.map((e) => DataPemesanan.parseFromJson(e)).toList();

class Pemesanan {
  int id;
  StatusPemesanan statusPemesanan;
  String alamat;
  DateTime tanggalPernikahan;
  int harga;
  String jenisPemesanan;

  List<DataPemesanan> dataPemesanan;

  Pemesanan({
    this.id,
    this.statusPemesanan,
    this.alamat,
    this.tanggalPernikahan,
    this.harga,
    this.jenisPemesanan,
    this.dataPemesanan
  });

  factory Pemesanan.parseFromJson(Map<String, dynamic> data) => Pemesanan(
    id: data['id'],
    statusPemesanan: StatusPemesanan.parseFromJson(data['status']),
    harga: data['harga'],
    alamat: data['alamat'],
    jenisPemesanan: data['jenis'],
    tanggalPernikahan: data['tanggalPernikahan'] != null ? DateFormat.yMd().parse(data['tanggalPernikahan']) : null,
    dataPemesanan: dataPemesananFromJson(data['data'])
  );
}

List<Pemesanan> pemesananFromJson(List<dynamic> data) => data.map((e) => Pemesanan.parseFromJson(e)).toList();
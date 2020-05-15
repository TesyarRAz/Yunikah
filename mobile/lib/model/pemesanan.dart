import 'package:yunikah/model/kategori.dart';

class DataPemesanan {
  int id;
  
  Kategori kategori;

  DataPemesanan({
    this.id,
    this.kategori
  });
}

class Pemesanan {
  int id;

  List<DataPemesanan> data;

  Pemesanan({
    this.id,
    this.data
  });
}
import 'package:flutter/material.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/pemesanan.dart';

class IklanProvider extends ValueNotifier<List<Iklan>> {
  IklanProvider(List<Iklan> value) : super(value);
}

class PaketProvider extends ValueNotifier<List<Paket>> {
  PaketProvider(List<Paket> value) : super(value);
}

class MitraProvider extends ValueNotifier<List<Mitra>> {
  MitraProvider(List<Mitra> value) : super(value);
}

class KategoriProvider extends ValueNotifier<List<Kategori>> {
  KategoriProvider(List<Kategori> value) : super(value);
}

class PemesananProvider extends ValueNotifier<List<Pemesanan>> {
  PemesananProvider(List<Pemesanan> value) : super(value);
}
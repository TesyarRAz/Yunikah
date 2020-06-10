import 'package:flutter/material.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';

class IklanProvider extends ValueNotifier<ApiData<Iklan>> {
  IklanProvider(ApiData<Iklan> value) : super(value);
}

class PaketProvider extends ValueNotifier<ApiData<Paket>> {
  PaketProvider(ApiData<Paket> value) : super(value);
}

class MitraProvider extends ValueNotifier<ApiData<Mitra>> {
  MitraProvider(ApiData<Mitra> value) : super(value);
}

class ProdukProvider extends ValueNotifier<ApiData<Produk>> {
  ProdukProvider(ApiData<Produk> value) : super(value);
}
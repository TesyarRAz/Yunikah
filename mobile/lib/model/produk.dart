import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/network.dart';

class Kategori {
  int id;
  String name;
  String? url;

  // Very Optional, only for system
  Asset? image;

  Kategori({required this.id, required this.name, this.url, this.image});
  
  factory Kategori.parseFromJson(Map<String, dynamic> map) => Kategori(
    id: map['id'],
    name: map['name']
  );
}

class DetailProduk {
  int id;
  String name;

  int harga;

  DetailProduk({required this.id, required this.name, required this.harga});

  factory DetailProduk.parseFromJson(Map<String, dynamic> map) => DetailProduk(
    id: map['id'],
    name: map['name'],
    harga: map['harga']
  );
}


enum ProdukType {
  CUSTOM,
  TERSEDIA,
  COMBO
}

class Produk {
  int id;
  int harga;
  String name;
  String keterangan;
  int transaksi;

  Mitra mitra;
  Asset image;
  ProdukType type;
  Kategori? kategori;
  List<DetailProduk>? data;

  Produk({
    required this.id,
    required this.harga,
    required this.name,
    required this.keterangan,
    required this.mitra,
    required this.image,
    required this.type,
    this.kategori,
    this.data,
    required this.transaksi
  });

  factory Produk.parseFromJson(Map<String, dynamic> data) => Produk(
    id: data['id'],
    harga: data['harga'],
    name: data['name'],
    keterangan: data['keterangan'],
    image: Asset.parseFromJson(data['image']),
    type: data['type'] == "tersedia" ? ProdukType.TERSEDIA : data['type'] == "pilihan" ? ProdukType.COMBO : ProdukType.CUSTOM,
    mitra: Mitra.parseFromJson(data['mitra']),
    data: data['pilihans'] == null ? null : (data['pilihans'] as List<dynamic>).map((json) => DetailProduk.parseFromJson(json)).toList(),
    transaksi: data['total_transaksi']
  );
}

List<Produk> parseProdukFromJson(List<dynamic> data) => data.map((map) => Produk.parseFromJson(map)).toList();

final List<Kategori> kKategori = [
  Kategori(
    id: 1,
    name: 'Rias',
    url: 'rias',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/32"
    )
  ),
  Kategori(
    id: 2,
    name: 'Hiburan',
    url: 'hiburan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/37"
    )
  ),
  Kategori(
    id: 3,
    name: 'Undangan',
    url: 'undangan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/76"
    )
  ),
  Kategori(
    id: 4,
    name: 'Tenda',
    url: 'tenda',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/56"
    )
  ),
  Kategori(
    id: 5,
    name: 'Photo',
    url: 'photo',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/45"
    )
  ),
  Kategori(
    id: 6,
    name: 'Catering',
    url: 'ketring',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/25"
    )
  )
];
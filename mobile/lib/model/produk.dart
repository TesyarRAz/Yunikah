import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/network.dart';

class Kategori {
  int id;
  String name;

  // Very Optional, only for system
  Asset image;

  Kategori({this.id, this.name, this.image});
  
  factory Kategori.parseFromJson(Map<String, dynamic> map) => Kategori(
    id: map['id'],
    name: map['name']
  );
}

class DetailProduk {
  int id;
  String name;

  int harga;

  DetailProduk({this.id, this.name, this.harga});

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

  Mitra mitra;
  Asset image;
  ProdukType type;
  Kategori kategori;
  List<DetailProduk> data;

  Produk({
    this.id, 
    this.harga, 
    this.name, 
    this.keterangan, 
    this.mitra,
    this.image, 
    this.type, 
    this.kategori, 
    this.data
  });

  factory Produk.parseFromJson(Map<String, dynamic> data) => Produk(
    id: data['id'],
    harga: data['harga'],
    name: data['name'],
    keterangan: data['keterangan'],
    image: Asset.parseFromJson(data['image']),
    // type: KategoriType.values.singleWhere((type) => type.toString() == data['kategori']),
    data: List.from(data['data']).map((json) => DetailProduk.parseFromJson(json)).toList(),
    mitra: Mitra.parseFromJson(data['mitra'])
  );
}

List<Produk> parseProdukFromJson(List<dynamic> data) => data.map((map) => Produk.parseFromJson(map)).toList();

final List<Kategori> kKategori = [
  Kategori(
    id: 1,
    name: 'Rias',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/32"
    )
  ),
  Kategori(
    id: 2,
    name: 'Hiburan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/37"
    )
  ),
  Kategori(
    id: 3,
    name: 'Undangan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/76"
    )
  ),
  Kategori(
    id: 4,
    name: 'Tenda',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/56"
    )
  ),
  Kategori(
    id: 5,
    name: 'Photo',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/45"
    )
  ),
  Kategori(
    id: 6,
    name: 'Catering',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/25"
    )
  )
];
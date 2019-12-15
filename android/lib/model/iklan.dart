import 'package:yunikah/model/asset.dart';

class Iklan {
  int id;
  String name;
  String keterangan;

  Asset image;

  Iklan({
    this.id,
    this.name,
    this.image,
    this.keterangan
  });

  factory Iklan.parseFromJson(Map<String, dynamic> data) => Iklan(
    id: data['id'],
    name: data['name'],
    image: Asset.parseFromJson(data['image']),
    keterangan: data['keterangan']
  );
}

List<Iklan> iklanFromJson(List<dynamic> data) => data.map((e) => Iklan.parseFromJson(e)).toList();
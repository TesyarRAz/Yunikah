import 'package:yunikah/model/asset.dart';

class Mitra {
  int id;
  String name;

  Asset image;

  Mitra({
    this.id,
    this.name,
    this.image
  });

  factory Mitra.parseFromJson(Map<String, dynamic> data) => Mitra(
    id: data['id'],
    name: data['name'],
    image: Asset.parseFromJson(data['image'])
  );
}

List<Mitra> mitraFromJson(List<dynamic> data) => data.map((e) => Mitra.parseFromJson(e)).toList();
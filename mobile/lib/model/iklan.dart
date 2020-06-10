import 'package:yunikah/model/asset.dart';

class Iklan {
  int id;
  String name;
  
  Asset image;

  Iklan({this.id, this.name, this.image});

  factory Iklan.parseFromJson(Map<String, dynamic> data) => Iklan(
    id: data['id'],
    name: data['name'],
    image: Asset.parseFromJson(data['image'])
  );
}

List<Iklan> parseIklanFromJson(List<dynamic> data) => data.map((map) => Iklan.parseFromJson(map)).toList();
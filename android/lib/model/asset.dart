import 'dart:convert';

enum AssetType {
  image,
  audio
}

class Asset {
  int id;
  String name;
  String imageLink;

  Asset({
    this.id,
    this.name,
    this.imageLink
  });

  factory Asset.parseFromJson(Map<String, dynamic> data) => Asset(
    id: data['id'],
    name: data['name'],
    imageLink: data['image_link']
  );
}

List<Asset> assetsFromJson(List<String> data) => data.map((e) => Asset.parseFromJson(jsonDecode(e))).toList();
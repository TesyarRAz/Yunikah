
enum AssetType {
  image,
  audio
}

class Asset {
  int id;
  String name;
  String url;
  String thumbnailUrl;
  AssetType type;

  Asset({this.id, this.name, this.url, this.thumbnailUrl, this.type = AssetType.image});

  factory Asset.parseFromJson(Map<String, dynamic> data) =>
    Asset(
      id: data['id'],
      name: data['title'],
      url: data['url'],
      thumbnailUrl: data['thumbnailUrl']
    );
  
  Map<String, dynamic> toJson() =>
    { 'id' : id, 'title' : name, 'url' : url, 'thumbnailUrl' : thumbnailUrl, 'type' : type};
}

List<Asset> assetsFromJson(List<Map<String, dynamic>> data) => data.map((e) => Asset.parseFromJson(e));
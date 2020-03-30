class Asset {
  int id;
  String name;
  String link;

  Asset({this.id, this.name, this.link});

  factory Asset.parseFromJson(Map<String, dynamic> map) => Asset(
    id: map['id'],
    name: map['name'],
    link: map['link']
  );
}
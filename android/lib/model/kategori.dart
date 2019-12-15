class Kategori {
  int id;
  int userId;
  String name;
  int harga;

  Kategori({this.id, this.userId, this.name, this.harga});

  factory Kategori.parseFromJson(Map<String, dynamic> data) =>
    Kategori(
      id: data['id'],
      userId: data['userId'],
      name: data['title'],
      );

  Map<String, dynamic> toJson() =>
    { 'id' : id, 'userId' : userId, 'title' : name };
}

class Rias extends Kategori {
  Rias({int id, int userId, String name, int harga}) :
    super(id : id, userId : userId, name: name, harga: harga);

  factory Rias.parseFromJson(Map<String, dynamic> data) =>
    Rias(
      id: data['id'],
      userId: data['userId'],
      name: data['title']
      );
}

class Paket extends Kategori {
  Paket({int id, int userId, String name, int harga}) : 
    super(id : id, userId : userId, name: name, harga: harga);

  factory Paket.parseFromJson(Map<String, dynamic> data) =>
    Paket(
      id: data['id'],
      userId: data['userId'],
      name: data['title']
      );
}

List<Rias> riasesFromJson(List<Map<String, dynamic>> data) => data.map((e) => Rias.parseFromJson(e));
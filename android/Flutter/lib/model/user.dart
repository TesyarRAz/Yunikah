class StatusUser {
  int id;
  String name;

  StatusUser({
    this.id,
    this.name
  });

  factory StatusUser.parseFromJson(Map<String, dynamic> data) => StatusUser(
    id: data['id'],
    name: data['name']
  );
}

class User {
  int id;
  String name;
  String username;
  String password;
  String telp;
  String alamat;

  // For Authentication
  String token;

  StatusUser statusUser;

  User({
    this.id,
    this.name,
    this.username,
    this.password,
    this.telp,
    this.alamat,
    this.token,
    this.statusUser
  });

  factory User.parseFromJson(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    username: data['username'],
    telp: data['telp'],
    alamat: data['alamat'],
    token: data['token'],
    // statusUser: StatusUser.parseFromJson(data['status'])
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'username' : username,
    'password' : password,
    'telp' : telp,
    'alamat' : alamat
  };
}
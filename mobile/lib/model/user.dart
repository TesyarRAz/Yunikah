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
  String phone;
  String alamat;

  // For Authentication
  String token;

  StatusUser statusUser;

  User({
    this.id,
    this.name,
    this.username,
    this.password,
    this.phone,
    this.alamat,
    this.token,
    this.statusUser
  });

  factory User.parseFromJson(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    username: data['username'],
    phone: data['phone'],
    alamat: data['alamat'],
    token: data['token'],
  );

  String get authToken => "Bearer $token";
}
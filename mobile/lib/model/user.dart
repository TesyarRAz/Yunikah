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
  String email;

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
    this.statusUser,
    this.email
  });

  factory User.parseFromJson(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    email: data['email'],
    username: data['username'],
    phone: data['phone'],
    alamat: data['alamat'],
    token: data['token'],
  );

  String get authToken => "Bearer $token";
}
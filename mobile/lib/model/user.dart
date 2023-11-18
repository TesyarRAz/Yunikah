class StatusUser {
  int id;
  String name;

  StatusUser({
    required this.id,
    required this.name
  });

  factory StatusUser.parseFromJson(Map<String, dynamic> data) => StatusUser(
    id: data['id'],
    name: data['name']
  );
}

class User {
  int? id;
  String name;
  String username;
  String? password;
  String phone;
  String? alamat;
  String email;

  // For Authentication
  String? token;

  StatusUser? statusUser;

  User({
    this.id,
    required this.name,
    required this.username,
    this.password,
    required this.phone,
    this.alamat,
    this.token,
    this.statusUser,
    required this.email
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
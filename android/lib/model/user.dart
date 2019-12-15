class User {
  String username;
  String password;
  String name;

  User(username, password, { this.name = ''});

  bool isSameIdentity(User user) => user.username == username && password == user.password;
}

final List<User> users = [
  User('admin', 'admin', name: 'Admin')
];
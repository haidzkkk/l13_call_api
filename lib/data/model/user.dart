
class User {
  String? id;
  String name;
  String username;
  String password;

  User.create(this.name, this.username, this.password);
  User(this.id, this.name, this.username, this.password);

  User.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? "";
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, password: $password}';
  }
}
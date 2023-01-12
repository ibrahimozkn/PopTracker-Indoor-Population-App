class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String token;
  String? role;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        required this.token,});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      token: json["token"],);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "token": token,
  };
}

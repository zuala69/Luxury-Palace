class UserModel {
  late String id;
  late String name;
  late String email;
  String? occupation;
  String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.occupation,
    this.avatar,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    occupation = json['occupation'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "occupation": occupation,
      "avatar": avatar,
    };
  }
}

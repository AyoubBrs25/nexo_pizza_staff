class UserModel {
  String? password;
  String? email;
  String? fullName;
  bool? isActive;
  String? avatarUrl;
  String? role;

  UserModel({
    this.password,
    this.email,
    this.fullName,
    this.isActive,
    this.avatarUrl,
    this.role,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "passwordHash": password,
    "fullname": fullName,
    "isActive": isActive,
  };

  factory UserModel.fromJson(Map<String, dynamic> jsonUser) => UserModel(
    email: jsonUser['email'],
    fullName: jsonUser['fullname'],
    isActive: jsonUser['isActive'],
    avatarUrl: jsonUser['avatarUrl'],
    role: jsonUser['role'],
  );
}

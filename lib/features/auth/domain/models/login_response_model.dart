class LoginResponseModel {
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['User'] ?? {}),
    );
  }
}

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String fullName;
  final String type;
  final bool isPaid;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.type,
    required this.isPaid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      type: json['type'] ?? '',
      isPaid: json['isPaid'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'type': type,
      'isPaid': isPaid,
    };
  }
}

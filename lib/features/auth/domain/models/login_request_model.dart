class LoginRequestModel {
  final String userName;
  final String password;

  LoginRequestModel({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  String? validate() {
    if (userName.trim().isEmpty) return 'Username is required';
    if (password.trim().isEmpty) return 'Password is required';
    return null;
  }
}

class VerifyCodeRequestModel {
  final String email;
  final String code;

  VerifyCodeRequestModel({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }

  String? validate() {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'Invalid email format';
    }
    if (code.isEmpty) {
      return 'Verification code is required';
    }
    if (code.length != 6) {
      return 'Verification code must be 6 digits';
    }
    return null;
  }
}

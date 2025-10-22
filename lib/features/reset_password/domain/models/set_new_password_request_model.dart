class SetNewPasswordRequestModel {
  final String email;
  final String newpassword;

  SetNewPasswordRequestModel({
    required this.email,
    required this.newpassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newpassword': newpassword,
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
    if (newpassword.isEmpty) {
      return 'Password is required';
    }
    if (newpassword.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(newpassword)) {
      return 'Password must include at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(newpassword)) {
      return 'Password must include at least one lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(newpassword)) {
      return 'Password must include at least one digit';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(newpassword)) {
      return 'Password must include at least one special character';
    }
    return null;
  }
}

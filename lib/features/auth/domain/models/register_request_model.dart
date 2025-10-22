class RegisterRequestModel {
  final String fullName;
  final String email;
  final String userName;
  final String password;
  final bool isUniversityStudent;
  final String? universityId;
  final String? facultyId;
  final String? levelId;

  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.userName,
    required this.password,
    required this.isUniversityStudent,
    this.universityId,
    this.facultyId,
    this.levelId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'password': password,
      'isUniversityStudent': isUniversityStudent,
      if (isUniversityStudent && universityId != null) 'universityId': universityId,
      if (isUniversityStudent && facultyId != null) 'facultyId': facultyId,
      if (isUniversityStudent && levelId != null) 'levelId': levelId,
    };
  }

  String? validate() {
    if (fullName.trim().isEmpty) return 'Full name is required';
    if (userName.trim().isEmpty) return 'Username is required';
    if (email.trim().isEmpty) return 'Email is required';
    if (!_isValidEmail(email)) return 'Invalid email format';
    if (password.trim().isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';

    if (isUniversityStudent) {
      if (universityId == null || universityId!.isEmpty) {
        return 'University is required for university students';
      }
      if (facultyId == null || facultyId!.isEmpty) {
        return 'Faculty is required for university students';
      }
      if (levelId == null || levelId!.isEmpty) {
        return 'Level is required for university students';
      }
    }

    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}

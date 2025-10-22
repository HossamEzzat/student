class UniversityModel {
  final String id;
  final String name;
  final List<FacultyModel> faculties;

  UniversityModel({
    required this.id,
    required this.name,
    required this.faculties,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      faculties: (json['faculties'] as List<dynamic>)
          .map((e) => FacultyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'faculties': faculties.map((e) => e.toJson()).toList(),
    };
  }
}

class FacultyModel {
  final String id;
  final String name;

  FacultyModel({
    required this.id,
    required this.name,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

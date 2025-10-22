class ModuleItem {
  final String id;
  final String name;
  final String description;
  final String coverImageUrl;
  final double price;
  final int studentsCount;
  final int videosCount;
  final String createdAt;
  final String doctorName;
  final List<ModuleDocument> documents;
  final List<ModuleVideo> videos;

  final String? moduleName;
  final String? moduleStartDate;
  final String? moduleEndDate;
  final String? instructorName;

  ModuleItem({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.price,
    required this.studentsCount,
    required this.videosCount,
    required this.createdAt,
    required this.doctorName,
    required this.documents,
    required this.videos,
    this.moduleName,
    this.moduleStartDate,
    this.moduleEndDate,
    this.instructorName,
  });

  factory ModuleItem.fromJson(Map<String, dynamic> json) {
    final docs = json['documents'] as List<dynamic>?;
    final vids = json['videos'] as List<dynamic>?;

    return ModuleItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      price: ((json['price'] as num?) ?? 0).toDouble(),
      studentsCount: json['studentsCount'] ?? 0,
      videosCount: json['videosCount'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      doctorName: json['doctorName'] ?? '',
      documents: docs != null
          ? docs
              .map((d) => ModuleDocument.fromJson(d as Map<String, dynamic>))
              .toList()
          : [],
      videos: vids != null
          ? vids
              .map((v) => ModuleVideo.fromJson(v as Map<String, dynamic>))
              .toList()
          : [],
      moduleName: json['moduleName'],
      moduleStartDate: json['moduleStartDate'],
      moduleEndDate: json['moduleEndDate'],
      instructorName: json['instructorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'price': price,
      'studentsCount': studentsCount,
      'videosCount': videosCount,
      'createdAt': createdAt,
      'doctorName': doctorName,
      'documents': documents.map((d) => d.toJson()).toList(),
      'videos': videos.map((v) => v.toJson()).toList(),
      'moduleName': moduleName,
      'moduleStartDate': moduleStartDate,
      'moduleEndDate': moduleEndDate,
      'instructorName': instructorName,
    };
  }
}

class ModuleDocument {
  final String id;
  final String title;
  final String documentUrl;
  final String uploadedAt;

  ModuleDocument({
    required this.id,
    required this.title,
    required this.documentUrl,
    required this.uploadedAt,
  });

  factory ModuleDocument.fromJson(Map<String, dynamic> json) {
    return ModuleDocument(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      documentUrl: json['documentUrl'] ?? '',
      uploadedAt: json['uploadedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'documentUrl': documentUrl,
      'uploadedAt': uploadedAt,
    };
  }
}

class ModuleVideo {
  final String id;
  final String title;
  final String courseName;
  final String duration;
  final String description;
  final String coverImageUrl;
  final int views;
  final String uploadedAgo;
  final String videoUrl;

  ModuleVideo({
    required this.id,
    required this.title,
    required this.courseName,
    required this.duration,
    required this.description,
    required this.coverImageUrl,
    required this.views,
    required this.uploadedAgo,
    required this.videoUrl,
  });

  factory ModuleVideo.fromJson(Map<String, dynamic> json) {
    return ModuleVideo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      courseName: json['courseName'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      views: json['views'] ?? 0,
      uploadedAgo: json['uploadedAgo'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'courseName': courseName,
      'duration': duration,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'views': views,
      'uploadedAgo': uploadedAgo,
      'videoUrl': videoUrl,
    };
  }
}

class ModulesResponse {
  final bool success;
  final ModulesResult result;
  final String message;

  ModulesResponse({
    required this.success,
    required this.result,
    required this.message,
  });

  factory ModulesResponse.fromJson(Map<String, dynamic> json) {
    return ModulesResponse(
      success: json['success'] ?? false,
      result: ModulesResult.fromJson(json['result'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class ModulesResult {
  final List<ModuleItem> modules;

  ModulesResult({required this.modules});

  factory ModulesResult.fromJson(Map<String, dynamic> json) {
    final modulesList = json['Modules'] as List<dynamic>? ?? [];
    return ModulesResult(
      modules: modulesList
          .map((item) => ModuleItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

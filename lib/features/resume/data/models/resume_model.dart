import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.id,
    required super.role,
    required super.company,
    required super.start,
    required super.end,
    required super.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'company': company,
      'start': start,
      'end': end,
      'description': description,
    };
  }

  factory ExperienceModel.fromEntity(ExperienceEntity entity) {
    return ExperienceModel(
      id: entity.id,
      role: entity.role,
      company: entity.company,
      start: entity.start,
      end: entity.end,
      description: entity.description,
    );
  }
}

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.id,
    required super.school,
    required super.degree,
    required super.start,
    required super.end,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] ?? '',
      school: json['school'] ?? '',
      degree: json['degree'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school': school,
      'degree': degree,
      'start': start,
      'end': end,
    };
  }

  factory EducationModel.fromEntity(EducationEntity entity) {
    return EducationModel(
      id: entity.id,
      school: entity.school,
      degree: entity.degree,
      start: entity.start,
      end: entity.end,
    );
  }
}

class CertificateModel extends CertificateEntity {
  const CertificateModel({
    required super.id,
    required super.name,
    required super.issuer,
    required super.year,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      issuer: json['issuer'] ?? '',
      year: json['year'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'issuer': issuer,
      'year': year,
    };
  }

  factory CertificateModel.fromEntity(CertificateEntity entity) {
    return CertificateModel(
      id: entity.id,
      name: entity.name,
      issuer: entity.issuer,
      year: entity.year,
    );
  }
}

class ExportRecordModel extends ExportRecordEntity {
  const ExportRecordModel({
    required super.id,
    required super.name,
    super.format = 'PDF',
    super.size = '—',
    required super.createdAt,
  });

  factory ExportRecordModel.fromJson(Map<String, dynamic> json) {
    return ExportRecordModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      format: json['format'] ?? 'PDF',
      size: json['size'] ?? '—',
      createdAt: json['createdAt'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'format': format,
      'size': size,
      'createdAt': createdAt,
    };
  }

  factory ExportRecordModel.fromEntity(ExportRecordEntity entity) {
    return ExportRecordModel(
      id: entity.id,
      name: entity.name,
      format: entity.format,
      size: entity.size,
      createdAt: entity.createdAt,
    );
  }
}

class ResumeModel extends ResumeEntity {
  const ResumeModel({
    required super.id,
    super.photo,
    required super.fullName,
    required super.title,
    required super.email,
    required super.phone,
    required super.location,
    required super.website,
    required super.objective,
    super.experiences = const [],
    super.educations = const [],
    super.skills = const [],
    super.certificates = const [],
    super.tag = 'Active',
    required super.updatedAt,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      id: json['id'] ?? '',
      photo: json['photo'],
      fullName: json['fullName'] ?? '',
      title: json['title'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      website: json['website'] ?? '',
      objective: json['objective'] ?? '',
      experiences: (json['experiences'] as List<dynamic>?)
              ?.map((e) => ExperienceModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      educations: (json['educations'] as List<dynamic>?)
              ?.map((e) => EducationModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      certificates: (json['certificates'] as List<dynamic>?)
              ?.map((e) => CertificateModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      tag: json['tag'] ?? 'Active',
      updatedAt: json['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'fullName': fullName,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'website': website,
      'objective': objective,
      'experiences': experiences
          .map((e) => (e is ExperienceModel ? e : ExperienceModel.fromEntity(e)).toJson())
          .toList(),
      'educations': educations
          .map((e) => (e is EducationModel ? e : EducationModel.fromEntity(e)).toJson())
          .toList(),
      'skills': skills,
      'certificates': certificates
          .map((e) => (e is CertificateModel ? e : CertificateModel.fromEntity(e)).toJson())
          .toList(),
      'tag': tag,
      'updatedAt': updatedAt,
    };
  }

  factory ResumeModel.fromEntity(ResumeEntity entity) {
    return ResumeModel(
      id: entity.id,
      photo: entity.photo,
      fullName: entity.fullName,
      title: entity.title,
      email: entity.email,
      phone: entity.phone,
      location: entity.location,
      website: entity.website,
      objective: entity.objective,
      experiences: entity.experiences,
      educations: entity.educations,
      skills: entity.skills,
      certificates: entity.certificates,
      tag: entity.tag,
      updatedAt: entity.updatedAt,
    );
  }
}

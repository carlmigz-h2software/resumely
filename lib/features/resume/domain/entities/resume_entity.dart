import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String id;
  final String role;
  final String company;
  final String start;
  final String end;
  final String description;

  const ExperienceEntity({
    required this.id,
    required this.role,
    required this.company,
    required this.start,
    required this.end,
    required this.description,
  });

  ExperienceEntity copyWith({
    String? id,
    String? role,
    String? company,
    String? start,
    String? end,
    String? description,
  }) {
    return ExperienceEntity(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      start: start ?? this.start,
      end: end ?? this.end,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, role, company, start, end, description];
}

class EducationEntity extends Equatable {
  final String id;
  final String school;
  final String degree;
  final String start;
  final String end;

  const EducationEntity({
    required this.id,
    required this.school,
    required this.degree,
    required this.start,
    required this.end,
  });

  EducationEntity copyWith({
    String? id,
    String? school,
    String? degree,
    String? start,
    String? end,
  }) {
    return EducationEntity(
      id: id ?? this.id,
      school: school ?? this.school,
      degree: degree ?? this.degree,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  List<Object?> get props => [id, school, degree, start, end];
}

class CertificateEntity extends Equatable {
  final String id;
  final String name;
  final String issuer;
  final String year;

  const CertificateEntity({
    required this.id,
    required this.name,
    required this.issuer,
    required this.year,
  });

  CertificateEntity copyWith({
    String? id,
    String? name,
    String? issuer,
    String? year,
  }) {
    return CertificateEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      year: year ?? this.year,
    );
  }

  @override
  List<Object?> get props => [id, name, issuer, year];
}

class ExportRecordEntity extends Equatable {
  final String id;
  final String name;
  final String format;
  final String size;
  final int createdAt;

  const ExportRecordEntity({
    required this.id,
    required this.name,
    this.format = 'PDF',
    this.size = '—',
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, format, size, createdAt];
}

class ResumeEntity extends Equatable {
  final String id;
  final String? photo;
  final String fullName;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String website;
  final String objective;
  final List<ExperienceEntity> experiences;
  final List<EducationEntity> educations;
  final List<String> skills;
  final List<CertificateEntity> certificates;
  final String tag; // Active, Draft, Sent
  final int updatedAt;

  const ResumeEntity({
    required this.id,
    this.photo,
    required this.fullName,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.website,
    required this.objective,
    this.experiences = const [],
    this.educations = const [],
    this.skills = const [],
    this.certificates = const [],
    this.tag = 'Active',
    required this.updatedAt,
  });

  // Calculate completion percentage
  int get completionPercentage {
    int personalScore = (fullName.isNotEmpty && title.isNotEmpty && email.isNotEmpty) ? 100 : 50;
    int expScore = experiences.isNotEmpty ? (experiences.length >= 2 ? 100 : 70) : 0;
    int eduScore = educations.isNotEmpty ? 100 : 0;
    int skillScore = skills.isNotEmpty ? (skills.length >= 4 ? 100 : 50) : 0;

    return ((personalScore + expScore + eduScore + skillScore) / 4).round();
  }

  ResumeEntity copyWith({
    String? id,
    String? photo,
    String? fullName,
    String? title,
    String? email,
    String? phone,
    String? location,
    String? website,
    String? objective,
    List<ExperienceEntity>? experiences,
    List<EducationEntity>? educations,
    List<String>? skills,
    List<CertificateEntity>? certificates,
    String? tag,
    int? updatedAt,
  }) {
    return ResumeEntity(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      website: website ?? this.website,
      objective: objective ?? this.objective,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      skills: skills ?? this.skills,
      certificates: certificates ?? this.certificates,
      tag: tag ?? this.tag,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        photo,
        fullName,
        title,
        email,
        phone,
        location,
        website,
        objective,
        experiences,
        educations,
        skills,
        certificates,
        tag,
        updatedAt,
      ];
}

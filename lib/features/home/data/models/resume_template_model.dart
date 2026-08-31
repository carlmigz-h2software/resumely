import 'package:resumely/features/home/domain/entities/resume_template_entity.dart';

class ResumeTemplateModel extends ResumeTemplateEntity {
  const ResumeTemplateModel({
    required super.id,
    required super.name,
    required super.description,
    super.isPremium = false,
    super.previewAsset = '',
  });

  factory ResumeTemplateModel.fromJson(Map<String, dynamic> json) {
    return ResumeTemplateModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isPremium: json['isPremium'] as bool? ?? false,
      previewAsset: json['previewAsset'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isPremium': isPremium,
      'previewAsset': previewAsset,
    };
  }
}

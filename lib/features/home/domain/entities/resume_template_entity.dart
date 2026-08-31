import 'package:equatable/equatable.dart';

class ResumeTemplateEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isPremium;
  final String previewAsset;

  const ResumeTemplateEntity({
    required this.id,
    required this.name,
    required this.description,
    this.isPremium = false,
    this.previewAsset = '',
  });

  @override
  List<Object?> get props => [id, name, description, isPremium, previewAsset];
}

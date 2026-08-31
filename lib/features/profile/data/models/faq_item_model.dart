import 'package:resumely/features/profile/domain/entities/faq_item_entity.dart';

class FaqItemModel extends FaqItemEntity {
  const FaqItemModel({
    required super.id,
    required super.title,
    required super.icon,
    super.answer,
  });

  factory FaqItemModel.fromJson(Map<String, dynamic> json) {
    return FaqItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'],
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'answer': answer,
    };
  }
}

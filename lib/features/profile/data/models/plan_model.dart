import 'package:resumely/features/profile/domain/entities/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    required super.id,
    required super.name,
    required super.price,
    required super.period,
    required super.features,
    super.isCurrent = false,
    super.isPopular = false,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as String? ?? '',
      period: json['period'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      isCurrent: json['isCurrent'] as bool? ?? false,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'period': period,
      'features': features,
      'isCurrent': isCurrent,
      'isPopular': isPopular,
    };
  }
}

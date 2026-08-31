import 'package:equatable/equatable.dart';

class PlanEntity extends Equatable {
  final String id;
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isCurrent;
  final bool isPopular;

  const PlanEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.isCurrent = false,
    this.isPopular = false,
  });

  @override
  List<Object?> get props => [id, name, price, period, features, isCurrent, isPopular];
}

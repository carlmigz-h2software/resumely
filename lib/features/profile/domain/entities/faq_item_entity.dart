import 'package:equatable/equatable.dart';

class FaqItemEntity extends Equatable {
  final String id;
  final String title;
  final dynamic icon;
  final String? answer;

  const FaqItemEntity({
    required this.id,
    required this.title,
    required this.icon,
    this.answer,
  });

  @override
  List<Object?> get props => [id, title, icon, answer];
}

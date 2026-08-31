import 'package:equatable/equatable.dart';

class SectionProgressEntity extends Equatable {
  final String id;
  final String title;
  final dynamic icon;
  final double progress;
  final String route;

  const SectionProgressEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.progress,
    required this.route,
  });

  @override
  List<Object?> get props => [id, title, icon, progress, route];
}

class AiSuggestionEntity extends Equatable {
  final String title;
  final String description;
  final String actionText;
  final String actionRoute;

  const AiSuggestionEntity({
    required this.title,
    required this.description,
    required this.actionText,
    required this.actionRoute,
  });

  @override
  List<Object?> get props => [title, description, actionText, actionRoute];
}

class HomeDashboardEntity extends Equatable {
  final List<SectionProgressEntity> sections;
  final AiSuggestionEntity suggestion;

  const HomeDashboardEntity({
    required this.sections,
    required this.suggestion,
  });

  @override
  List<Object?> get props => [sections, suggestion];
}

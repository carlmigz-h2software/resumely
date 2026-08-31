import 'package:resumely/features/home/domain/entities/home_dashboard_entity.dart';

class SectionProgressModel extends SectionProgressEntity {
  const SectionProgressModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.progress,
    required super.route,
  });

  factory SectionProgressModel.fromJson(Map<String, dynamic> json) {
    return SectionProgressModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'],
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      route: json['route'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'progress': progress,
      'route': route,
    };
  }
}

class AiSuggestionModel extends AiSuggestionEntity {
  const AiSuggestionModel({
    required super.title,
    required super.description,
    required super.actionText,
    required super.actionRoute,
  });

  factory AiSuggestionModel.fromJson(Map<String, dynamic> json) {
    return AiSuggestionModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      actionText: json['actionText'] as String? ?? '',
      actionRoute: json['actionRoute'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'actionText': actionText,
      'actionRoute': actionRoute,
    };
  }
}

class HomeDashboardModel extends HomeDashboardEntity {
  const HomeDashboardModel({
    required super.sections,
    required super.suggestion,
  });
}

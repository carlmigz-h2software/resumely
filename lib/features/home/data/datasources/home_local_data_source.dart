import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/home/data/models/home_dashboard_model.dart';
import 'package:resumely/features/home/data/models/resume_template_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDashboardModel> getDashboardData();
  Future<List<ResumeTemplateModel>> getTemplates();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeDashboardModel> getDashboardData() async {
    final sections = [
      const SectionProgressModel(
        id: 'personal',
        title: AppStrings.personalInfo,
        icon: AppIcons.fileUser,
        progress: 1.0,
        route: '/editor',
      ),
      const SectionProgressModel(
        id: 'experience',
        title: AppStrings.workExperience,
        icon: AppIcons.briefcase,
        progress: 0.85,
        route: '/editor',
      ),
      const SectionProgressModel(
        id: 'education',
        title: AppStrings.education,
        icon: AppIcons.graduationCap,
        progress: 1.0,
        route: '/editor',
      ),
      const SectionProgressModel(
        id: 'skills',
        title: AppStrings.skillsAndTools,
        icon: AppIcons.sparkles,
        progress: 0.9,
        route: '/editor',
      ),
    ];

    const suggestion = AiSuggestionModel(
      title: AppStrings.aiSuggestion,
      description: AppStrings.aiSuggestionText,
      actionText: AppStrings.applySuggestion,
      actionRoute: '/editor',
    );

    return HomeDashboardModel(
      sections: sections,
      suggestion: suggestion,
    );
  }

  @override
  Future<List<ResumeTemplateModel>> getTemplates() async {
    return const [
      ResumeTemplateModel(
        id: 'modern',
        name: 'Modern Clean',
        description: 'Single-column professional layout',
        isPremium: false,
      ),
      ResumeTemplateModel(
        id: 'executive',
        name: 'Executive Dark',
        description: 'Accentuated corporate structure',
        isPremium: true,
      ),
      ResumeTemplateModel(
        id: 'minimalist',
        name: 'Minimalist Air',
        description: 'Typography first design',
        isPremium: false,
      ),
    ];
  }
}

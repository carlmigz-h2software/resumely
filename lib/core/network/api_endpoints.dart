class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.resumely.app/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/auth/me';
  static const String logout = '/auth/logout';

  // Resumes
  static const String resumes = '/resumes';
  static const String generateResume = '/resumes/generate';
}

import 'package:equatable/equatable.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

enum ResumeStatus { initial, loading, loaded, saving, saved, failure }

class ResumeState extends Equatable {
  final ResumeStatus status;
  final ResumeEntity? activeResume;
  final List<ResumeEntity> resumes;
  final List<ExportRecordEntity> exportHistory;
  final String? errorMessage;

  const ResumeState({
    this.status = ResumeStatus.initial,
    this.activeResume,
    this.resumes = const [],
    this.exportHistory = const [],
    this.errorMessage,
  });

  ResumeState copyWith({
    ResumeStatus? status,
    ResumeEntity? activeResume,
    List<ResumeEntity>? resumes,
    List<ExportRecordEntity>? exportHistory,
    String? errorMessage,
  }) {
    return ResumeState(
      status: status ?? this.status,
      activeResume: activeResume ?? this.activeResume,
      resumes: resumes ?? this.resumes,
      exportHistory: exportHistory ?? this.exportHistory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        activeResume,
        resumes,
        exportHistory,
        errorMessage,
      ];
}

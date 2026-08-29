import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/domain/usecases/resume_usecases.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_event.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_state.dart';
import 'package:uuid/uuid.dart';

export 'resume_event.dart';
export 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final GetActiveResumeUseCase getActiveResumeUseCase;
  final GetAllResumesUseCase getAllResumesUseCase;
  final SaveResumeUseCase saveResumeUseCase;
  final DeleteResumeUseCase deleteResumeUseCase;
  final GetExportHistoryUseCase getExportHistoryUseCase;
  final AddExportRecordUseCase addExportRecordUseCase;

  ResumeBloc({
    required this.getActiveResumeUseCase,
    required this.getAllResumesUseCase,
    required this.saveResumeUseCase,
    required this.deleteResumeUseCase,
    required this.getExportHistoryUseCase,
    required this.addExportRecordUseCase,
  }) : super(const ResumeState()) {
    on<ResumeLoadActiveRequested>(_onLoadActiveRequested);
    on<ResumeLoadAllRequested>(_onLoadAllRequested);
    on<ResumeUpdated>(_onUpdated);
    on<ResumeDeleted>(_onDeleted);
    on<ResumeCreated>(_onCreated);
    on<ResumeExportRequested>(_onExportRequested);
  }

  Future<void> _onLoadActiveRequested(
    ResumeLoadActiveRequested event,
    Emitter<ResumeState> emit,
  ) async {
    emit(state.copyWith(status: ResumeStatus.loading));
    final result = await getActiveResumeUseCase(const NoParams());
    final allResumes = await getAllResumesUseCase(const NoParams());
    final exports = await getExportHistoryUseCase(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ResumeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (active) {
        emit(
          state.copyWith(
            status: ResumeStatus.loaded,
            activeResume: active,
            resumes: allResumes.getOrElse(() => [active]),
            exportHistory: exports.getOrElse(() => []),
          ),
        );
      },
    );
  }

  Future<void> _onLoadAllRequested(
    ResumeLoadAllRequested event,
    Emitter<ResumeState> emit,
  ) async {
    final result = await getAllResumesUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ResumeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (resumes) => emit(
        state.copyWith(
          status: ResumeStatus.loaded,
          resumes: resumes,
        ),
      ),
    );
  }

  Future<void> _onUpdated(
    ResumeUpdated event,
    Emitter<ResumeState> emit,
  ) async {
    emit(state.copyWith(status: ResumeStatus.saving, activeResume: event.resume));
    final updated = event.resume.copyWith(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await saveResumeUseCase(updated);

    final all = List<ResumeEntity>.from(state.resumes);
    final idx = all.indexWhere((r) => r.id == updated.id);
    if (idx >= 0) {
      all[idx] = updated;
    } else {
      all.insert(0, updated);
    }

    emit(
      state.copyWith(
        status: ResumeStatus.saved,
        activeResume: updated,
        resumes: all,
      ),
    );
  }

  Future<void> _onDeleted(
    ResumeDeleted event,
    Emitter<ResumeState> emit,
  ) async {
    await deleteResumeUseCase(event.id);
    final all = state.resumes.where((r) => r.id != event.id).toList();
    ResumeEntity? newActive = state.activeResume;
    if (state.activeResume?.id == event.id) {
      newActive = all.isNotEmpty ? all.first : null;
    }
    emit(state.copyWith(activeResume: newActive, resumes: all));
  }

  Future<void> _onCreated(
    ResumeCreated event,
    Emitter<ResumeState> emit,
  ) async {
    const uuid = Uuid();
    final newResume = ResumeEntity(
      id: uuid.v4(),
      fullName: '',
      title: event.title,
      email: '',
      phone: '',
      location: '',
      website: '',
      objective: '',
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await saveResumeUseCase(newResume);
    final all = [newResume, ...state.resumes];
    emit(state.copyWith(activeResume: newResume, resumes: all));
  }

  Future<void> _onExportRequested(
    ResumeExportRequested event,
    Emitter<ResumeState> emit,
  ) async {
    const uuid = Uuid();
    final record = ExportRecordEntity(
      id: uuid.v4(),
      name: event.name,
      format: 'PDF',
      size: '—',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await addExportRecordUseCase(record);
    final history = [record, ...state.exportHistory];
    emit(state.copyWith(exportHistory: history));
  }
}

import 'package:equatable/equatable.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  @override
  List<Object?> get props => [];
}

class ResumeLoadActiveRequested extends ResumeEvent {
  const ResumeLoadActiveRequested();
}

class ResumeLoadAllRequested extends ResumeEvent {
  const ResumeLoadAllRequested();
}

class ResumeUpdated extends ResumeEvent {
  final ResumeEntity resume;

  const ResumeUpdated(this.resume);

  @override
  List<Object?> get props => [resume];
}

class ResumeDeleted extends ResumeEvent {
  final String id;

  const ResumeDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class ResumeCreated extends ResumeEvent {
  final String title;

  const ResumeCreated({this.title = 'Untitled Resume'});

  @override
  List<Object?> get props => [title];
}

class ResumeExportRequested extends ResumeEvent {
  final String name;

  const ResumeExportRequested({required this.name});

  @override
  List<Object?> get props => [name];
}

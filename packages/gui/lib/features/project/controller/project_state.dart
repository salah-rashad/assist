part of 'project_cubit.dart';

@immutable
sealed class ProjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectFileChanged extends ProjectState {
  final ProjectFileEvent event;

  ProjectFileChanged(this.event);

  @override
  List<Object?> get props => [event];
}

final class ProjectLoaded extends ProjectState {}

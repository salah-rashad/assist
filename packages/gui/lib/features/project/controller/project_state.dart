part of 'project_cubit.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class PubspecChanged extends ProjectState {}

final class ChangelogChanged extends ProjectState {}

final class ReadmeChanged extends ProjectState {}

final class ProjectLoaded extends ProjectState {}

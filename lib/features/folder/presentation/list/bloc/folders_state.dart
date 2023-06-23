part of 'folders_bloc.dart';

sealed class FoldersState {}

class ProgressFoldersState extends FoldersState {
  final bool progress;

  ProgressFoldersState(this.progress);
}

class ErrorFoldersState extends FoldersState {
  final String message;

  ErrorFoldersState(this.message);
}

class LoadedFoldersState extends FoldersState {
  final List<Folder> folders;

  LoadedFoldersState(this.folders);
}
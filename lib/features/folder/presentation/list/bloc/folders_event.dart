part of 'folders_bloc.dart';

sealed class FoldersEvent {}

class LoadFoldersEvent extends FoldersEvent {}

class LogoutFoldersEvent extends FoldersEvent {}

class AddFolderEvent extends FoldersEvent {
  final String name;

  AddFolderEvent(this.name);
}

class DeleteFolderEvent extends FoldersEvent {
  final Folder folder;

  DeleteFolderEvent(this.folder);
}

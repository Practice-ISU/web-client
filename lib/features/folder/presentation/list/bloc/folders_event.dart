part of 'folders_bloc.dart';

sealed class FoldersEvent {}

class LoadFoldersEvent extends FoldersEvent {}

class LogoutFoldersEvent extends FoldersEvent {}
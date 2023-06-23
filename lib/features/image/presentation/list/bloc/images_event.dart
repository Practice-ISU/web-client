part of 'images_bloc.dart';

sealed class ImagesEvent {}

class LoadImagesEvent extends ImagesEvent {
  final int folderId;

  LoadImagesEvent(this.folderId);
}

class LogoutImagesEvent extends ImagesEvent {}
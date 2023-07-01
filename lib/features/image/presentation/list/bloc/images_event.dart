part of 'images_bloc.dart';

sealed class ImagesEvent {}

class LoadImagesEvent extends ImagesEvent {}

class LogoutImagesEvent extends ImagesEvent {}

class DeleteImageEvent extends ImagesEvent {
  final int id;

  DeleteImageEvent(this.id);
}

class DownloadEvent extends ImagesEvent {
  DownloadEvent();
}
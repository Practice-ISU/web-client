part of 'images_bloc.dart';

sealed class ImagesState {}

class ProgressImagesState extends ImagesState {
  final bool progress;

  ProgressImagesState(this.progress);
}

class ErrorImagesState extends ImagesState {
  final String message;

  ErrorImagesState(this.message);
}

class LoadedImagesState extends ImagesState {
  final GetImagesResponse images;

  LoadedImagesState(this.images);
}
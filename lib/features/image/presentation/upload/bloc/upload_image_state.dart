part of 'upload_image_bloc.dart';

sealed class UploadImageState {}

class ProgressImageState extends UploadImageState {
  final bool progress;
  ProgressImageState(this.progress);
}

class UploadedImageState extends UploadImageState {}

class ErrorUploadImageState extends UploadImageState {
  final String message;

  ErrorUploadImageState(this.message);
}
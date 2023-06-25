part of 'upload_image_bloc.dart';

sealed class UploadImageEvent {}

class SendImageEvent extends UploadImageEvent {
  Uint8List original;
  Uint8List painted;

  SendImageEvent(this.original, this.painted);
}
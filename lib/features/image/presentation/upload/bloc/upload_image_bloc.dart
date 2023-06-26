import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/util/dio_exception.dart';
import 'package:image_hoster/features/image/data/images_repository.dart';

part 'upload_image_event.dart';

part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final int folderId;
  late final ImagesRepository _imagesRepository = Injector.instance.resolve();

  UploadImageBloc(this.folderId) : super(ProgressImageState(false)) {
    on<SendImageEvent>(_send);
  }

  _send(SendImageEvent event, Emitter<UploadImageState> emit) async {
    emit(ProgressImageState(true));
    try {
      await _imagesRepository.upload(
        folderId: folderId,
        original: event.original,
        painted: event.painted,
      );
      emit(UploadedImageState());
    } catch (e) {
      emit(ErrorUploadImageState(createErrorMessage(e)));
    }
    emit(ProgressImageState(false));
  }
}

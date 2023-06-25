import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/util/dio_exception.dart';
import 'package:image_hoster/features/auth/data/auth_repository.dart';
import 'package:image_hoster/features/image/data/images_repository.dart';
import 'package:image_hoster/features/image/data/response/get_images_response.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {

  late final AuthRepository _authRepository = Injector.instance.resolve();
  late final ImagesRepository _imagesRepository = Injector.instance.resolve();
  final int folderId;

  ImagesBloc(this.folderId) : super(ProgressImagesState(true)) {
    on<LoadImagesEvent>(_load);
    on<DeleteImageEvent>(_delete);
    on<LogoutImagesEvent>(_logout);
  }

  _load(LoadImagesEvent event, Emitter<ImagesState> emit) async {
    emit(ProgressImagesState(true));
    try {
      final response = await _imagesRepository.getImages(folderId);
      emit(LoadedImagesState(response));
    } catch (e) {
      emit(ErrorImagesState(createErrorMessage(e)));
    }
    emit(ProgressImagesState(false));
  }

  _logout(LogoutImagesEvent event, Emitter<ImagesState> emit) async {
    await _authRepository.logout();
  }

  _delete(DeleteImageEvent event, Emitter<ImagesState> emit) async {
    emit(ProgressImagesState(true));
    try {
      await _imagesRepository.deleteImage(event.id);
      add(LoadImagesEvent());
    } catch (e) {
      emit(ErrorImagesState(createErrorMessage(e)));
    }
    emit(ProgressImagesState(false));
  }
}

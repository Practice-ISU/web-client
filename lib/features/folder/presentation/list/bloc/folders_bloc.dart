import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/util/dio_exception.dart';
import 'package:image_hoster/features/auth/data/auth_repository.dart';
import 'package:image_hoster/features/folder/data/folder_repository.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';

part 'folders_event.dart';

part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  late final FolderRepository _folderRepository = Injector.instance.resolve();

  late final AuthRepository _authRepository = Injector.instance.resolve();

  FoldersBloc() : super(ProgressFoldersState(true)) {
    on<LoadFoldersEvent>(_load);
    on<AddFolderEvent>(_add);
    on<DeleteFolderEvent>(_delete);
    on<LogoutFoldersEvent>(_logout);
  }

  _load(LoadFoldersEvent event, Emitter<FoldersState> emit) async {
    emit(ProgressFoldersState(true));
    try {
      final folders = await _folderRepository.getFolders();
      emit(LoadedFoldersState(folders));
    } catch (e) {
      emit(ErrorFoldersState(createErrorMessage(e)));
    }
    emit(ProgressFoldersState(false));
  }

  _add(AddFolderEvent event, Emitter<FoldersState> emit) async {
    emit(ProgressFoldersState(true));
    try {
      await _folderRepository.addFolder(event.name);
      add(LoadFoldersEvent());
    } catch (e) {
      emit(ErrorFoldersState(createErrorMessage(e)));
    }
    emit(ProgressFoldersState(false));
  }

  _logout(LogoutFoldersEvent event, Emitter<FoldersState> emit) async {
    await _authRepository.logout();
  }

  _delete(DeleteFolderEvent event, Emitter<FoldersState> emit) async {
    emit(ProgressFoldersState(true));
    try {
      await _folderRepository.deleteFolder(event.folder.id);
      add(LoadFoldersEvent());
    } catch (e) {
      emit(ErrorFoldersState(createErrorMessage(e)));
    }
    emit(ProgressFoldersState(false));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/_common/data/util/dio_exception.dart';
import 'package:image_hoster/features/auth/data/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final AuthRepository _authRepository = Injector.instance.resolve();

  LoginBloc() : super(ProgressLoginState(false)) {
    on<SendLoginEvent>(_sendLogin);
    on<RegisterEvent>(_register);
  }

  _sendLogin(SendLoginEvent event, Emitter<LoginState> emit) async {
    emit(ProgressLoginState(false));
    try {
      final result = await _authRepository.login(event.name, event.password);
      SessionStore.instance.setAccessToken(result.token);
      emit(ProgressLoginState(false));
      emit(SuccessLoginState());
    } catch (e) {
      emit(ErrorLoginState(createErrorMessage(e)));
    }
  }

  _register(RegisterEvent event, Emitter<LoginState> emit) async {
    emit(ProgressLoginState(false));
    try {
      final result = await _authRepository.login(event.name, event.password);
      SessionStore.instance.setAccessToken(result.token);
      emit(ProgressLoginState(false));
      emit(SuccessLoginState());
    } catch (e) {
      emit(ErrorLoginState(createErrorMessage(e)));
    }
  }
}

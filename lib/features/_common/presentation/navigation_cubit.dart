import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/_common/presentation/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> with ChangeNotifier {
  NavigationCubit(super.initialState) {
    SessionStore.instance.addListener(_processAuth);
  }

  _processAuth() async {
    if (await SessionStore.instance.isLoggedIn) {
      emit(AuthorizedNavigationState());
    } else {
      emit(UnauthorizedNavigationState());
    }
    notifyListeners();
  }

  @override
  Future<void> close() {
    SessionStore.instance.removeListener(_processAuth);
    return super.close();
  }
}

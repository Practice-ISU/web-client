import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:image_hoster/features/auth/presentation/login/widget/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const LoginWidget(),
    );
  }
}

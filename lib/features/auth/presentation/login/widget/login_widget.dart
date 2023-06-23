import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/components/rounded_text_field.dart';
import 'package:image_hoster/ui/components/screen.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/theme/app_colors.dart';
import 'package:image_hoster/ui/util/snackbar_util.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late final TextEditingController nameController;
  late final TextEditingController passwordController;

  bool inProgress = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ProgressLoginState) {
          setState(() {
            inProgress = state.progress;
          });
        }
        if (state is ErrorLoginState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) => Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.md),
              color: AppColors.gray.shade600),
          padding: const EdgeInsets.all(Dimens.xl),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextField(
                onChanged: (_) {
                  setState(() {});
                },
                keyboardType: TextInputType.text,
                autofocus: true,
                controller: nameController,
                enabled: !inProgress,
                labelText: S.current.name,
              ),
              Gap.sm,
              RoundedTextField(
                onChanged: (_) {
                  setState(() {});
                },
                keyboardType: TextInputType.text,
                autofocus: true,
                controller: passwordController,
                enabled: !inProgress,
                obscureText: true,
                obscuringCharacter: '●',
                labelText: S.current.password,
              ),
              Gap.md,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onLoginPressed(),
                  child: Text(S.current.logIn),
                ),
              ),
              Gap.md,
              TextButton(
                onPressed: _onRegisterPressed(),
                child: Text(S.current.register),
              )
            ],
          ),
        ),
      ),
      showProgress: (state) => inProgress,
    );
  }

  VoidCallback? _onLoginPressed() => _canLogin()
      ? () {
          BlocProvider.of<LoginBloc>(context).add(
              SendLoginEvent(nameController.text, passwordController.text));
        }
      : null;

  VoidCallback? _onRegisterPressed() => _canLogin()
      ? () {
          BlocProvider.of<LoginBloc>(context).add(
              RegisterEvent(nameController.text, passwordController.text));
        }
      : null;

  bool _canLogin() {
    return !inProgress &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}

import 'package:flutter/material.dart';
import 'package:image_hoster/ui/kit/dimens.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const AppIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: Dimens.md,
      onPressed: onPressed,
      icon: icon,
    );
  }
}

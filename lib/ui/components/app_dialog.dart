import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/theme/app_colors.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

class AppDialog extends StatelessWidget {
  final VoidCallback onPositivePressed;
  final String positiveText;
  final String negativeText;
  final String title;

  const AppDialog({
    Key? key,
    required this.onPositivePressed,
    required this.positiveText,
    required this.negativeText,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: AppColors.gray.shade600,
          borderRadius: BorderRadius.circular(Dimens.md)),
      padding: const EdgeInsets.all(Dimens.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.h2,
          ),
          Gap.md,
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(negativeText),
                ),
              ),
              Gap.md,
              Expanded(
                child: ElevatedButton(
                  onPressed: onPositivePressed,
                  child: Text(positiveText),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

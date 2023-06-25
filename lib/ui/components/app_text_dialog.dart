import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_hoster/ui/components/rounded_text_field.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/theme/app_colors.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

class AppTextDialog extends StatefulWidget {
  final ValueChanged<String> onPositivePressed;
  final String positiveText;
  final String negativeText;
  final String title;

  const AppTextDialog({
    Key? key,
    required this.onPositivePressed,
    required this.positiveText,
    required this.negativeText,
    required this.title,
  }) : super(key: key);

  @override
  State<AppTextDialog> createState() => _AppTextDialogState();
}

class _AppTextDialogState extends State<AppTextDialog> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: AppColors.gray.shade600,
          borderRadius: BorderRadius.circular(Dimens.md)),
      padding: const EdgeInsets.all(Dimens.md),
      child: Column(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.h2,
          ),
          Gap.md,
          RoundedTextField(
            controller: textController,
            keyboardType: TextInputType.name,
            onChanged: (text) {
              setState(() {});
            },
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
                  child: Text(widget.negativeText),
                ),
              ),
              Gap.md,
              Expanded(
                child: ElevatedButton(
                  onPressed: textController.text.isNotEmpty
                      ? () {
                          widget.onPositivePressed.call(textController.text);
                        }
                      : null,
                  child: Text(widget.positiveText),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

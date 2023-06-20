import 'package:flutter/material.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

class LabelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const LabelButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.buttonMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
    );
  }
}

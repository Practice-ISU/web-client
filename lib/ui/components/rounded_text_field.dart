import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool showCursor;
  final FocusNode? focusNode;
  final bool obscureText;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? errorText;
  final String? prefixText;
  final ValueChanged<String>? onChanged;

  const RoundedTextField(
      {super.key,
        this.controller,
        this.autofocus = false,
        this.enabled = true,
        this.keyboardType,
        this.showCursor = true,
        this.focusNode,
        this.obscureText = false,
        this.obscuringCharacter = '•',
        this.inputFormatters,
        this.labelText,
        this.errorText,
        this.prefixText,
        this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: keyboardType,
      enabled: enabled,
      showCursor: showCursor,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.inputText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        prefixText: prefixText,
        prefixStyle: Theme.of(context).textTheme.inputText,
      ),
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
    );
  }
}

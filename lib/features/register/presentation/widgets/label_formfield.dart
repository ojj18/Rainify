import 'package:flutter/material.dart';

import '../../../../core/common/widgets/custom_text_field_widget.dart';

class LabelFormfield extends StatelessWidget {
  const LabelFormfield({
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.obsurceText,
    required this.hintText,
    required this.suffix,
    required this.prefix,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final TextInputType keyboardType;
  final bool obsurceText;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Text(
          labelText.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        CustomTextFieldWidget(
          prefix: prefix,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obsurceText: obsurceText,
          hintText: hintText,
          suffix: suffix,
        ),
      ],
    );
  }
}

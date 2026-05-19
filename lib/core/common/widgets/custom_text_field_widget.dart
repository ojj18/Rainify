import 'package:flutter/material.dart';
import 'package:rainify/core/common/app_const.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.obsurceText,
    required this.hintText,
    required this.suffix,
    required this.prefix,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String? value) validator;
  final TextInputType keyboardType;
  final bool obsurceText;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsurceText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: AppConst.mainTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: keyboardType,

      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppConst.mainTextColor,
          overflow: TextOverflow.ellipsis,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: AppConst.errorColor,
          fontSize: 12,
        ),
      ),
      validator: validator,
    );
  }
}

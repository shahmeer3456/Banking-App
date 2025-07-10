import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintLabel;
  final double? widthField;
  final TextEditingController? inputController;
  final VoidCallback? onFieldTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    required this.hintLabel,
    this.widthField,
    this.inputController,
    this.onFieldTap,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthField ?? double.infinity,
      child: TextFormField(
        controller: inputController,
        onTap: onFieldTap,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        validator: validator,
        readOnly: readOnly || onFieldTap != null,
        decoration: InputDecoration(
          hintText: hintLabel,
          hintStyle: TextStyle(
            color: AppColors.greyText,
            fontSize: 16,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.greyBorder,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.greyBorder,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

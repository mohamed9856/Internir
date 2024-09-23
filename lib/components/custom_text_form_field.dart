import 'package:flutter/material.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/utils/size_config.dart';

Widget customTextFormField({
  String? hintText,
  String? Function(String?)? validator,
  TextEditingController? controller,
  bool obscureText = false,
  TextInputType? keyboardType,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool readOnly = false,
  bool enabled = true,
  bool autofocus = false,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  void Function(String?)? onSaved,
  void Function()? onEditingComplete,
}) {
  return TextFormField(
    style: TextStyle(
      fontSize: 16 * SizeConfig.textRatio,
      fontFamily: 'Greta Arabic',
    ),
    decoration: InputDecoration(
      hintText: hintText,
      isDense: true, 

      contentPadding: EdgeInsets.symmetric(
        horizontal: 16 * SizeConfig.horizontalBlock,
        vertical: 12 * SizeConfig.verticalBlock,  
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      errorStyle: TextStyle(
        fontSize: 12 * SizeConfig.textRatio,
        fontFamily: 'Greta Arabic',
        color: AppColor.red,
      ),
      filled: true,
      fillColor: AppColor.lightblue.withOpacity(.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    validator: validator,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    readOnly: readOnly,
    enabled: enabled,
    autofocus: autofocus,
    onChanged: onChanged,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    onSaved: onSaved,
    onEditingComplete: onEditingComplete,
  );
}

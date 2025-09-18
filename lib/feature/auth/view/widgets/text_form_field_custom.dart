import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? Function(String?)? validate;
  final TextInputType? type;
  final bool isPassword;
  final String text;
  final IconData? icon;
  final IconData iconPre;
  final void Function()? isIconClicked;
  final TextEditingController controller;
  const TextFormFieldCustom({
    super.key,
    this.validate,
    this.type,
    required this.isPassword,
    required this.text,
    this.icon,
    required this.iconPre,
    this.isIconClicked, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: icon != null ? InkWell(onTap: isIconClicked,child: Icon(icon),): null,
        prefixIcon: Icon(iconPre),
      ),
    );
  }
}

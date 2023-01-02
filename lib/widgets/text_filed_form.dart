import 'package:flutter/material.dart';

class TextFiledForm extends StatelessWidget {
  final String label;
  final bool obscureText;

  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  TextFiledForm(
      {Key? key,
      required this.label,
      required this.textInputType,
      required this.controller,
      this.obscureText = false,
      this.suffixIcon,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${label}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: textInputType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.all(15),
            labelText: '${label}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.amber, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.amber, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.amber, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          validator: validator,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

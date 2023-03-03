import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  String? Function(String?)? validate;
  void Function(String?)? onChange;
  final TextInputType? keyboardType;
  TextEditingController? textController;
  Widget? suffixIcon;
  CustomTextField(
      {super.key,
      this.labelText,
      this.keyboardType,
      this.validate,
      this.onChange,
      this.suffixIcon,
      this.textController,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Color.fromARGB(255, 29, 77, 100).withAlpha(40),
      child: TextFormField(
        style: TextStyle(
          color: Color.fromARGB(255, 27, 26, 26),
        ),
        controller: textController,
        onChanged: onChange,
        validator: validate,
        autofocus: true,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  width: 2, color: Color.fromARGB(255, 216, 216, 216))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  width: 2, color: Color.fromARGB(255, 216, 216, 216))),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 76, 139, 78),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

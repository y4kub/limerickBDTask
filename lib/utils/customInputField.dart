import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController edtController;
  final String labelText;
  TextInputType inputType = TextInputType.text;
  bool isPassword=false;
  CustomInputField({required this.edtController, super.key, this.isPassword=false, this.inputType= TextInputType.text, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: edtController,
        obscureText: isPassword,
        keyboardType: inputType,
        autofocus: false,
        decoration: InputDecoration(
          label: Text(labelText),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

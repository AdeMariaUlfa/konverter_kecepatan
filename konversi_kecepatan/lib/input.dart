// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    @required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: inputController,
        decoration: const InputDecoration(
            focusColor: Colors.black,
            filled: true,
            fillColor: Colors.white,
            labelText: "masukkan nilai"),
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+\.]')),
        ],
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false));
  }
}

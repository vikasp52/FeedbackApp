import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  TextEditingController controller;
  String hintText;
  TextInputType keyboardType;
  Widget prefixIcon;
  ValueChanged<String> onChanged;
  bool enable;
  int maxLength;
  Stream stream;


  TextFieldWidget({this.controller,this.maxLength, this.hintText, this.keyboardType, this.enable=true, this.prefixIcon, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            controller: controller,
            enabled: enable,
            onChanged: onChanged,
            maxLength: maxLength,
            keyboardType: keyboardType??TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: prefixIcon,
                filled: true,
                fillColor: Colors.white,
                errorText: snapshot.error,
                hintText: hintText),
          );
        }
      ),
    );
  }
}

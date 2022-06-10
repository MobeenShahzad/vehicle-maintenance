import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/components/text_field_container.dart';

class RectInputFields extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const RectInputFields({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Builder(builder: (context) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        );
      }),
    );
  }
}

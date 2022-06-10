import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/components/text_field_container.dart';

class RoundedInputFields extends StatelessWidget {
  final String hintText;
  final IconData icons;
  final ValueChanged<String> onChanged;

  const RoundedInputFields({
    Key? key,
    required this.hintText,
    this.icons = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Builder(builder: (context) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Icon(
              icons,
              color: Colors.black,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        );
      }),
    );
  }
}

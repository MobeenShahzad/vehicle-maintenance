import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      onChanged: onChanged,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        icon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: Colors.black,
        ),
        border: InputBorder.none,
      ),
    ));
  }
}

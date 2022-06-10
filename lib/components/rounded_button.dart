import 'package:flutter/material.dart';

class rounded_button extends StatelessWidget {
  final String text;
  final press;
  final color, textColor;
  const rounded_button({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}

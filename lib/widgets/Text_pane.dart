import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Text_pane extends StatelessWidget {
  final String text;

  final Color color;
  final double fontSize;
  // final IconData icon;

  Text_pane({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        // backgroundColor: Colors.black45,
        color: color,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButtonmenu extends StatelessWidget {
  final String title;
  final Function() onPressed;

  final Color colorButton;
  final TextStyle textStyle;
  CustomButtonmenu({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.colorButton,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: 180,
          height: 60,
          child: Container(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: textStyle,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.white,
                shadowColor: Colors.grey,
                elevation: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final int oo = 0;

  final Color colorButton;
  final TextStyle textStyle;
  const CustomButton({
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
          width: 342,
          height: 45,
          child: Container(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: textStyle,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
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

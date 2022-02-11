import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final int oo = 0;

  final Color colorButton;
  final TextStyle textStyle;
  CustomButton({
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
          height: 55,
          child: Container(
            child: ElevatedButton(
              onPressed: onPressed,
              child: LocaleText(
                title,
                style: textStyle,
              ),
              style: ElevatedButton.styleFrom(
                primary: colorButton,
                onPrimary: Colors.white,
                shadowColor: Colors.grey[700],
                elevation: 30,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

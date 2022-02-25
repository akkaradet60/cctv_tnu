import 'package:cctv_tun/page/global/style/global.dart';
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
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.transparent,
        width: 342,
        height: 55,
        child: Container(
          decoration: BoxDecoration(
              color: ThemeBc.black,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
              ]),
          child: ElevatedButton(
            onPressed: onPressed,
            child: LocaleText(
              title,
              style: textStyle,
            ),
            style: ElevatedButton.styleFrom(
              primary: colorButton,

              // shadowColor: Colors.grey[700],
              elevation: 30,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ),
      ),
    );
  }
}

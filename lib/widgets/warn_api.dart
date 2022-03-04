import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

class warn_api extends StatelessWidget {
  final String title;
  final String title2;

  warn_api({
    Key? key,
    required this.title,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeBc.white,
      // shape: CircleBorder(),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocaleText(
                title,
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.textblack,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          // LocaleText(
          //   title2,
          //   style: TextStyle(
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //     // backgroundColor: Colors.black45,
          //     color: ThemeBc.white,
          //   ),
          // ),
        ),
      ),
    );
  }
}

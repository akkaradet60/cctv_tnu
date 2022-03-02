import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class MenusCustom extends StatelessWidget {
  final String iconMenus;
  final String titleMenus;

  final String titleMenus1;
  final String titleMenus2;
  final int ss = 0;
  final Function() pathName;
  MenusCustom({
    Key? key,
    required this.iconMenus,
    required this.titleMenus,
    required this.titleMenus1,
    required this.titleMenus2,
    required this.pathName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
        children: [
          NeumorphicButton(
            onPressed: pathName,
            style: const NeumorphicStyle(
              // shadowDarkColor: ThemeBc.black,
              shadowLightColor: ThemeBc.black54,
              // shadowDarkColorEmboss: ThemeBc.black,
              // shadowLightColorEmboss: ThemeBc.black,

              shape: NeumorphicShape.flat,
              // boxShape:
              //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
              boxShape: NeumorphicBoxShape.circle(),
              color: ThemeBc.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconMenus,
                  width: 60,
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: 90,
            height: 20,
            child: ListView(
              children: [
                Column(
                  // shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  children: [
                    LocaleText(
                      titleMenus,
                      style: GoogleFonts.sarabun(
                        textStyle: TextStyle(
                          color: ThemeBc.textblack,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(titleMenus1),
        ],
      ),
    );
  }
}

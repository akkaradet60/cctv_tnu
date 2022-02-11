import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

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
      child: InkWell(
        onTap: pathName,
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  color: secondaryTextColor,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 7,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 4),
                        blurRadius: 7.0,
                        spreadRadius: 1.0),
                  ]),
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
            LocaleText(
              titleMenus,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.black45,
                color: Colors.white,
              ),
            ),
            Text(titleMenus1),
          ],
        ),
      ),
    );
  }
}

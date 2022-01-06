import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';

class MenusCustom extends StatelessWidget {
  final String iconMenus;
  final String titleMenus;
  final String pathName;
  final String titleMenus1;
  final String titleMenus2;
  final int ss = 0;

  const MenusCustom({
    Key? key,
    required this.iconMenus,
    required this.titleMenus,
    required this.pathName,
    required this.titleMenus1,
    required this.titleMenus2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, pathName),
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  color: secondaryTextColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 7,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 4),
                        blurRadius: 7.0,
                        spreadRadius: 1.0),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconMenus,
                    width: 50,
                  )
                ],
              ),
            ),
            SizedBox(height: 12),
            Text(titleMenus),
            Text(titleMenus1),
          ],
        ),
      ),
    );
  }
}

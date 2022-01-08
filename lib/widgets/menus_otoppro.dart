import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';

class MenusCustom2 extends StatelessWidget {
  final String iconMenus;
  final String titleMenus;
  final String pathName;
  final String titleMenus1;
  final String titleMenus2;

  const MenusCustom2({
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
      margin: EdgeInsets.only(top: 20, bottom: 0),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, pathName),
            child: Row(
              children: [
                Container(
                  height: 400,
                  width: 365,
                  decoration: BoxDecoration(
                      color: secondaryTextColor,
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.redAccent],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.circular(
                        24,
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
                      Column(
                        children: [
                          Image.network(
                            iconMenus,
                            width: 200,
                          ),
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                          Container(
                            width: 340,
                            child: Column(
                              children: [
                                Text(
                                  titleMenus,
                                  style: primaryTextStyle.copyWith(
                                      fontSize: 18, fontWeight: medium),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  titleMenus1,
                                  style: primaryTextStyle.copyWith(
                                      fontSize: 20, fontWeight: medium),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                // Text(titleMenus),
                // Text(titleMenus1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

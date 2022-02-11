import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

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
      shape: CircleBorder(),
      // shape: RoundedRectangleBorder(
      //     borderRadius:
      //         new BorderRadius.circular(
      //             30)),
      content: Container(
        child: Container(
          decoration: BoxDecoration(
              color: ThemeBc.black,
              borderRadius: BorderRadius.circular(
                30,
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
          width: 350,
          height: 140,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 100,
                  child: ListView(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            LocaleText(
                              title,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                // backgroundColor: Colors.black45,
                                color: ThemeBc.white,
                              ),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

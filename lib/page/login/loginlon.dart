import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cctv_tun/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/style/global.dart';

class loginlon extends StatefulWidget {
  loginlon({Key? key}) : super(key: key);

  @override
  State<loginlon> createState() => _loginlonState();
}

class _loginlonState extends State<loginlon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: ThemeBc.green05,
          splash: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/logo02.png')),
                  Text(
                    'เทศบาลพระลับสวัสดีครับ',
                    style: GoogleFonts.sarabun(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // decoration: TextDecoration.underline,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // backgroundColor: ThemeBc.green05,
          duration: 3000,
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: home_page()),
    );
  }
}

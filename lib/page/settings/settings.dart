import 'package:cctv_tun/generated/languageS.dart';
import 'package:cctv_tun/generated/locale_keys.g.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/menu/manu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_signin_button/button_builder.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  // theme: ThemeData(
  //     //     primarySwatch: Colors.grey,
  //     //     canvasColor: Colors.white,
  //     //     scaffoldBackgroundColor: Colors.white),

  //       //   '/messagem2': (context) => messagem2()
  //     },
  //   );

  @override
  Widget build(context) {
    Widget imageSplash() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 10,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const SizedBox(height: 18),
              LocaleText(
                "ตั้งค่าข้อมูล",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.black45,
                  color: ThemeBc.black,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                child: Column(
                  children: [
                    // Container(
                    //   width: 342,
                    //   height: 55,
                    //   child: ElevatedButton.icon(
                    //     onPressed: () =>
                    //         Navigator.pushNamed(context, '/settingshop'),
                    //     icon: const Icon(Icons.shopping_bag),
                    //     label: LocaleText(
                    //       "ร้านค้า",
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //       primary: ThemeBc.background,
                    //       onPrimary: Colors.white,
                    //       shadowColor: Colors.grey[700],
                    //       elevation: 30,
                    //       shape: const RoundedRectangleBorder(
                    //           borderRadius:
                    //               const BorderRadius.all(Radius.circular(40))),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 5),

                    Container(
                      width: 390,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      color: Colors.transparent,
                      child: Expanded(
                        child: ElevatedButton.icon(
                          label: LocaleText(
                            'ข้อตกลงและเงื่อนไข',
                            style: TextStyle(
                              fontSize: 15.0,

                              // backgroundColor: Colors.black45,
                              color: ThemeBc.textblack,
                            ),
                          ),
                          icon: Icon(
                            Icons.fact_check,
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: ThemeBc.white,
                            //side: BorderSide(color: Colors.red, width: 5),
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.all(17),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/settingpolicy');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Container(
                      width: 390,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      color: Colors.transparent,
                      child: Expanded(
                        child: ElevatedButton.icon(
                          label: LocaleText(
                            'แก้ไขข้อมูลส่วนตัว',
                            style: TextStyle(
                              fontSize: 15.0,

                              // backgroundColor: Colors.black45,
                              color: ThemeBc.textblack,
                            ),
                          ),
                          icon: Icon(
                            Icons.account_box,
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: ThemeBc.white,
                            //side: BorderSide(color: Colors.red, width: 5),
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.all(17),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/settingprofile');
                          },
                        ),
                      ),
                    ),
                    // SignInButtonBuilder(
                    //   height: 45,
                    //   width: 300,
                    //   text: 'แก้ไขข้อมูลส่วนตัว',
                    //   icon: Icons.account_box,
                    //   onPressed: () =>
                    //       Navigator.pushNamed(context, '/settingprofile'),
                    //   backgroundColor: Colors.blueGrey[700]!,
                    // ),
                    // SignInButtonBuilder(
                    //   height: 45,
                    //   width: 300,
                    //   text: 'ข้อตกลงและเงื่อนไข',
                    //   icon: Icons.view_headline,
                    //   onPressed: () =>
                    //       Navigator.pushNamed(context, '/settingpolicy'),
                    //   backgroundColor: Colors.blueGrey[700]!,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget text2() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          margin: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              const SizedBox(height: 18),

              const LocaleText(
                "ตั้งค่า",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.black45,
                  color: ThemeBc.black,
                ),
              ),
              const SizedBox(height: 5),

              Container(
                width: 390,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                color: Colors.transparent,
                child: Expanded(
                  child: ElevatedButton.icon(
                    label: LocaleText(
                      'เปลี่ยนภาษา',
                      style: TextStyle(
                        fontSize: 15.0,

                        // backgroundColor: Colors.black45,
                        color: ThemeBc.textblack,
                      ),
                    ),
                    icon: Icon(
                      Icons.spellcheck,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ThemeBc.white,
                      //side: BorderSide(color: Colors.red, width: 5),
                      textStyle: TextStyle(fontSize: 15),
                      padding: EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30)),
                            // shape: CircleBorder(
                            //     side: BorderSide
                            //         .none),
                            // elevation: 100,
                            content: Container(
                              height: 180,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          LocaleNotifier.of(context)!
                                              .change('th');
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home_page',
                                              (route) => false);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            color: ThemeBc.background,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ภาษาไทย',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.textwhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          LocaleNotifier.of(context)!
                                              .change('en');
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home_page',
                                              (route) => false);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            color: ThemeBc.background,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'English',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.textwhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          LocaleNotifier.of(context)!
                                              .change('zh');
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home_page',
                                              (route) => false);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            color: ThemeBc.background,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                '中国',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.textwhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 390,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                color: Colors.transparent,
                child: Expanded(
                  child: ElevatedButton.icon(
                    label: LocaleText(
                      'แก้ไขรหัสผ่าน',
                      style: TextStyle(
                        fontSize: 15.0,

                        // backgroundColor: Colors.black45,
                        color: ThemeBc.textblack,
                      ),
                    ),
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ThemeBc.white,
                      //side: BorderSide(color: Colors.red, width: 5),
                      textStyle: TextStyle(fontSize: 15),
                      padding: EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/fix_password');
                    },
                  ),
                ),
              ),

              // SignInButtonBuilder(
              //   height: 45,
              //   width: 300,
              //   text: 'เปลี่ยนภาษา',
              //   icon: Icons.spellcheck,
              //   onPressed: () {},
              //   backgroundColor: Colors.blueGrey[700]!,
              // ),
              // SignInButtonBuilder(
              //   height: 45,
              //   width: 300,
              //   text: 'แก้ไขรหัสผ่าน',
              //   icon: Icons.vpn_key,
              //   onPressed: () {},
              //   backgroundColor: Colors.blueGrey[700]!,
              // ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: menu_pang(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: const Center(
          child: LocaleText(
            "ตั้งค่า",
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: const LinearGradient(
              colors: [ThemeBc.orangeAccent, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              imageSplash(),
              text2(),
            ],
          ),
        ),
      ),
    );
  }
}

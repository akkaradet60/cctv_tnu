import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/menu/manu.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'Language/LanguageTH.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     // theme: ThemeData(
  //     //     primarySwatch: Colors.grey,
  //     //     canvasColor: Colors.pinkAccent,
  //     //     scaffoldBackgroundColor: Colors.pinkAccent),

  //       //   '/messagem2': (context) => messagem2()
  //     },
  //   );

  @override
  Widget build(BuildContext context) {
    Widget imageSplash() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: secondaryTextColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 4),
                    blurRadius: 7.0,
                    spreadRadius: 1.0),
              ]),
          height: 280,
          width: 10,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                LocaleKeys.this_should_be_translated.tr(),
              ),
              const SizedBox(height: 18),
              const Text(
                'ข้อมูล',
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
                    Container(
                      width: 342,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settingshop'),
                        icon: const Icon(Icons.shopping_bag),
                        label: const Text('ร้านค้า'),
                        style: ElevatedButton.styleFrom(
                          primary: ThemeBc.background,
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey[700],
                          elevation: 30,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 342,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settingpolicy'),
                        icon: const Icon(Icons.account_box),
                        label: const Text('ข้อตกลงและเงื่อนไข'),
                        style: ElevatedButton.styleFrom(
                          primary: ThemeBc.background,
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey[700],
                          elevation: 30,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 342,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settingprofile'),
                        icon: const Icon(Icons.account_box),
                        label: const Text('แก้ไขข้อมูลส่วนตัว'),
                        style: ElevatedButton.styleFrom(
                          primary: ThemeBc.background,
                          onPrimary: Colors.white,
                          shadowColor: Colors.grey[700],
                          elevation: 30,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
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
          decoration: BoxDecoration(
              color: secondaryTextColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 4),
                    blurRadius: 7.0,
                    spreadRadius: 1.0),
              ]),
          height: 200,
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const SizedBox(height: 18),
              const Text(
                'ตั้งค่า',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.black45,
                  color: ThemeBc.black,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 342,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: CircleBorder(),
                          // elevation: 100,
                          content: Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                color: ThemeBc.background,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(2, 2),
                                      blurRadius: 7,
                                      spreadRadius: 1.0),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(2, 4),
                                      blurRadius: 7.0,
                                      spreadRadius: 1.0),
                                ]),
                            child: ListView(
                              children: [
                                SizedBox(height: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await context.setLocale(Locale('th'));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: ThemeBc.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 7.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              'ภาษาไทย',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        await context.setLocale(Locale('en'));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: ThemeBc.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 7.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              'English',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        await context.setLocale(Locale('ch'));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: ThemeBc.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(2, 4),
                                                  blurRadius: 7.0,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              '中国',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.black,
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
                  icon: const Icon(Icons.spellcheck),
                  label: const Text('เปลี่ยนภาษา'),
                  style: ElevatedButton.styleFrom(
                    primary: ThemeBc.background,
                    onPrimary: Colors.white,
                    shadowColor: Colors.grey[700],
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 342,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/fix_password'),
                  icon: const Icon(Icons.vpn_key),
                  label: const Text('แก้ไขรหัสผ่าน'),
                  style: ElevatedButton.styleFrom(
                    primary: ThemeBc.background,
                    onPrimary: Colors.white,
                    shadowColor: Colors.grey[700],
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(40))),
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
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: const Center(child: Text('ตั้งค่า')),
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
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              MaterialApp(
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
              ),
              imageSplash(),
              text2(),
            ],
          ),
        ),
      ),
    );
  }
}

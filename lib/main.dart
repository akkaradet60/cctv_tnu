import 'package:cctv_tun/page/home_page/home_page.dart';
import 'package:cctv_tun/page/login_apply_page/confirm_email/confirmemail.dart';

import 'package:cctv_tun/page/login_apply_page/login.page.dart';
import 'package:cctv_tun/page/login_apply_page/register_pe.dart';
import 'package:cctv_tun/page/login_apply_page/register_page.dart';
import 'package:cctv_tun/page/otoproducts/productshome_page.dart';

import 'package:cctv_tun/page/otoproducts/products_page.dart';
import 'package:cctv_tun/page/otoproducts/productshop_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token')!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Colors.pink[400],
      ),
      routes: {
        '/': (context) => token == null ? login_page() : home_page(),
        '/confirmemail': (context) => confirmemail(),
        '/home_page': (context) => home_page(), //home_page
        '/register_page': (context) => register_page(),
        '/RegisterPage': (context) => RegisterPage(),
        '/login_page': (context) => login_page(),
        '/products_page': (context) => products_page(),
        '/productshop_page': (context) => productshop_page(),
        '/productshome_page': (context) => productshome_page(),
      },
    );
  }
}

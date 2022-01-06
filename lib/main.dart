import 'package:cctv_tun/page/home_page/home_page.dart';
import 'package:cctv_tun/page/login_apply_page/confirm_email/confirmemail.dart';
import 'package:cctv_tun/page/login_apply_page/login.page.dart';
import 'package:cctv_tun/page/login_apply_page/register_page.dart';
import 'package:cctv_tun/page/login_apply_page/register_png.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
        '/': (context) => login_page(),
        '/confirmemail': (context) => confirmemail(),
        '/home_page': (context) => home_page(), //home_page
        '/register_page': (context) => register_page(),
        '/RegisterPage': (context) => RegisterPage()
      },
    );
  }
}

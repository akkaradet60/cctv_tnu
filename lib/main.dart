import 'package:cctv_tun/page/home_page/home_page.dart';
import 'package:cctv_tun/page/login_apply_page/confirm_email/confirmemail.dart';

import 'package:cctv_tun/page/login_apply_page/login.page.dart';
import 'package:cctv_tun/page/login_apply_page/register_pe.dart';
import 'package:cctv_tun/page/login_apply_page/register_page.dart';
import 'package:cctv_tun/page/map/map_page%20copy%202.dart';

import 'package:cctv_tun/page/map/map_page.dart';
import 'package:cctv_tun/page/otoproducts/probestseller_page.dart';
import 'package:cctv_tun/page/otoproducts/productshome_page.dart';

import 'package:cctv_tun/page/otoproducts/products_page.dart';
import 'package:cctv_tun/page/otoproducts/productshop_page.dart';
import 'package:cctv_tun/page/otoproducts/propopular_page.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/hotline/hotline_page.dart';
import 'package:cctv_tun/page/warn/warn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

var token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  final myStore = Store<AppState>(appReducer, initialState: AppState.initial());

  runApp(MyApp(store: myStore));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({Key? key, required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
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
          '/probestseller_page': (context) => probestseller_page(),
          '/propopular_page': (context) => propopular_page(),
          '/map_page': (context) => map_page(),
          '/map_page1': (context) => map_page1(),
          '/warn_page': (context) => warn_page(),
          '/hotline_page': (context) => hotline_page(),
        },
      ),
    );
  }
}

import 'package:cctv_tun/page/Manual/Manual_page.dart';
import 'package:cctv_tun/page/award/award_page.dart';
import 'package:cctv_tun/page/award/awarddetail_page.dart';
import 'package:cctv_tun/page/compose/compose_page.dart';

import 'package:cctv_tun/page/home_page/home_page.dart';
import 'package:cctv_tun/page/hotlinee/hotlinee_page%20copy.dart';
import 'package:cctv_tun/page/hotlinee/hotlinee_page.dart';
import 'package:cctv_tun/page/login_apply_page/confirm_email/confirmemail.dart';

import 'package:cctv_tun/page/login_apply_page/login.page.dart';

import 'package:cctv_tun/page/login_apply_page/register_page.dart';

import 'package:cctv_tun/page/map/map_page.dart';
import 'package:cctv_tun/page/message/messagem_page.dart';
import 'package:cctv_tun/page/message/messagemdetail_page.dart';
import 'package:cctv_tun/page/oobk.dart';

import 'package:cctv_tun/page/otoproducts/probestseller_page.dart';

import 'package:cctv_tun/page/otoproducts/productshome_page.dart';

import 'package:cctv_tun/page/otoproducts/products_page.dart';
import 'package:cctv_tun/page/otoproducts/productshop_page.dart';
import 'package:cctv_tun/page/otoproducts/propopular_page.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';

import 'package:cctv_tun/page/trainingcalendar/oi.dart';
import 'package:cctv_tun/page/trainingcalendar/trainingcalendardetail_page.dart';
import 'package:cctv_tun/page/trainingcalendar/trainingcalendar.dart';
import 'package:cctv_tun/page/travel/messagemdetail_page.dart';
import 'package:cctv_tun/page/travel/travel_page.dart';
import 'package:cctv_tun/page/travel/travelmap_page.dart';
import 'package:cctv_tun/page/warn/warn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

var filePath;
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
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.pink,
              // canvasColor: Colors.pinkAccent,
              scaffoldBackgroundColor: Colors.pinkAccent),
          routes: {
            '/': (context) => token == null ? login_page() : home_page(),
            '/confirmemail': (context) => confirmemail(),
            '/home_page': (context) => home_page(), //home_page
            '/register_page': (context) => register_page(),
            '/messagemdetail_page': (context) => messagemdetail_page(),
            '/login_page': (context) => login_page(),
            '/products_page': (context) => products_page(),
            '/productshop_page': (context) => productshop_page(),
            '/productshome_page': (context) => productshome_page(),
            '/probestseller_page': (context) => probestseller_page(),
            '/propopular_page': (context) => propopular_page(),
            '/map_page': (context) => map_page(),
            // '/map_page1': (context) => map_page1(),
            '/warn_page': (context) => warn_page(),
            '/compose_page': (context) => compose_page(),
            '/ProductPage': (context) => products_page(),
            '/hotlinee_page': (context) => hotlinee_page(),
            '/hotlinee_page1': (context) => hotlinee_page1(),
            '/Manual_page': (context) => manual_page(),
            // '/Manual_page1': (context) => manual_page1(),
            '/message_page': (context) => message_page(),
            '/award_page': (context) => award_page(),
            '/awarddetail_page': (context) => awarddetail_page(),
            '/trainingcalendar_page': (context) => trainingcalendar_page(),
            '/travel_page': (context) => travel_page(),
            '/travelmap_page': (context) => travelmap_page(),
            '/trainingcalendardetail_page': (context) =>
                trainingcalendardetail_page(),
            //   '/messagem2': (context) => messagem2()
          },
        ),
      ),
    );
  }
}

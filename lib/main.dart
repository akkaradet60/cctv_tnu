import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cctv_tun/generated/languageS.dart';
import 'package:cctv_tun/page/Manual/Manual_page.dart';
import 'package:cctv_tun/page/appp/appp.dart';
import 'package:cctv_tun/page/award/award_page.dart';
import 'package:cctv_tun/page/award/awarddetail_page.dart';
import 'package:cctv_tun/page/cctv/cctv_page.dart';
import 'package:cctv_tun/page/compose/compose_page.dart';
import 'package:cctv_tun/page/compose/composedetail_page.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/home/home_page.dart';
import 'package:cctv_tun/page/hotline/hotlinee_page.dart';
import 'package:cctv_tun/page/location/location_page.dart';
import 'package:cctv_tun/page/login/facebook_login.dart';
import 'package:cctv_tun/page/login/forgot_password.dart';

import 'package:cctv_tun/page/login/login.page.dart';
import 'package:cctv_tun/page/login/register_page.dart';
import 'package:cctv_tun/page/map/map_page.dart';
import 'package:cctv_tun/page/map/map_prod.dart';
import 'package:cctv_tun/page/map/maplocation_page.dart';
import 'package:cctv_tun/page/message/messagem_page%20copy.dart';

import 'package:cctv_tun/page/message/messagem_page.dart';
import 'package:cctv_tun/page/message/messagemdetail_page.dart';
import 'package:cctv_tun/page/otoproducts/productsearchome.dart';
import 'package:cctv_tun/page/otoproducts/productsearchstore_page.dart';

import 'package:cctv_tun/page/otoproducts/productshome_page.dart';

import 'package:cctv_tun/page/otoproducts/productshop_page.dart';
import 'package:cctv_tun/page/otoproducts/productsearch_page.dart';

import 'package:cctv_tun/page/otoproducts/productstorehome.dart';

import 'package:cctv_tun/page/profile/app_reducer.dart';

import 'package:cctv_tun/page/settings/fix_password.dart';
import 'package:cctv_tun/page/settings/settingpolicy.dart';
import 'package:cctv_tun/page/settings/settingpro.dart';
import 'package:cctv_tun/page/settings/settingprodot.dart';
import 'package:cctv_tun/page/settings/settingprofile.dart';
import 'package:cctv_tun/page/settings/settings.dart';
import 'package:cctv_tun/page/settings/settingshop.dart';
import 'package:cctv_tun/page/settings/sss.dart';

import 'package:cctv_tun/page/trainingcalendar/trainingcalendardetail_page.dart';
import 'package:cctv_tun/page/trainingcalendar/trainingcalendar.dart';

import 'package:cctv_tun/page/travel/travel_page.dart';
import 'package:cctv_tun/page/travel/travelhome_page.dart';
import 'package:cctv_tun/page/travel/travelmapS_page.dart';
import 'package:cctv_tun/page/travel/travelmap_page.dart';
import 'package:cctv_tun/page/warn/warn_page.dart';
import 'package:cctv_tun/page/warn/warndetail_page.dart';
import 'package:cctv_tun/widgets/verify_email_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

var token;
final myStore = Store<AppState>(appReducer, initialState: AppState.initial());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['th', 'zh', 'en']);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'poro',
      channelDescription: 'not',
      defaultColor: ThemeBc.black,
      ledColor: ThemeBc.white,
      playSound: true,
      enableLights: true,
      enableVibration: true,
    )
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  runApp(
    MyApp(store: myStore),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({Key? key, required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,

          // theme: ThemeData(
          //     primarySwatch: Colors.grey,
          //     canvasColor: Colors.white,
          //     scaffoldBackgroundColor: Colors.white),
          routes: {
            '/': (context) => token == null
                ? login_page()
                : Global.app_id == "1"
                    ? home_page()
                    : Verify(),
            '/appppp': (context) => appp(),
            // '/': (context) => token == null ? login_page() : home_page(),
            '/fix_password': (context) => fix_password(),
            // '/sss': (context) => EmergecyPage(),
            '/map_prod': (context) => map_prod(),
            '/productstore_page': (context) => productstore_page(),
            //  '/confirmemail': (context) => confirmemail(),
            '/home_page': (context) => home_page(), //home_page
            '/register_page': (context) => register_page(),
            '/messagemdetail_page': (context) => messagemdetail_page(),
            '/login_page': (context) => login_page(),
            // '/products_page': (context) => products_page(),
            '/productshop_page': (context) => productshop_page(),
            '/productshome_page': (context) => productshome_page(),
            // '/probestseller_page': (context) => probestseller_page(),
            // '/propopular_page': (context) => propopular_page(),
            '/map_page': (context) => map_page(),
            '/composedetail_page': (context) => composedetail_page(),
            // '/warndetail_pang': (context) => warndetail_pang(),
            // '/map_page1': (context) => map_page1(),
            '/warn_page': (context) => warn_page(),
            '/compose_page': (context) => compose_page(),
            // '/ProductPage': (context) => products_page(),
            '/hotlinee_page': (context) => hotlinee_page(),
            //  '/hotlinee_page1': (context) => hotlinee_page1(),
            '/Manual_page': (context) => manual_page(),
            // '/Manual_page1': (context) => manual_page1(),
            '/message_page': (context) => message_page(),
            '/message_page01': (context) => message_page01(),
            '/award_page': (context) => award_page(),
            '/awarddetail_page': (context) => awarddetail_page(),
            '/trainingcalendar_page': (context) => trainingcalendar_page(),
            '/travel_page': (context) => travel_page(),
            '/travelmap_page': (context) => travelmap_page(),
            '/travelmapS_page': (context) => travelmapS_page(),
            '/trainingcalendardetail_page': (context) =>
                trainingcalendardetail_page(),
            '/location_page': (context) => location_page(),
            '/cctv_page': (context) => cctv_page(),
            '/settingpro': (context) => settingpro(),
            '/settingprodot': (context) => settingprodot(),
            '/settingprofile': (context) => settingprofile(),
            '/settings': (context) => settings(),
            '/settingshop': (context) => settingshop(),
            '/maplocation_page': (context) => maplocation_page(),
            '/settingpolicy': (context) => settingpolicy(),
            // '/EmergecyPage': (context) => EmergecyPage(),
            '/sss': (context) => sss(),
            '/facebook_login': (context) => facebook_login(),
            '/forgot_password': (context) => forgot_password(),
            '/appp': (context) => appp(),
            '/warndetail_page': (context) => warndetail_page(),
            '/productsearchstore_page': (context) => productsearchstore_page(),

            '/productsearchome': (context) => produsctsearchome(),
            '/productstorehome': (context) => productstorehome(),
            '/travelhome_page': (context) => travelhome_page(),
          },
        ),
      ),
    );
  }
}

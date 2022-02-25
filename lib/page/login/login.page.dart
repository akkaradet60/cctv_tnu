import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/login/action.dart';

import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:cctv_tun/widgets/custom_buttonn.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<login_page> {
  Future<void> loginSocial(Map formValues) async {
    print(formValues);
    // print(formValues);
    try {
      var url = Global.urlWeb + 'api/login/restful/';
      var response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
          },
          body: json.encode({
            "user_app_id": Global.app_id,
            "user_provider": '2',
            "user_firstname": formValues['name'],
            "user_image": formValues["picture"]["data"]["url"],
            "email": formValues['email'],
            "password": formValues['id']
          }));
      Map<String, dynamic> token = json.decode(response.body);
      print(token);
      // if (err['error']) {

      if (response.statusCode == 200 && token['message'] == "สำเร็จ") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.body);
        await prefs.setString('user_id', response.body);
        var profileUrl = Global.urlWeb +
            'api/profile/restful?user_id=${token['access_id']}&user_app_id=${Global.app_id}';
        var responseProfile = await http.get(Uri.parse(profileUrl),
            headers: {'Authorization': 'Bearer ${token['access_token']}'});
        var profile = json.decode(responseProfile.body);
        Map<String, dynamic> user =
            profile['data'][0]; // { id: 111, name: john ....}
        await prefs.setString('profile', jsonEncode(user));
        print('profile: $user');
        print(token['access_id']);
        var appUrl = Global.urlWeb +
            'api/app/application/restful/?app_id=${Global.app_id}';
        var responseApp = await http.get(Uri.parse(appUrl),
            headers: {'Authorization': 'Bearer ${token['access_token']}'});
        var application_data = json.decode(responseApp.body);
        Map<String, dynamic> app_data =
            application_data['data'][0]; // { id: 111, name: john ....}
        await prefs.setString('application', jsonEncode(app_data));
        //print(app_data);
        //Global.user_id = token['access_id'];
        print('app: $app_data');
        //user_id = token['access_id'];

        // print(Global.usi_id);
        // print(user_id);

        //get Profile
        /* var profileUrl = Uri.parse('https://api.codingthailand.com/api/profile');
      var responseProfile = await http.get(profileUrl,
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      Map<String, dynamic> profile = json.decode(responseProfile.body);
      var user = profile['data']['user']; // { id: 111, name: john ....}
      await prefs.setString('profile', json.encode(user));
      // print('profile: $user');
      print(token['message']);*/
        //กลับไปที่หน้า HomeStack
        Navigator.pushNamedAndRemoveUntil(
            context, '/home_page', (route) => false);
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return warn_api(
              title: '${token['message']}',
              title2: '',
            );
          },
        );
      }
    } catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return warn_api(
            title: 'เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง',
            title2: '',
          );
        },
      );
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) {
        FacebookAuth.instance.getUserData().then((userData) {
          print('userData => $userData');
          loginSocial(userData);
        });
      });
    } catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return warn_api(
            title: 'เกิดข้อผิดพลาดกครั้ง',
            title2: '',
          );
        },
      );
    }
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<void> loginapp() async {
    //formValues['name']
    //print(formValues);

    var url = Uri.parse(Global.urlWeb + 'api/login/restful');
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
        },
        body: json.encode({
          "user_app_id": Global.app_id,
          "email": 'gtx@nt.com',
          "password": '1234567'
        }));

    Map<String, dynamic> token = json.decode(response.body);
    var user_id = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);
      await prefs.setString('user_id', response.body);
      var profileUrl = Global.urlWeb +
          'api/profile/restful?user_id=${user_id['access_id']}&user_app_id=${Global.app_id}';
      var responseProfile = await http.get(Uri.parse(profileUrl),
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      var profile = json.decode(responseProfile.body);
      Map<String, dynamic> user =
          profile['data'][0]; // { id: 111, name: john ....}
      await prefs.setString('profile', jsonEncode(user));
      print('profile: $user');
      print(user_id['access_id']);
      var appUrl = Global.urlWeb +
          'api/app/application/restful/?app_id=${Global.app_id}';
      var responseApp = await http.get(Uri.parse(appUrl),
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      var application_data = json.decode(responseApp.body);
      Map<String, dynamic> app_data =
          application_data['data'][0]; // { id: 111, name: john ....}
      await prefs.setString('application', jsonEncode(app_data));
      //print(app_data);
      //Global.user_id = token['access_id'];
      print('app: $app_data');
      //user_id = token['access_id'];

      // print(Global.usi_id);
      // print(user_id);

      //get Profile
      /* var profileUrl = Uri.parse('https://api.codingthailand.com/api/profile');
      var responseProfile = await http.get(profileUrl,
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      Map<String, dynamic> profile = json.decode(responseProfile.body);
      var user = profile['data']['user']; // { id: 111, name: john ....}
      await prefs.setString('profile', json.encode(user));
      // print('profile: $user');
      print(token['message']);*/
      //กลับไปที่หน้า HomeStack
      Navigator.pushNamedAndRemoveUntil(
          context, '/home_page', (route) => false);

      // Navigator.pushNamed(context, '/home_page');
    } else {
      // Alert(
      //   context: context,
      //   type: AlertType.warning,
      //   // title: "แจ้งเตือน",
      //   desc: '${token['message']}',
      //   buttons: [
      //     DialogButton(
      //       child: Text(
      //         "ปิด",
      //         style: TextStyle(color: Colors.white, fontSize: 18),
      //       ),
      //       onPressed: () => Navigator.pop(context),
      //       gradient: LinearGradient(colors: [
      //         Color.fromRGBO(116, 116, 191, 1.0),
      //         Color.fromRGBO(52, 138, 199, 1.0),
      //       ]),
      //     )
      //   ],
      // ).show();
    }
  }

  Future<void> login(Map formValues) async {
    //formValues['name']
    //print(formValues);

    var url = Uri.parse(Global.urlWeb + 'api/login/restful');
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
        },
        body: json.encode({
          "user_app_id": Global.app_id,
          "email": formValues['email'],
          "password": formValues['password']
        }));

    Map<String, dynamic> token = json.decode(response.body);
    var user_id = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);
      await prefs.setString('user_id', response.body);
      var profileUrl = Global.urlWeb +
          'api/profile/restful?user_id=${user_id['access_id']}&user_app_id=${Global.app_id}';
      var responseProfile = await http.get(Uri.parse(profileUrl),
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      var profile = json.decode(responseProfile.body);
      Map<String, dynamic> user =
          profile['data'][0]; // { id: 111, name: john ....}
      await prefs.setString('profile', jsonEncode(user));
      print('profile: $user');
      print(user_id['access_id']);
      var appUrl = Global.urlWeb +
          'api/app/application/restful/?app_id=${Global.app_id}';
      var responseApp = await http.get(Uri.parse(appUrl),
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      var application_data = json.decode(responseApp.body);
      Map<String, dynamic> app_data =
          application_data['data'][0]; // { id: 111, name: john ....}
      await prefs.setString('application', jsonEncode(app_data));
      //print(app_data);
      //Global.user_id = token['access_id'];
      print('app: $app_data');
      //user_id = token['access_id'];

      // print(Global.usi_id);
      // print(user_id);

      //get Profile
      /* var profileUrl = Uri.parse('https://api.codingthailand.com/api/profile');
      var responseProfile = await http.get(profileUrl,
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      Map<String, dynamic> profile = json.decode(responseProfile.body);
      var user = profile['data']['user']; // { id: 111, name: john ....}
      await prefs.setString('profile', json.encode(user));
      // print('profile: $user');
      print(token['message']);*/
      //กลับไปที่หน้า HomeStack
      Navigator.pushNamedAndRemoveUntil(
          context, '/home_page', (route) => false);

      // Navigator.pushNamed(context, '/home_page');
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return warn_api(
            title: 'ใส่ข้อมูลให้ครบถ้วนหรือรหัสผ่านไม่ถูกต้อง',
            title2: '',
          );
        },
      );
      // Alert(
      //   context: context,
      //   type: AlertType.warning,
      //   // title: "แจ้งเตือน",
      //   desc: '${token['message']}',
      //   buttons: [
      //     DialogButton(
      //       child: Text(
      //         "ปิด",
      //         style: TextStyle(color: Colors.white, fontSize: 18),
      //       ),
      //       onPressed: () => Navigator.pop(context),
      //       gradient: LinearGradient(colors: [
      //         Color.fromRGBO(116, 116, 191, 1.0),
      //         Color.fromRGBO(52, 138, 199, 1.0),
      //       ]),
      //     )
      //   ],
      // ).show();
    }
  }

  var newProfile;
  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newProfile = json.decode(prefs.getString('profile').toString());
    //call redux action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('token');
    await prefs.remove('profile');
    //กลับไปที่หน้า Login
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  // var newProfile;
  // Future<void> getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   newProfile = json.decode(prefs.getString('profile').toString());
  //   //call redux action
  //   final store = StoreProvider.of<AppState>(context);
  //   store.dispatch(updateProfileAction(newProfile));
  // }

  @override
  void initState() {
    super.initState();
    getProfile;

    //getProfile();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = false;
    Map _userObj = {};
    return Scaffold(
        backgroundColor: ThemeBc.white,
        body: Stack(
          children: [
            Image.network(
              'http://4.bp.blogspot.com/-b5Ziev6W45k/VSqhWYDodcI/AAAAAAAARFI/OsRTia414fU/s1600/Y54_3009.jpg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10)),
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         colors: [ThemeBc.white, ThemeBc.white],
              //         begin: Alignment.topRight,
              //         end: Alignment.bottomLeft)),
              child: Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 80),
                            child: Image.asset('assets/logo.png'),
                          ),
                          SizedBox(height: 10),
                          FormBuilder(
                            key: _fbKey,
                            initialValue: {'email': '', 'password': ''},
                            autovalidateMode: AutovalidateMode
                                .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: FormBuilderTextField(
                                              initialValue:
                                                  'akkaradet.k6@snru.ac.th',
                                              name: "email",
                                              maxLines: 1,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                                suffixIcon: Icon(Icons.email),
                                                labelText: 'Email',
                                                // helperText: '555',
                                                fillColor: Colors.white,
                                                filled: true,
                                              ),
                                              // validator: MultiValidator([
                                              //   RequiredValidator(
                                              //       errorText:
                                              //           "ป้อนข้อมูลอีเมลด้วย"),
                                              //   EmailValidator(
                                              //       errorText:
                                              //           "รูปแบบอีเมล์ไม่ถูกต้อง"),
                                              // ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: secondaryTextColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: FormBuilderTextField(
                                              initialValue: '1234567',
                                              name: "password",
                                              maxLines: 1,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                                suffixIcon: Icon(Icons.vpn_key),
                                                labelText: 'Password',
                                                fillColor: Colors.white,
                                                filled: true,
                                              ),
                                              // validator: MultiValidator([
                                              //   RequiredValidator(
                                              //       errorText: "ป้อนรหัสผ่านด้วย"),
                                              // ]),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgot_password');
                                  }, //facebook_login
                                  child: LocaleText(
                                    'ลืมรหัสผ่าน',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 8.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                LocaleText(
                                  'ยังไม่ได้เป็นสมัครสมาชิก',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    /*shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 8.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],*/
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/register_page'),
                                  child: LocaleText(
                                    'สมัครสมาชิก',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
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
                          SizedBox(height: 10),
                          Container(
                            // color: Colors.transparent,
                            // margin: EdgeInsets.only(
                            //   top: 20,
                            // ),
                            child: CustomButton(
                              title: 'ล็อกอิน',
                              onPressed: () {
                                // login(_fbKey.currentState!.value);
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  // print(_fbKey.currentState!.value);
                                  login(_fbKey.currentState!.value);
                                }
                              },
                              colorButton: ThemeBc.background,
                              textStyle: secondaryTextStyle.copyWith(
                                  fontWeight: medium, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: CustomButton(
                              title: 'ทดลองใช้ในฐานะผู้เยี่ยมชม',
                              onPressed: () {
                                loginapp();
                              },
                              colorButton: ThemeBc.background,
                              textStyle: secondaryTextStyle.copyWith(
                                  fontWeight: medium, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 342,
                              decoration: BoxDecoration(
                                  color: ThemeBc.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(2, 2),
                                        blurRadius: 7,
                                        spreadRadius: 1.0),
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      label: const LocaleText('facebook'),
                                      icon: const Icon(Icons.facebook_rounded),
                                      style: ElevatedButton.styleFrom(
                                        primary: ThemeBc.blue,
                                        //side: BorderSide(color: Colors.red, width: 5),
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                        padding: const EdgeInsets.all(15),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        loginWithFacebook();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              width: 342,
                              decoration: BoxDecoration(
                                  color: ThemeBc.black,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(2, 2),
                                        blurRadius: 7,
                                        spreadRadius: 1.0),
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      label: const LocaleText('เปลี่ยนภาษา'),
                                      icon: const Icon(Icons.spellcheck),
                                      style: ElevatedButton.styleFrom(
                                        primary: ThemeBc.black,
                                        //side: BorderSide(color: Colors.red, width: 5),
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                        padding: const EdgeInsets.all(15),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30)),
                                              // shape: CircleBorder(),
                                              // elevation: 100,
                                              content: Container(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 20),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            LocaleNotifier.of(
                                                                    context)!
                                                                .change('th');
                                                            Navigator
                                                                .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    '/login_page',
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 250,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ThemeBc
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      offset:
                                                                          Offset(2,
                                                                              2),
                                                                      blurRadius:
                                                                          7,
                                                                      spreadRadius:
                                                                          1.0),
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: Text(
                                                                  'ภาษาไทย',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // backgroundColor: Colors.black45,
                                                                    color: ThemeBc
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        InkWell(
                                                          onTap: () {
                                                            LocaleNotifier.of(
                                                                    context)!
                                                                .change('en');
                                                            Navigator
                                                                .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    '/login_page',
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 250,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ThemeBc
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      offset:
                                                                          Offset(2,
                                                                              2),
                                                                      blurRadius:
                                                                          7,
                                                                      spreadRadius:
                                                                          1.0),
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: Text(
                                                                  'English',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // backgroundColor: Colors.black45,
                                                                    color: ThemeBc
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        InkWell(
                                                          onTap: () {
                                                            LocaleNotifier.of(
                                                                    context)!
                                                                .change('zh');
                                                            Navigator
                                                                .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    '/login_page',
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 250,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ThemeBc
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      offset:
                                                                          Offset(2,
                                                                              2),
                                                                      blurRadius:
                                                                          7,
                                                                      spreadRadius:
                                                                          1.0),
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: Text(
                                                                  '中国',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // backgroundColor: Colors.black45,
                                                                    color: ThemeBc
                                                                        .black,
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

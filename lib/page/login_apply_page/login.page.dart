import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<login_page> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<void> login(Map formValues) async {
    //formValues['name']
    //print(formValues);
    var url = Uri.parse('https://api.codingthailand.com/api/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": formValues['email'],
          "password": formValues['password']
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> token = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);

      //get Profile
      var profileUrl = Uri.parse('https://api.codingthailand.com/api/profile');
      var responseProfile = await http.get(profileUrl,
          headers: {'Authorization': 'Bearer ${token['access_token']}'});
      Map<String, dynamic> profile = json.decode(responseProfile.body);
      var user = profile['data']['user']; // { id: 111, name: john ....}
      await prefs.setString('profile', json.encode(user));
      // print('profile: $user');
      print(token['message']);
      //กลับไปที่หน้า HomeStack
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/home_page', (route) => false);
      Navigator.pushNamed(context, '/home_page');
    } else {
      Map<String, dynamic> err = json.decode(response.body);
      print(err['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  SizedBox(height: 10),
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
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                initialValue: 'ghame123@gmail.com',
                                name: "email",
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.email),
                                    hintText: 'อีเมล',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle: TextStyle(
                                        backgroundColor: Colors.white)),
                              ),
                              SizedBox(height: 5),
                              FormBuilderTextField(
                                initialValue: '123456',
                                name: "password",
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.security),
                                    hintText: 'Password',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle: TextStyle(
                                        backgroundColor: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Text('ลืมรหัสผ่าน',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'ลืม',
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 0,
                        ),
                        Text(
                          'ยังไม่ได้เป็นสมัครสมาชิก ?',
                          style: TextStyle(
                            fontFamily: 'sss',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, '/register_page'),
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sss',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            title: 'ล็อกอิน',
                            onPressed: () {
                              if (_fbKey.currentState!.saveAndValidate()) {
                                /// print(_formKey.currentState!.value);
                                login(_fbKey.currentState!.value);
                              }
                            },
                            colorButton: primaryColor,
                            textStyle: secondaryTextStyle.copyWith(
                                fontWeight: medium, fontSize: 16),
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 390,
                          height: 45,
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          color: Colors.transparent,
                          child: Container(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/about'),
                              icon:
                                  ImageIcon(AssetImage('assets/uif-u/01.png')),
                              label: Text('ล็อกอินด้วย facebook'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                onPrimary: Colors.white,
                                shadowColor: Colors.grey,
                                elevation: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    margin: EdgeInsets.only(top: 0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: 'ทดลองใช้ในฐานะผู้เยี่ยมชม',
                          onPressed: () =>
                              Navigator.pushNamed(context, '/home_page'),
                          colorButton: buttonGreyColor,
                          textStyle: secondaryTextStyle.copyWith(
                              fontWeight: medium, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

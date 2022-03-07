import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class register_page extends StatefulWidget {
  register_page({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<register_page> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<void> register(Map formValues) async {
    //formValues['name']
    //print(formValues);
    try {
      var url = Global.urlWeb + 'api/register/restful/${Global.app_id}';
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json"
      },
          // body: json.encode({
          //   "firstname": formValues['firstname'],
          //   "lastname": formValues['lastname'],
          //   "email": formValues['email'],
          //   "password": formValues['password']
          // }));
          body: {
            "user_app_id": Global.app_id,
            "user_card_id": formValues['user_card_id'],
            "user_firstname": formValues['firstname'],
            "user_lastname": formValues['lastname'],
            "user_email": formValues['email'],
            "user_pass": formValues['password']
          });
      Map<String, dynamic> feedback = json.decode(response.body);
      print(feedback);

      if (response.statusCode == 201) {
        Alert(
          context: context,
          // title: "แจ้งเตือน",
          type: AlertType.success,
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login_page'),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();

        //กลับไปที่หน้า LoginPage
        // Future.delayed(const Duration(seconds: 5), () {
        //   // Navigator.pop(context);
        //    Navigator.pop(context, '/login');
        // });
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          // title: "แจ้งเตือน",
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.green05, ThemeBc.green01],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [Colors.deepPurple, Colors.lightBlue],
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft)),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                LocaleText('ลงทะเบียน', style: TextStyle(fontSize: 40)),
                SizedBox(height: 40),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'firstname': '',
                    'lastname': '',
                    'email': '',
                    'password': '',
                    'user_card_id': '',
                  },
                  autovalidateMode: AutovalidateMode
                      .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                  child: Column(
                    children: <Widget>[
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: ThemeBc.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                child: FormBuilderTextField(
                                  style: TextStyle(color: Colors.white),
                                  name: "firstname",
                                  maxLines: 1,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ThemeBc.white),
                                    ),
                                    hintStyle: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.textwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // labelText: 'Email',
                                    hintText: 'ชื่อ',
                                    filled: true,
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "ป้อนข้อมูลชื่อด้วย"),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: ThemeBc.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                child: FormBuilderTextField(
                                  style: TextStyle(color: Colors.white),
                                  name: "lastname",
                                  maxLines: 1,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ThemeBc.white),
                                    ),
                                    hintStyle: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.textwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // labelText: 'Email',
                                    hintText: 'นามสกุล',
                                    filled: true,
                                    // fillColor: ThemeBc.white,
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "ป้อนข้อมูลนามสกุลด้วย"),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: ThemeBc.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                child: FormBuilderTextField(
                                  style: TextStyle(color: Colors.white),
                                  name: "email",
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ThemeBc.white),
                                    ),
                                    hintStyle: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.textwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // labelText: 'Email',
                                    hintText: 'อีเมล',
                                    filled: true,
                                    // fillColor: ThemeBc.white,
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "ป้อนข้อมูลอีเมลด้วย"),
                                    EmailValidator(
                                        errorText: "รูปแบบอีเมล์ไม่ถูกต้อง"),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: ThemeBc.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                child: FormBuilderTextField(
                                  style: TextStyle(color: Colors.white),
                                  name: "password",
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ThemeBc.white),
                                    ),
                                    hintStyle: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.textwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // labelText: 'Email',
                                    hintText: 'รหัสผ่าน',
                                    filled: true,
                                    // fillColor: ThemeBc.white,
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "ป้อนข้อรหัสผ่านด้วย"),
                                    MinLengthValidator(8,
                                        errorText:
                                            "รหัสผ่านต้อง 8 ตัวอักษรขึ้นไป"),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: ThemeBc.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                child: FormBuilderTextField(
                                  style: TextStyle(color: Colors.white),
                                  name: "user_card_id",
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ThemeBc.white),
                                    ),
                                    hintStyle: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.textwhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // labelText: 'Email',
                                    hintText: 'เลขบัตรประชาชน',
                                    filled: true,
                                    // fillColor: ThemeBc.white,
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "ป้อนเลขบัตรประชาชนด้วย"),
                                    MinLengthValidator(13,
                                        errorText:
                                            "เลขบัตรประชาชนต้อง 14 ตัวอักษรขึ้นไป"),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 50,
                      child: Expanded(
                        child: ElevatedButton.icon(
                          label: LocaleText(
                            'ลงทะเบียน',
                            style: GoogleFonts.sarabun(
                              textStyle: TextStyle(
                                color: ThemeBc.textwhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          icon: Icon(Icons.login_rounded),
                          style: ElevatedButton.styleFrom(
                            primary: ThemeBc.background,
                            //side: BorderSide(color: Colors.red, width: 5),
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            if (_fbKey.currentState!.saveAndValidate()) {
                              print(_fbKey.currentState!.value);
                              register(_fbKey.currentState!.value);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        child: LocaleText(
                          "ย้อนกลับ",
                          style: GoogleFonts.sarabun(
                            textStyle: TextStyle(
                              color: ThemeBc.textwhite,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        textColor: ThemeBc.textblack,
                        onPressed: () {
                          // _fbKey.currentState.reset();
                          Navigator.pushNamed(context, '/login_page');
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

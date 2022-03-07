import 'dart:convert';
import 'dart:io';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:cctv_tun/page/profile/app/app_reducer.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

//upload image
import 'package:image_picker/image_picker.dart';

class forgot_password extends StatefulWidget {
  @override
  _forgot_password createState() => _forgot_password();
}

class _forgot_password extends State<forgot_password>
    with SingleTickerProviderStateMixin {
  Future<void> addEmail(Map formValues) async {
    int index = 0;
    late String position = 'ยังไม่ได้เลือก';
    try {
      if (formValues['email'] != null) {
        var url = Uri.parse(
            'https://www.bc-official.com/api/app_nt/api/email/restful/');
        var request = http.MultipartRequest('POST', url)
          ..fields['app_id'] = Global.app_id
          ..fields['email'] = formValues['email'];

        Map<String, String> headers = {
          "Accept": "application/json",
          "Content-type": "multipart/form-data",
          "Authorization":
              'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
        };

        request.headers.addAll(headers);
        var res = await request.send();
        http.Response response = await http.Response.fromStream(res);

        var feedback = jsonDecode(response.body);
        print(feedback);
        if (feedback['data'] == "สำเร็จ") {
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title: '${feedback['data']}',
                title2: '',
              );
            },
          );
          // alertSuccess(context, '${feedback['data']}');
        } else {
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title: '${feedback['data']}',
                title2: '',
              );
            },
          );
        }
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return warn_api(
              title: 'ใส่ข้อมูลให้ครบถ้วน',
              title2: '',
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // _getProv();
  }

  @override
  Widget build(BuildContext context) {
    // print('=>  $selectedImage');
    Widget proFilePage() {
      final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

      var _data;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    //   Text('${profilee['user_firstname']}'),
                    Center(
                      child: StoreConnector<AppState, Map<String, dynamic>>(
                        distinct: true,
                        converter: (store) => store.state.profileState.profile,
                        builder: (context, profile) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 500,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Center(
                                        child: LocaleText(
                                          'ลืมรหัสผ่าน',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                            decoration:
                                                TextDecoration.underline,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: NeumorphicButton(
                                  style: const NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    color: Colors.black45,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: FormBuilderTextField(
                                            style:
                                                TextStyle(color: Colors.white),
                                            name: "email",
                                            maxLines: 1,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              // labelText: 'Email',
                                              hintText: 'อีเมล',
                                              hintStyle: GoogleFonts.sarabun(
                                                textStyle: TextStyle(
                                                  color: ThemeBc.textwhite,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              filled: true,

                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ThemeBc.white),
                                              ),
                                              // fillColor: ThemeBc.white,
                                            ),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      "ป้อนข้อมูลอีเมลด้วย"),
                                              EmailValidator(
                                                  errorText:
                                                      "รูปแบบอีเมล์ไม่ถูกต้อง"),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 50,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultMargin),
                                    color: Colors.transparent,
                                    child: Container(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          if (_fbKey.currentState!
                                              .saveAndValidate()) {
                                            print(_fbKey.currentState!.value);
                                            addEmail(
                                                _fbKey.currentState!.value);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.description,
                                          color: ThemeBc.white,
                                        ),
                                        label: LocaleText(
                                          'บันทึก',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Colors.black45,
                                            color: ThemeBc.textwhite,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: ThemeBc.background,
                                          // onPrimary: Colors.white,
                                          // shadowColor: Colors.grey[700],

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FlatButton(
                                      child: LocaleText("ย้อนกลับ",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline)),
                                      textColor: ThemeBc.white,
                                      onPressed: () {
                                        // _fbKey.currentState.reset();
                                        Navigator.pushNamed(
                                            context, '/login_page');
                                      },
                                    ),
                                  )
                                ],
                              ),

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: <Widget>[
                              //     Expanded(
                              //       child: ElevatedButton.icon(
                              //         label: Text('แก้ไขข้อมูล'),
                              //         icon: const Icon(Icons.description),
                              //         style: ElevatedButton.styleFrom(
                              //           primary: ThemeBc.green,
                              //           //side: BorderSide(color: Colors.red, width: 5),
                              //           textStyle:
                              //               const TextStyle(fontSize: 15),
                              //           padding: const EdgeInsets.all(15),
                              //           shape: const RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10))),
                              //         ),
                              // onPressed: () {
                              //   if (_fbKey.currentState!
                              //       .saveAndValidate()) {
                              //     // print(_fbKey.currentState.value);
                              //     updataUser(
                              //         _fbKey.currentState!.value);
                              //   }
                              // },
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // backgroundColor: ThemeBc.background,
      // drawer: manu(),
      // drawer: Icon(Icons.ac_unit, color: white),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: ThemeBc.white, //change your color here
      //   ),
      //
      //   foregroundColor: ThemeBc.white,
      //   backgroundColor: ThemeBc.black,
      //   title: Center(child: Text('บันทึก')),
      //   actions: <Widget>[],
      // ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeBc.green05, ThemeBc.green01],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: SafeArea(
          child: ListView(
            children: [
              proFilePage(),
            ],
          ),
        ),
      ),
    );
  }

  //==================================  Api  =============================================
}

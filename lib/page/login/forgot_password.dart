import 'dart:convert';
import 'dart:io';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
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
                                  decoration: BoxDecoration(
                                      color: ThemeBc.white,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ThemeBc.black,
                                            offset: Offset(2, 2),
                                            blurRadius: 7,
                                            spreadRadius: 1.0),
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      LocaleText(
                                        'ลืมรหัสผ่าน',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
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
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ThemeBc.black,
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: FormBuilderTextField(
                                      // initialValue: '${profile['user_email']}',
                                      name: "email",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.email),
                                        labelText: 'Email',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
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
                                          color: ThemeBc.black,
                                        ),
                                        label: LocaleText(
                                          'บันทึก',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Colors.black45,
                                            color: ThemeBc.black,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: ThemeBc.white,
                                          onPrimary: Colors.white,
                                          shadowColor: Colors.grey[700],
                                          elevation: 30,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
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
      backgroundColor: ThemeBc.background,
      // drawer: manu(),
      // drawer: Icon(Icons.ac_unit, color: white),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: ThemeBc.white, //change your color here
      //   ),
      //   shadowColor: ThemeBc.white,
      //   foregroundColor: ThemeBc.white,
      //   backgroundColor: ThemeBc.black,
      //   title: Center(child: Text('บันทึก')),
      //   actions: <Widget>[],
      // ),
      body: Container(
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

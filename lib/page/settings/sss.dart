import 'dart:convert';
import 'dart:io';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

//upload image
import 'package:image_picker/image_picker.dart';

class AppealPage extends StatefulWidget {
  @override
  _EmergecyPageState createState() => _EmergecyPageState();
}

class _EmergecyPageState extends State<AppealPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // print('=>  ${Global.urlWeb + '1'}');
    Widget proFilePage() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _fbKey,
                // initialValue: {'user_pass': pass, 'user_pass_confirm': passCon},
                child: Column(
                  children: <Widget>[
                    Center(
                      child: StoreConnector<AppState, Map<String, dynamic>>(
                        distinct: true,
                        converter: (store) => store.state.profileState.profile,
                        builder: (context, profile) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              const Text(
                                'เปลี่ยนรหัสผ่าน',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  // backgroundColor: Colors.black45,
                                  color: ThemeBc.black,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ThemeBc.white.withOpacity(0.5),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ThemeBc.white,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: ThemeBc.white
                                                  .withOpacity(0.5),
                                              offset: Offset(2, 2),
                                              blurRadius: 7,
                                              spreadRadius: 1.0),
                                        ]),

                                    child: FormBuilderTextField(
                                      name: "user_pass",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'รหัสผ่านใหม่',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ), //รายละเอียดเหตุการณ์
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ThemeBc.white.withOpacity(0.5),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: FormBuilderTextField(
                                      name: "user_pass_confirm",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'ยืนยันรหัสผ่านใหม่',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),
                              const SizedBox(height: 10),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      label: Text('บันทึก'),
                                      icon: const Icon(Icons.lock),
                                      style: ElevatedButton.styleFrom(
                                        primary: ThemeBc.green,
                                        //side: BorderSide(color: Colors.red, width: 5),
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                        padding: const EdgeInsets.all(15),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        if (_fbKey.currentState!
                                            .saveAndValidate()) {
                                          //print(_fbKey.currentState!.value);
                                          updataUser(
                                              _fbKey.currentState!.value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Text('แก้ไขรหัสผ่าน'),
        actions: <Widget>[],
      ),
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

  Future<void> updataUser(Map formValues) async {
    try {
      var userPass = formValues['user_pass'] ?? null;
      var userPassConfirm = formValues['user_pass_confirm'] ?? null;
      var userId = Global.user_id;
      var token = Global.token ?? null;

      if (userId != null &&
          userPass != null &&
          userPassConfirm != null &&
          token != null) {
        var url = Uri.parse(Global.urlWeb + 'api/profile/password');
        print(url);
        var request = http.MultipartRequest('POST', url)
          ..fields['user_app_id'] = Global.app_id
          ..fields['user_id'] = userId
          ..fields['user_pass'] = userPass
          ..fields['user_pass_confirm'] = userPassConfirm;

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

        if (feedback['data'] == "สำเร็จ") {
          setState(() {
            _fbKey.currentState!.reset();
          });
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title2: '',
                title: '${feedback['data']}',
              );
            },
          );
        } else {
          return showDialog(
            context: context,
            builder: (context) {
              return warn_api(
                title2: '',
                title: 'ใส่ข้อมูลให้ครบถ้วน',
              );
            },
          );
        }
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return warn_api(
              title2: '',
              title: 'ใส่ข้อมูลให้ครบถ้วน',
            );
          },
        );
      }
    } catch (e) {
      // print(e);
    }
  }
}

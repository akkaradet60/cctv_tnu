import 'dart:ffi';

import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class register_page extends StatefulWidget {
  register_page({Key? key}) : super(key: key);

  @override
  _register_pageState createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<void> register(Map formValues) async {
    print(formValues);
    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var response = await http.post(url,
        body: json.encode({
          "name": formValues['name'],
          "email": formValues['email'],
          "password": formValues['password']
        }));
    if (response.statusCode == 201) {
      Map<String, dynamic> feedback = json.decode(response.body);
      print(feedback['message']);
    } else {
      Map<String, dynamic> err = json.decode(response.body);
      print(err['errors']['email'][0]);
    }
    //var response = await http.post(url, headers: {'con': '/'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('สมัครสมาชิก'),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/logo.png', scale: 15),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _fbKey,
                      initialValue: {
                        'name': '',
                        'email': '',
                        'password': ''
                        /* 'email': '',
                        'name': '',
                        'surname': '',
                        'password': '',
                        'password2': '',
                        'phonenumber': '',*/
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FormBuilderTextField(
                            name: "email",
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              helperText: 'อีเมล',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "ป้อนข้อมูล อีเมล ด้วย",
                              ),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "name",
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.account_box_outlined),
                              helperText: 'ชื่อ',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "ป้อนข้อมูล ชื่อ ด้วย"),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "surname",
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.account_box_outlined),
                              helperText: 'นาม-สกุล',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "ป้อนข้อมูล นาม-สกุล ด้วย",
                              ),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "password",
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.security),
                              helperText: 'รหัสผ่าน',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "ป้อนข้อมูล รหัสผ่าน ด้วย",
                              ),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'password2',
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.security),
                              helperText: 'ยืนยันรหัสผ่าน',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "ป้อนข้อมูล อีเมล ด้วย",
                              ),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'phonenumber',
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.security),
                              helperText: 'เบอร์โทร',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "ป้อนข้อมูล เบอร์โทร ด้วย",
                              ),
                            ]),
                          ),
                          Container(
                            color: Colors.transparent,
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    title: 'สมัครสมาชิก',
                                    onPressed: () {
                                      if (_fbKey.currentState!
                                          .saveAndValidate()) {
                                        print(_fbKey.currentState!.value);
                                        //  register(_fbKey.currentState!.value);
                                      }
                                    },
                                    colorButton: primaryColor,
                                    textStyle: secondaryTextStyle.copyWith(
                                        fontWeight: medium, fontSize: 16),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:form_field_validator/form_field_validator.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.lightBlue])),
            margin: EdgeInsets.only(top: 10),
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                'email': '',
                'Password': '',
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Image.asset('assets/logo.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Card(
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: 'email',
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Card(
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "firstname",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.security),
                          helperText: 'รหัสผ่าน',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "ป้อนข้อมูล Password ด้วย"),
                        ]),
                      ),
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
                              Navigator.pushNamed(context, '/RegisterPage'),
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
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            title: 'ล็อกอิน',
                            onPressed: () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                print(_formKey.currentState!.value);
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
                              Navigator.pushNamed(context, '/home-page'),
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
        ],
      ),
    ));
  }
}

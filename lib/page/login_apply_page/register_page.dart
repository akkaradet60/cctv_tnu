import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "name": formValues["name"],
          "email": formValues["email"],
          "password": formValues["password"]
        }));
    if (response.statusCode == 201) {
      Map<String, dynamic> feedback = json.decode(response.body);
      //print(feedback['message']);
      // print(feedback['message']);
      //กลับไปที่หน้า LoginPage
      //  Future.delayed(Duration(seconds: 3), () {
      //  Navigator.pop(context);
      // });

    } else {
      Map<String, dynamic> err = json.decode(response.body);
      print(err['errors']['email'][0]);
      //print(err['errors']['email'][0]);

    }
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.lightBlue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text('ลงทะเบียน', style: TextStyle(fontSize: 40)),
                    SizedBox(height: 40),
                    FormBuilder(
                      key: _fbKey,
                      initialValue: {'name': '', 'email': '', 'password': ''},
                      autovalidateMode: AutovalidateMode
                          .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: "name",
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'ชื่อ-สกุล',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                errorStyle:
                                    TextStyle(backgroundColor: Colors.white)),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "email",
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                errorStyle:
                                    TextStyle(backgroundColor: Colors.white)),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "password",
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                errorStyle:
                                    TextStyle(backgroundColor: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          padding: EdgeInsets.all(20),
                          color: Colors.brown,
                          // minWidth: 100,
                          // height: 20,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("ลงทะเบียน"),
                          onPressed: () {
                            if (_fbKey.currentState!.saveAndValidate()) {
                              // print(_fbKey.currentState.value);
                              register(_fbKey.currentState!.value);
                            }
                          },
                        ),
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

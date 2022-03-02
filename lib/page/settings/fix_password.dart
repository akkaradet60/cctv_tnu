import 'dart:convert';
import 'dart:io';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
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

class fix_password extends StatefulWidget {
  @override
  _EmergecyPageState createState() => _EmergecyPageState();
}

class _EmergecyPageState extends State<fix_password>
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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
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
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 15),
                                  Text(
                                    'เปลี่ยนรหัสผ่าน',
                                    style: GoogleFonts.sarabun(
                                      textStyle: TextStyle(
                                        color: ThemeBc.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  NeumorphicButton(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      color: ThemeBc.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ThemeBc.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ThemeBc.white
                                                      .withOpacity(0.1),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 7,
                                                  spreadRadius: 1.0),
                                            ]),

                                        child: FormBuilderTextField(
                                          name: "user_pass",
                                          maxLines: 1,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // labelText: 'Email',
                                            hintText: "รหัสผ่านใหม่",
                                            filled: true,
                                            fillColor: ThemeBc.white,
                                          ),
                                        ), //รายละเอียดเหตุการณ์
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  NeumorphicButton(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      color: ThemeBc.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        child: FormBuilderTextField(
                                          name: "user_pass_confirm",
                                          maxLines: 1,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // labelText: 'Email',
                                            hintText: "ยืนยันรหัสผ่านใหม่",
                                            filled: true,
                                            fillColor: ThemeBc.white,
                                          ),
                                        ),
                                      ),
                                    ), //รายละเอียดเหตุการณ์
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(height: 15),
                                  Container(
                                    width: 390,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultMargin),
                                    color: Colors.transparent,
                                    child: Container(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          if (_fbKey.currentState!
                                              .saveAndValidate()) {
                                            //print(_fbKey.currentState!.value);
                                            updataUser(
                                                _fbKey.currentState!.value);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.lock,
                                          color: ThemeBc.textwhite,
                                        ),
                                        label: Text(
                                          'เปลี่ยนรหัสผ่าน',
                                          style: GoogleFonts.sarabun(
                                            textStyle: TextStyle(
                                              color: ThemeBc.textwhite,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: ThemeBc.background,
                                          onPrimary: Colors.black,
                                          // shadowColor: Colors.grey[700],

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   children: <Widget>[
                                  //     Expanded(
                                  //       child: ElevatedButton.icon(
                                  //         label: Text('บันทึก'),
                                  //         icon: const Icon(Icons.lock),
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
                                  //         onPressed: () {
                                  //           if (_fbKey.currentState!
                                  //               .saveAndValidate()) {
                                  //             //print(_fbKey.currentState!.value);
                                  //             updataUser(
                                  //                 _fbKey.currentState!.value);
                                  //           }
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
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
      backgroundColor: ThemeBc.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Column(
          children: [
            Center(
                child: LocaleText(
              'แก้ไขรหัสผ่าน',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.textwhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            )),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('เราเทศบาลตำบลพระลับ')));
            },
          ),
        ],
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

// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/page/global/style/global.dart';

// import 'package:cctv_tun/page/profile/app_reducer.dart';
// import 'package:cctv_tun/widgets/warn_api.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_redux/flutter_redux.dart';

// import 'package:http/http.dart' as http;

// import 'dart:convert';

// class fix_password extends StatefulWidget {
//   @override
//   _EmergecyPageState createState() => _EmergecyPageState();
// }

// class ApiImage {
//   final String imageUrl;
//   final String id;
//   ApiImage({
//     required this.imageUrl,
//     required this.id,
//   });
// }

// class _EmergecyPageState extends State<fix_password>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     //  getProfile();
//   }

//   // // List<Data> data = [];

//   @override
//   Widget build(BuildContext context) {
//     Widget emergecyPage1() {
//       final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

//       var _data;
//       return SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // const Text('เลือกประเภทการแจ้งเหตุ',
//               //     style: TextStyle(fontSize: 15)),
//               // const Divider(),
//               // const SizedBox(height: 40),
//               FormBuilder(
//                 key: _fbKey,
//                 initialValue: const {},
//                 // autovalidateMode: AutovalidateMode
//                 //     .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
//                 child: Column(
//                   children: <Widget>[
//                     //   Text('${profilee['user_firstname']}'),
//                     Center(
//                       child: StoreConnector<AppState, Map<String, dynamic>>(
//                         distinct: true,
//                         converter: (store) => store.state.profileState.profile,
//                         builder: (context, profile) {
//                           Future<void> compose_page(Map formValues) async {
//                             //formValues['name']
//                             // print(formValues);

//                             try {
//                               var url = Global.urlWeb +
//                                   'api/profile/restful?user_id=${Global.user_id}&user_app_id=${Global.app_id}';
//                               var response =
//                                   await http.post(Uri.parse(url), headers: {
//                                 "Accept": "application/json",
//                                 'Authorization': 'Bearer ${Global.token}'
//                               }, body: {
//                                 // "emi_path_name[]": formValues['emi_path_name']
//                                 // "user_app_id": Global.app_id,
//                                 // "user_card_id": '1471200',
//                                 // "user_firstname": formValues['firstname'],
//                                 // "user_lastname": formValues['lastname'],
//                                 // "user_email": formValues['email'],
//                                 // "user_pass": formValues['password']
//                               });
//                               Map<String, dynamic> profilee =
//                                   json.decode(response.body);

//                               if (response.statusCode == 201) {
//                                 return showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return warn_api(
//                                       title: '${profilee['data']}',
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 return showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return warn_api(
//                                       title: '${profilee['data']}',
//                                     );
//                                   },
//                                 );
//                               }
//                             } catch (e) {
//                               // print(e);
//                             }
//                           }

//                           return Container(
//                             height: 550,
//                             decoration: BoxDecoration(
//                                 color: ThemeBc.black,
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       offset: Offset(2, 2),
//                                       blurRadius: 7,
//                                       spreadRadius: 1.0),
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.5),
//                                       offset: Offset(2, 4),
//                                       blurRadius: 7.0,
//                                       spreadRadius: 1.0),
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 200,
//                                     height: 200,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       image: DecorationImage(
//                                           image: NetworkImage(
//                                               '${Global.networkImage}'),
//                                           fit: BoxFit.fill),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         color: secondaryTextColor,
//                                         borderRadius: BorderRadius.circular(
//                                           20,
//                                         ),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.5),
//                                               offset: Offset(2, 2),
//                                               blurRadius: 7,
//                                               spreadRadius: 1.0),
//                                           BoxShadow(
//                                               color:
//                                                   Colors.black.withOpacity(0.5),
//                                               offset: Offset(2, 4),
//                                               blurRadius: 7.0,
//                                               spreadRadius: 1.0),
//                                         ]),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: secondaryTextColor,
//                                           borderRadius: BorderRadius.circular(
//                                             20,
//                                           ),
//                                         ),

//                                         child: FormBuilderTextField(
//                                           // initialValue:
//                                           //     // '${profile['user_firstname']}',
//                                           name: "user_firstname",
//                                           maxLines: 1,
//                                           keyboardType:
//                                               TextInputType.emailAddress,
//                                           obscureText: true,
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 20.0,
//                                               ),
//                                             ),
//                                             suffixIcon:
//                                                 Icon(Icons.vpn_key_sharp),
//                                             labelText: 'รหัสผ่านใหม่',
//                                             fillColor: Colors.white,
//                                             filled: true,
//                                           ),
//                                         ), //รายละเอียดเหตุการณ์
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         color: secondaryTextColor,
//                                         borderRadius: BorderRadius.circular(
//                                           20,
//                                         ),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.5),
//                                               offset: Offset(2, 2),
//                                               blurRadius: 7,
//                                               spreadRadius: 1.0),
//                                           BoxShadow(
//                                               color:
//                                                   Colors.black.withOpacity(0.5),
//                                               offset: Offset(2, 4),
//                                               blurRadius: 7.0,
//                                               spreadRadius: 1.0),
//                                         ]),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         child: FormBuilderTextField(
//                                           // initialValue:
//                                           //     '${profile['user_lastname']}',
//                                           name: "user_lastname",
//                                           maxLines: 1,
//                                           keyboardType:
//                                               TextInputType.emailAddress,
//                                           obscureText: true,
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 20.0,
//                                               ),
//                                             ),
//                                             suffixIcon:
//                                                 Icon(Icons.vpn_key_rounded),
//                                             labelText: 'ยืนยันรหัสผ่านใหม่',
//                                             fillColor: Colors.white,
//                                             filled: true,
//                                           ),
//                                         ),
//                                       ),
//                                     ), //รายละเอียดเหตุการณ์
//                                   ),
//                                   SizedBox(height: 20),
                                  // Container(
                                  //   width: 390,
                                  //   height: 60,
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: defaultMargin),
                                  //   color: Colors.transparent,
                                  //   child: Container(
                                  //     child: ElevatedButton.icon(
                                  //       onPressed: () {
                                  //         if (_fbKey.currentState!
                                  //             .saveAndValidate()) {
                                  //           compose_page(
                                  //               _fbKey.currentState!.value);
                                  //           print(_fbKey.currentState!.value);
                                  //         }
                                  //       },
                                  //       icon: Icon(Icons.lock),
                                  //       label: Text('เปลี่ยนรหัสผ่าน'),
                                  //       style: ElevatedButton.styleFrom(
                                  //         primary: Colors.white,
                                  //         onPrimary: Colors.black,
                                  //         shadowColor: Colors.grey[700],
                                  //         elevation: 30,
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(40))),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       // drawer: manu(),
//       // drawer: Icon(Icons.ac_unit, color: white),
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: ThemeBc.white, //change your color here
//         ),
//         
//         foregroundColor: ThemeBc.white,
//         backgroundColor: ThemeBc.black,
//         title: Center(child: const Text('แก้ไขรหัสผ่าน')),
//         actions: <Widget>[
//           IconButton(
//             icon: Image.asset('assets/logo.png', scale: 15),
//             tooltip: 'Show Snackbar',
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('เราเทศบาลตำบลพระลับ')));
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [ThemeBc.white, ThemeBc.white],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft),
//         ),
//         child: SafeArea(
//           child: ListView(
//             children: [
//               emergecyPage1(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

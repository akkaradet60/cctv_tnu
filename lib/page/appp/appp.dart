import 'dart:convert';

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:cctv_tun/widgets/custom_buttonn.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class appp extends StatefulWidget {
  appp({Key? key}) : super(key: key);

  @override
  State<appp> createState() => _apppState();
}

var popp;

class _apppState extends State<appp> {
  late Map<String, dynamic> imgSlide;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url =
        ('https://www.bc-official.com/api/app_nt/api/app/alert/restful/?blog_app_id=1');
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
    });

    if (response.statusCode == 200) {
      imgSlide = json.decode(response.body);
      print(imgSlide);

      // print(imgSlide['data'].length);
      return imgSlide;
    } else {
      throw Exception('$response.statusCode');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataSlide();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 500,
              width: 500,
              child: FutureBuilder<Map<String, dynamic>>(
                future: getDataSlide(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!['data'].length,
                      itemBuilder: (context, index) {
                        Future<void> updataUser() async {
                          try {
//=======  check data ==========

                            var url = Uri.parse(
                                'https://www.bc-official.com/api/app_nt/api/app/alert/restful/?blog_app_id=1');
                            var request = http.MultipartRequest('POST', url)
                              ..fields['blog_app_id'] = Global.app_id
                              ..fields['blog_id'] =
                                  '${snapshot.data!['data'][index]['blog_id']}'
                              ..fields['blog_alert'] = '1';

                            Map<String, String> headers = {
                              "Accept": "application/json",
                              "Content-type": "multipart/form-data",
                              "Authorization":
                                  'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
                            };

                            request.headers.addAll(headers);
                            var res = await request.send();
                            http.Response response =
                                await http.Response.fromStream(res);

                            var feedback = jsonDecode(response.body);

                            if (feedback['data'] == "สำเร็จ") {
                              // return showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return warn_api(
                              //       title2: '',
                              //       title: '${feedback['data']}',
                              //     );
                              //   },
                              // );
                            } else {
                              // return showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return warn_api(
                              //       title2: '',
                              //       title: '${feedback['data']}',
                              //     );
                              //   },
                              // );
                            }
                          } catch (e) {
                            // print(e);
                          }
                        }

                        void Notify(context) async {
                          String timezom = await AwesomeNotifications()
                              .getLocalTimeZoneIdentifier();
                          await AwesomeNotifications().createNotification(
                            content: NotificationContent(
                                id: 1,
                                channelKey: 'key1',
                                title:
                                    'ข่าว: ${snapshot.data!['data'][index]['blog_name']}',
                                body:
                                    'เนื้อหาข่าว : ${snapshot.data!['data'][index]['blog_detail']}',
                                bigPicture: snapshot.data!['data'][index]
                                                ['blog_images'][index]
                                            ['blogi_path_name'] !=
                                        null
                                    ? Global.domainImage +
                                        snapshot.data!['data'][index]
                                                ['blog_images'][index]
                                            ['blogi_path_name']
                                    : '${Global.networkImage}',
                                notificationLayout:
                                    NotificationLayout.BigPicture),
                            // schedule:
                            //     NotificationInterval(interval: 5, timeZone: timezom, repeats: true)
                          );
                        }

                        return Container(
                          width: 500,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20, bottom: 0),
                                    child: Column(
                                      children: [
                                        CustomButton(
                                            title: 'title',
                                            onPressed: () {
                                              updataUser();
                                              Notify(context);

                                              // AwesomeNotifications()
                                              //     .actionStream
                                              //     .listen((ReceivedNotification) {
                                              //   Navigator.of(context).pushNamed('/home_page');
                                              // });
                                            },
                                            colorButton: ThemeBc.black,
                                            textStyle: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              // backgroundColor: Colors.black45,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // void Notify(context) async {
                    //   String timezom = await AwesomeNotifications()
                    //       .getLocalTimeZoneIdentifier();
                    //   await AwesomeNotifications().createNotification(
                    //     content: NotificationContent(
                    //         id: 1,
                    //         channelKey: 'key1',
                    //         title:
                    //             'ข่าว: ${snapshot.data!['data'][0]['blog_name']}',
                    //         body:
                    //             'เนื้อหาข่าว : ${snapshot.data!['data'][0]['blog_detail']}',
                    //         bigPicture: snapshot.data!['data'][0]['blog_images']
                    //                     [0]['blogi_path_name'] !=
                    //                 null
                    //             ? Global.domainImage +
                    //                 snapshot.data!['data'][0]['blog_images'][0]
                    //                     ['blogi_path_name']
                    //             : '${Global.networkImage}',
                    //         notificationLayout: NotificationLayout.BigPicture),
                    //     // schedule:
                    //     //     NotificationInterval(interval: 5, timeZone: timezom, repeats: true)
                    //   );
                    // }

                    // return Column(
                    //   children: [
                    //     CustomButton(
                    //         title: 'title',
                    //         onPressed: () {
                    //           Notify(context);
                    //           // AwesomeNotifications()
                    //           //     .actionStream
                    //           //     .listen((ReceivedNotification) {
                    //           //   Navigator.of(context).pushNamed('/home_page');
                    //           // });
                    //         },
                    //         colorButton: ThemeBc.black,
                    //         textStyle: TextStyle(
                    //           fontSize: 20.0,
                    //           fontWeight: FontWeight.bold,
                    //           // backgroundColor: Colors.black45,
                    //           color: Colors.white,
                    //         ))
                    //   ],
                    // );
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                  }

                  return Center(
                      child: SpinKitThreeInOut(
                    color: ThemeBc.app_linear_on,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

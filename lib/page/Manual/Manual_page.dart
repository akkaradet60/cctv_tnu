import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';

import 'package:cctv_tun/page/global/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class manual_page extends StatefulWidget {
  manual_page({Key? key}) : super(key: key);

  @override
  State<manual_page> createState() => _manual_pageState();
}

class _manual_pageState extends State<manual_page> {
  late PdfViewerController _pdfViewerController;
  // List<Data> data = [];
  // bool isLoading = true;
  // var productt;
  // Future<void> getData() async {
  var url = (Global.urlWeb +
      'api/app/manual/restful/?manual_app_id=${Global.app_id}');
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   // print(json.decode(response.body));

  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final Manuals manuals = Manuals.fromJson(json.decode(response.body));
  //     print(manuals.data);
  //     setState(() {
  //       data = manuals.data;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error 400');
  //   }
  // }

  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/manual/restful/?manual_app_id=${Global.app_id}');
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
    });

    if (response.statusCode == 200) {
      imgSlide = json.decode(response.body);

      // print(imgSlide['data'].length);
      return imgSlide;
    } else {
      throw Exception('$response.statusCode');
    }
  }

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    //  getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.app_white_color, //change your color here
          ),
          foregroundColor: ThemeBc.app_white_color,
          backgroundColor: ThemeBc.app_theme_color,
          title: Column(
            children: [
              Center(
                  child: LocaleText(
                'คู่มือการใช้งาน',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.app_textwhite_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: ThemeBc.app_linear_on,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          width: 1000,
          height: 1000,
          child: FutureBuilder<Map<String, dynamic>>(
            future: getDataSlide(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!['data'] == 'ไม่พบข้อมูล') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ThemeBc.app_linear_on,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(2, 4),
                                    blurRadius: 7.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ไม่พบข้อมูล',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                                // backgroundColor: Colors.black45,
                                color: ThemeBc.app_textwhite_color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 500,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 800,
                              child: SfPdfViewer.network(
                                Global.files +
                                    '${snapshot.data!['data'][index]['manual_path_name']}',
                                controller: _pdfViewerController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
              }

              return Center(
                  child: SpinKitThreeInOut(
                color: ThemeBc.app_linear_on,
              ));
            },
          ),
        ),
        // body: ListView.builder(
        //     // scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) {
        //       return Container(
        //         height: 800,
        //         child: SfPdfViewer.network(
        //           '${data[index].manualPathName}',
        //           controller: _pdfViewerController,
        //         ),
        //       );
        //     },
        //     itemCount: data.length),
      ),
    );
  }
}

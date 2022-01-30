import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';

import 'package:cctv_tun/page/global/global.dart';

import 'package:flutter/material.dart';
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
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Center(child: const Text('คู่มือการใช้งาน')),
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
          color: ThemeBc.background,
          width: 1000,
          height: 1000,
          child: FutureBuilder<Map<String, dynamic>>(
            future: getDataSlide(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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

              return Center(child: CircularProgressIndicator());
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

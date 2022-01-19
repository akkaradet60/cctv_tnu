import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class manual_page extends StatefulWidget {
  manual_page({Key? key}) : super(key: key);

  @override
  _manual_paState createState() => _manual_paState();
}

class _manual_paState extends State<manual_page> {
  late PdfViewerController _pdfViewerController;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfPdfViewer.network(
          'https://jobm.edoclite.online/jobManagement/pages/pdf/%E0%B8%84%E0%B8%B9%E0%B9%88%E0%B8%A1%E0%B8%B7%E0%B8%AD.pdf',
          controller: _pdfViewerController,
        ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _pdfViewerController.jumpToPage(5);
                },
                icon: Icon(Icons.zoom_in))
          ],
        ),
      ),
    );
  }
}








// import 'package:cctv_tun/widgets/pdf/ApiServiceProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class manual_page extends StatefulWidget {
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<manual_page> {
//   var localPath;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     ApiServiceProvider.loadPDF().then((value) {
//       setState(() {
//         localPath = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "CodingBoot Flutter PDF Viewer",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: localPath != null
//           ? PDFView(
//               filePath: localPath,
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:cctv_tun/models/Manual/Manual.dart';
// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/widgets/pdf/pdf_sve.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class manual_page extends StatefulWidget {
//   manual_page({Key? key}) : super(key: key);

//   @override
//   _help_pageState createState() => _help_pageState();
// }

// class _help_pageState extends State<manual_page> {
//   String? localPath;
//   // List<Data> data = [];
//   bool isLoading = true;
//   // Future<void> getData() async {
//   //   var url =
//   //       'https://www.bc-official.com/api/app_nt/api/app/manual/restful/?manual_app_id=${Global.app_id}';
//   //   var response = await http.get(Uri.parse(url),
//   //       headers: {'Authorization': 'Bearer ${Global.token}'});
//   //   print(json.decode(response.body));
//   //   if (response.statusCode == 200) {
//   //     //นำ json ใส่ที่โมเมล product
//   //     final Manuals paroduct = Manuals.fromJson(json.decode(response.body));
//   //     print(paroduct.data);
//   //     setState(() {
//   //       data = paroduct.data;
//   //       isLoading = false;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //     print('error 400');
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     ApiServiceProvider.loadPDF().then((value) {
//       setState(() {
//         localPath = value;
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: localPath != null
//           ? PDFView(
//               filePath: localPath,
//             )
//           : Center(child: CircularProgressIndicator()),
// //Container(
//       //   decoration: BoxDecoration(
//       //     gradient: LinearGradient(
//       //         colors: [Colors.pinkAccent, Colors.orangeAccent],
//       //         begin: Alignment.topRight,
//       //         end: Alignment.bottomLeft),
//       //   ),
//       //   child: isLoading == true
//       //       ? Center(
//       //           child: CircularProgressIndicator(),
//       //         )
//       //       : ListView.separated(
//       //           itemBuilder: (context, index) {
//       //             return ListTile(
//       //                 // leading: Container(
//       //                 //   width: 80,
//       //                 //   height: 80,
//       //                 //   // decoration: BoxDecoration(
//       //                 //   //     shape: BoxShape.rectangle,
//       //                 //   //     image: DecorationImage(
//       //                 //   //         image:
//       //                 //   //             NetworkImage('${data[index].manualPathName}'),
//       //                 //   //         fit: BoxFit.fill)),
//       //                 // ),
//       //                 /* leading: Image.network(
//       //           '${data[index].picture}',
//       //           width: 80,
//       //           height: 80,

//       //         ),*/
//       //                 );
//       //           },
//       //           separatorBuilder: (context, index) => Divider(),
//       //           itemCount: data.length),
//       // ),
//     );
//   }
// }

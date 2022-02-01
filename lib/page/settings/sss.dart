import 'dart:io';

import 'package:cctv_tun/page/global/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class sss extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Upload',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Upload'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedImage;
  var resJson = '1';

  onUploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://www.bc-official.com/api/app_nt/api/test/restful.php"),
    );
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer ${Global.token}'
    };
    request.files.add(
      http.MultipartFile(
        'files',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      ),
    );

    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    setState(() {
      // resJson = jsonDecode(response.body);
    });
  }

  Future getImage() async {
    //var image = await ImagePicker().getImage(source: ImageSource.gallery);
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(resJson);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Container(
                    child: Text(
                      'Please Pick a image to Upload',
                    ),
                  )
                : Image.file(selectedImage!),
            RaisedButton(
              color: Colors.green[300],
              onPressed: onUploadImage,
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(resJson),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
























// import 'dart:convert';
// import 'dart:async';
// import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:cctv_tun/page/menu/manu.dart';
// import 'package:cctv_tun/page/profile/app_reducer.dart';
// import 'package:cctv_tun/page/profile/profile_action.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// // import 'package:awesome_notifications/awesome_notifications.dart';
// // import 'package:smartcity_nt_mobile/global.dart';
// // import 'package:smartcity_nt_mobile/notifications/notifications.dart';
// // import 'package:smartcity_nt_mobile/redux/app_reducer.dart';
// // import 'package:smartcity_nt_mobile/redux/application/action.dart';
// // import 'package:smartcity_nt_mobile/redux/profile/profile_action.dart';
// // import 'package:smartcity_nt_mobile/style/global.dart';
// // import 'package:smartcity_nt_mobile/widgets/menu_home_widget.dart';
// // import 'package:smartcity_nt_mobile/widgets/menu_widget.dart';
// // import 'package:smartcity_nt_mobile/widgets/navbar_widget.dart';
// // import 'package:smartcity_nt_mobile/widgets/noti_widget.dart';

// GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// void toggleDrawer() {
//   if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
//     _scaffoldKey.currentState?.openEndDrawer();
//   } else {
//     _scaffoldKey.currentState?.openDrawer();
//   }
// }

// class DropDownList extends StatelessWidget {
//   final String name;
//   final Function call;

//   const DropDownList({Key? key, required this.name, required this.call})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: ListTile(title: Text(name)),
//       onTap: () => call(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, this.title}) : super(key: key);
//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // late Map<String, dynamic> profile;

//   //List<Data> data = [];
//   bool isLoading = true;

//   bool isSwitched = false;
//   int _currentIndex = 0;

//   late Map<String, dynamic> product;
//   late Map<String, dynamic> detail;

//   late Map<String, dynamic> imgSlide;

//   late List<String> titles = [
//     ' 1 ',
//     ' 2 ',
//     ' 3 ',
//     ' 4 ',
//     ' 5',
//   ];

//   String? tokenHome;
//   String? application_id;

//   // final List<String> imagesList = [];
//   // final List<String> titles = [];
//   @override
//   void initState() {
//     super.initState();
//     getProfile();

//     // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//     //   if (!isAllowed) {
//     //     showDialog(
//     //       context: context,
//     //       builder: (context) => AlertDialog(
//     //         title: Text('อนุญาตการแจ้งเตือน'),
//     //         content: Text('แอปพลิเคชันนี้ต้องการส่งการแจ้งเตือนถึงคุณ '),
//     //         actions: [
//     //           TextButton(
//     //             onPressed: () {
//     //               Navigator.pop(context);
//     //             },
//     //             child: Text(
//     //               'ไม่อนุญาต',
//     //               style: TextStyle(
//     //                 color: Colors.grey,
//     //                 fontSize: 18,
//     //               ),
//     //             ),
//     //           ),
//     //           TextButton(
//     //               onPressed: () => AwesomeNotifications()
//     //                   .requestPermissionToSendNotifications()
//     //                   .then((_) => Navigator.pop(context)),
//     //               child: Text(
//     //                 'อนุญาต',
//     //                 style: TextStyle(
//     //                   color: Colors.teal,
//     //                   fontSize: 18,
//     //                   fontWeight: FontWeight.bold,
//     //                 ),
//     //               ))
//     //         ],
//     //       ),
//     //     );
//     //   }
//     // });

//     // AwesomeNotifications().createdStream.listen((notification) {
//     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //     content: Text(
//     //       'แจ้งเตือน ${notification.channelKey}',
//     //     ),
//     //   ));
//     // });

//     // AwesomeNotifications().actionStream.listen((notification) {
//     //   if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
//     //     AwesomeNotifications().getGlobalBadgeCounter().then(
//     //           (value) =>
//     //               AwesomeNotifications().setGlobalBadgeCounter(value - 1),
//     //         );
//     //   }
//     // });
//     //getDataSlide();
//   }

//   // @override
//   // void dispose() {
//   //   AwesomeNotifications().actionSink.close();
//   //   AwesomeNotifications().createdSink.close();
//   //   super.dispose();
//   // }

//   Future<Map<String, dynamic>> getDataSlide() async {
//     var url = Global.urlWeb +
//         'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=${Global.glog_catid}';
//     var response = await http.get(Uri.parse(url), headers: {
//       'Authorization':
//           'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//     });

//     if (response.statusCode == 200) {
//       imgSlide = json.decode(response.body);

//       // print(imgSlide['data'].length);
//       return imgSlide;
//     } else {
//       throw Exception('$response.statusCode');
//     }
//   }

//   Future<void> getProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     Map<String, dynamic> appToken =
//         json.decode(prefs.getString('token').toString());
//     // print(appToken['access_token']);

//     setState(() {
//       Global.token = appToken['access_token'];
//     });

//     var newProfile = json.decode(prefs.getString('profile').toString());
//     var newApplication = json.decode(prefs.getString('application').toString());
//     // print(newProfile);
//     // print(newApplication);
//     //call redux action
//     final store = StoreProvider.of<AppState>(context);
//     store.dispatch(updateProfileAction(newProfile));
//     // store.dispatch(updateApplicationAction(newApplication));
//   }

//   @override
//   Widget build(BuildContext context) {
//     var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//     // print(Global.token);
//     Widget slideMain() {
//       return FutureBuilder<Map<String, dynamic>>(
//         future: getDataSlide(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             // return ListView.separated(
//             //     itemBuilder: (context, index) {
//             // return Text('3232');
//             return CarouselSlider.builder(
//               itemCount: snapshot.data!['data'].length,
//               options: CarouselOptions(
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 viewportFraction: 0.9,
//                 aspectRatio: 2.0,
//                 initialPage: 2,
//                 onPageChanged: (index, reason) {
//                   setState(
//                     () {
//                       _currentIndex = index;
//                     },
//                   );
//                 },
//               ),
//               itemBuilder:
//                   (BuildContext context, int item, int pageViewIndex) =>

//                       // Text('${snapshot.data!['data'][item]['blog_id']}');
//                       //     Container(
//                       //   child: Center(child: Text(item.toString())),
//                       //   color: Colors.green,
//                       // ),
//                       NeumorphicButton(
//                 style: const NeumorphicStyle(
//                   shape: NeumorphicShape.flat,
//                   // boxShape:
//                   //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
//                   // boxShape: NeumorphicBoxShape.circle(),
//                   color: ThemeBc.white,
//                 ),
//                 padding: const EdgeInsets.all(0),
//                 child: Card(
//                   margin: const EdgeInsets.only(
//                     top: 10.0,
//                     bottom: 10.0,
//                   ),
//                   elevation: 6.0,
//                   // shadowColor: Colors.redAccent,
//                   // shape: RoundedRectangleBorder(
//                   //     // borderRadius: BorderRadius.circular(30.0),
//                   //     ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(3.0),
//                     ),
//                     child: Stack(
//                       children: <Widget>[
//                         Image.network(
//                           snapshot.data!['data'][item]['blog_images'][0]
//                                       ['blogi_path_name'] !=
//                                   null
//                               ? Global.domainImage +
//                                   snapshot.data!['data'][item]['blog_images'][0]
//                                       ['blogi_path_name']
//                               : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                         Center(
//                             // child: Text(
//                             //   // '${titles[_currentIndex]}',
//                             //   '${snapshot.data!['data'][item]['blog_name']}',
//                             //   style: const TextStyle(
//                             //     fontSize: 24.0,
//                             //     fontWeight: FontWeight.bold,
//                             //     backgroundColor: Colors.black45,
//                             //     color: LightColors.kLightYellow,
//                             //   ),
//                             // ),
//                             ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//                 child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
//           }

//           return const Center(child: CircularProgressIndicator());
//         },
//       );
//     }

//     // Widget alertMain() {
//     //   return Column(
//     //     mainAxisAlignment: MainAxisAlignment.center,
//     //     children: [
//     //       // PlantImage(),
//     //       SizedBox(
//     //         height: 25,
//     //       ),
//     //       // HomePageButtons(
//     //       //   onPressedOne: createPlantFoodNotification,
//     //       // ),
//     //     ],
//     //   );
//     // }

//     return Scaffold(
//         key: _scaffoldKey,
//         // bottomNavigationBar: const BottomNav(),
//         drawer: menu_pang(),
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             "เทศบาลมหาสารคราม",
//             style: TextStyle(color: ThemeBc.black),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.refresh),
//             ),
//           ],
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 slideMain(),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: titles.map((urlOfItem) {
//                     int index = titles.indexOf(urlOfItem);
//                     return Container(
//                       width: 10.0,
//                       height: 10.0,
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 2.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _currentIndex == index
//                             ? const Color.fromRGBO(0, 0, 0, 0.8)
//                             : const Color.fromRGBO(0, 0, 0, 0.3),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 // alertMain(),
//                 // profileHome(),
//                 const Divider(),
//                 //  MenuHome(),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// // import 'package:cctv_tun/page/global/global.dart';
// import 'package:cctv_tun/page/global/style/global.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class sss extends StatefulWidget {
//   sss({Key? key}) : super(key: key);

//   @override
//   State<sss> createState() => _sssState();
// }

// class _sssState extends State<sss> {
//   late Map<String, dynamic> imgSlide;

//   int _currentIndex = 0;

//   Future<Map<String, dynamic>> getDataSlide() async {
//     var url =
//         ('https://www.bc-official.com/api/app_nt/api/country/province/restful/?app_id=1');
//     var response = await http.get(Uri.parse(url), headers: {
//       'Authorization':
//           'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
//     });

//     if (response.statusCode == 200) {
//       imgSlide = json.decode(response.body);

//       // print(imgSlide['data'].length);
//       return imgSlide;
//     } else {
//       throw Exception('$response.statusCode');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         color: ThemeBc.background,
//         width: 1000,
//         height: 1000,
//         child: FutureBuilder<Map<String, dynamic>>(
//           future: getDataSlide(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!['data'].length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: 1000,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 20, bottom: 0),
//                             child: Column(
//                               children: [
//                                 SizedBox(width: defaultMargin),
//                                 Container(
//                                   height: 200,
//                                   width: 350,
//                                   decoration: BoxDecoration(
//                                       color: secondaryTextColor,
//                                       borderRadius: BorderRadius.circular(
//                                         10,
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             offset: Offset(2, 2),
//                                             blurRadius: 7,
//                                             spreadRadius: 1.0),
//                                         BoxShadow(
//                                             color:
//                                                 Colors.black.withOpacity(0.5),
//                                             offset: Offset(2, 4),
//                                             blurRadius: 7.0,
//                                             spreadRadius: 1.0),
//                                       ]),
//                                   child: Column(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           SizedBox(height: 5),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.grey[200],
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   20,
//                                                 ),
//                                                 boxShadow: []),
//                                             width: 340,
//                                             height: 180,
//                                             child: ListView(
//                                               children: [
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                       color: secondaryTextColor,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                         20,
//                                                       ),
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                             color: Colors.grey
//                                                                 .withOpacity(
//                                                                     0.5),
//                                                             offset:
//                                                                 Offset(2, 2),
//                                                             blurRadius: 7,
//                                                             spreadRadius: 1.0),
//                                                         BoxShadow(
//                                                             color: Colors.black
//                                                                 .withOpacity(
//                                                                     0.5),
//                                                             offset:
//                                                                 Offset(2, 4),
//                                                             blurRadius: 7.0,
//                                                             spreadRadius: 1.0),
//                                                       ]),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Container(
//                                                       child:
//                                                           FormBuilderDropdown(
//                                                         name: "em_type",

//                                                         decoration:
//                                                             InputDecoration(
//                                                           border:
//                                                               OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               20.0,
//                                                             ),
//                                                           ),
//                                                           suffixIcon: Icon(
//                                                               Icons.article),
//                                                           // labelText: 'เลือกประเภทการแจ้งเหตุ',
//                                                           fillColor:
//                                                               Colors.white,
//                                                           filled: true,
//                                                         ),
//                                                         // initialValue: 'Male',
//                                                         //allowClear: true,
//                                                         hint: Text(
//                                                             'เลือกประเภทการแจ้งเหตุ'),

//                                                         items: [
//                                                           // DropdownMenuItem(
//                                                           //   value: '1',
//                                                           //   child: Text(
//                                                           //       '${snapshot.data!['data'][1]['name_th']}'),
//                                                           // ),
//                                                           // DropdownMenuItem(
//                                                           //     value: '2',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][2]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '3',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][3]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '4',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][4]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '5',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][5]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '6',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][6]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '7',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][7]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '8',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][8]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '9',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][9]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '10',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][10]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '11',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][11]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '12',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][12]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '13',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][13]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '14',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][14]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '15',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][15]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '16',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][16]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '17',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][17]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '18',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][18]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '19',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][19]['name_th']}')),
//                                                           // DropdownMenuItem(
//                                                           //     value: '20',
//                                                           //     child: Text(
//                                                           //         '${snapshot.data!['data'][20]['name_th']}')),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 15),
//                                                 Center(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     // child: Text(
//                                                     //   '${snapshot.data!['data'][index]['name_th']}',
//                                                     //   style: primaryTextStyle
//                                                     //       .copyWith(
//                                                     //           fontSize: 16,
//                                                     //           fontWeight:
//                                                     //               medium),
//                                                     // ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 0),
//                                                 // Center(
//                                                 //   child: Padding(
//                                                 //     padding:
//                                                 //         const EdgeInsets.all(
//                                                 //             8.0),
//                                                 //     child: Text(
//                                                 //       'เนื้อหาข่าว : ${snapshot.data!['data'][index]['blog_detail']}',
//                                                 //       style: primaryTextStyle
//                                                 //           .copyWith(
//                                                 //               fontSize: 15,
//                                                 //               fontWeight:
//                                                 //                   medium),
//                                                 //     ),
//                                                 //   ),
//                                                 // ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//               // return ListView.separated(
//               //     itemBuilder: (context, index) {
//               // return Text('3232');
//               // return CarouselSlider.builder(
//               //   itemCount: snapshot.data!['data'].length,
//               //   options: CarouselOptions(
//               //     autoPlay: true,
//               //     enlargeCenterPage: true,
//               //     viewportFraction: 0.9,
//               //     aspectRatio: 2.0,
//               //     initialPage: 2,
//               //     onPageChanged: (index, reason) {
//               //       setState(
//               //         () {
//               //           _currentIndex = index;
//               //         },
//               //       );
//               //     },
//               //   ),
//               //   itemBuilder:
//               //       (BuildContext context, int item, int pageViewIndex) =>

//               //           // Text('${snapshot.data!['data'][item]['blog_id']}');
//               //           //     Container(
//               //           //   child: Center(child: Text(item.toString())),
//               //           //   color: Colors.green,
//               //           // ),
//               //           NeumorphicButton(
//               //     style: NeumorphicStyle(
//               //       shape: NeumorphicShape.flat,
//               //       // boxShape:
//               //       //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
//               //       // boxShape: NeumorphicBoxShape.circle(),
//               //       color: Colors.white,
//               //     ),
//               //     padding: EdgeInsets.all(0),
//               //     child: Container(
//               //       height: 20,
//               //       child: Card(
//               //         margin: EdgeInsets.only(
//               //           top: 10.0,
//               //           bottom: 10.0,
//               //         ),
//               //         elevation: 6.0,
//               //         // shadowColor: Colors.redAccent,
//               //         // shape: RoundedRectangleBorder(
//               //         //     // borderRadius: BorderRadius.circular(30.0),
//               //         //     ),
//               //         child: ClipRRect(
//               //           borderRadius: BorderRadius.all(
//               //             Radius.circular(3.0),
//               //           ),
//               //           child: Stack(
//               //             children: <Widget>[
//               //               Image.network(
//               //                 snapshot.data!['data'][item]['blog_images'] !=
//               //                         null
//               //                     ? snapshot.data!['data'][item]['blog_images']
//               //                         [0]['blogi_path_name']
//               //                     : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
//               //                 fit: BoxFit.cover,
//               //                 width: double.infinity,
//               //               ),
//               //               Center(
//               //                 child: Text(
//               //                   // '${titles[_currentIndex]}',
//               //                   '${snapshot.data!['data'][item]['blog_name']}',
//               //                   style: TextStyle(
//               //                     fontSize: 24.0,
//               //                     fontWeight: FontWeight.bold,
//               //                     backgroundColor: Colors.black45,
//               //                     color: Colors.white,
//               //                   ),
//               //                 ),
//               //               ),
//               //             ],
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // );
//             } else if (snapshot.hasError) {
//               return Center(
//                   child: Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
//             }

//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }

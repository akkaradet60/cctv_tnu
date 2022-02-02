import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'dart:io';
import 'package:cctv_tun/widgets/custom_button.dart';
import 'package:cctv_tun/widgets/custom_buttonmenu.dart';
import 'package:cctv_tun/widgets/menus_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class compose_page extends StatefulWidget {
  compose_page({Key? key}) : super(key: key);

  @override
  _compose_page createState() => _compose_page();
}

class _compose_page extends State<compose_page>
    with SingleTickerProviderStateMixin {
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

  List<Marker> myMarker = [];
  final tabList = [
    'ร้องเรียน',
    'ร้องเรียนของท่าน',
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  late Map<String, dynamic> imgSlide;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/emergency/restful/?em_app_id=${Global.app_id}&em_category=2&em_user_id=${Global.user_id}');
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

  Future<void> compose_page(Map formValues) async {
    //formValues['name']
    // print(formValues);
    try {
      var url =
          'https://www.bc-official.com/api/app_nt/api/app/emergency/restful/';
      var response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Global.token}'
      },
          // body: json.encode({
          //   "firstname": formValues['firstname'],
          //   "lastname": formValues['lastname'],
          //   "email": formValues['email'],
          //   "password": formValues['password']
          // }));
          body: {
            "em_app_id": Global.app_id,
            "em_user_id": '1',
            "em_detail": formValues['em_detail'],
            "em_phone": formValues['em_phone'],
            "em_type": formValues['em_type'],
            "em_owner": formValues['em_owner'],
            "em_lat": '12.00',
            "em_lng": '13',
            "em_location": '12-13',
            "em_category": '1',
            "em_location": '$position',

            // "emi_path_name[]": formValues['emi_path_name']
            // "user_app_id": Global.app_id,
            // "user_card_id": '1471200',
            // "user_firstname": formValues['firstname'],
            // "user_lastname": formValues['lastname'],
            // "user_email": formValues['email'],
            // "user_pass": formValues['password']
          });
      Map<String, dynamic> feedback = json.decode(response.body);

      if (response.statusCode == 201) {
        Alert(
          context: context,
          // title: "แจ้งเตือน",
          type: AlertType.success,
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login_page'),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();

        //กลับไปที่หน้า LoginPage
        // Future.delayed(const Duration(seconds: 5), () {
        //   // Navigator.pop(context);
        //    Navigator.pop(context, '/login');
        // });
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          // title: "แจ้งเตือน",
          desc: '${feedback['data']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: ThemeBc.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        ).show();
      }
    } catch (e) {
      // print(e);
    }
  }

  late String position = 'ไม่ได้เลือก';
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    Widget composepage() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _fbKey,
              // initialValue: {'name': '', 'email': '', 'password': ''},
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FormBuilderDropdown(
                          name: "em_type",

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            suffixIcon: Icon(Icons.article),
                            //labelText: 'เลือกประเภทร้องเรียน',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          // initialValue: 'Male',
                          //allowClear: true,
                          hint: Text('เลือกประเภทร้องเรียน'),

                          initialValue: '1',
                          items: [
                            DropdownMenuItem(
                              value: '1',
                              child: Text('ไฟฟ้าดับ'),
                            ),
                            DropdownMenuItem(
                                value: '2', child: Text('น้ำประปาไม่ไหล')),
                            DropdownMenuItem(
                                value: '3', child: Text('แจ้งซ่อมทางเดินเท้า')),
                            DropdownMenuItem(
                                value: '4', child: Text('แจ้งซ่อมถนน')),
                            DropdownMenuItem(
                                value: '5',
                                child: Text('เรื่องร้องเรียนฝาท่อ')),
                            DropdownMenuItem(
                                value: '6', child: Text('ขยะไม่ได้รับกำจัด')),
                            DropdownMenuItem(
                                value: '7', child: Text('ได้รับการบริการ')),
                            DropdownMenuItem(
                                value: '8',
                                child: Text('หน้าที่ที่ไม่เหมาะสม')),
                            DropdownMenuItem(value: '9', child: Text('อื่นๆ')),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FormBuilderTextField(
                          name: "em_owner",
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            suffixIcon: Icon(Icons.email),
                            labelText: 'ชื่อผู้แจ้ง',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FormBuilderTextField(
                          name: "em_phone",
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            suffixIcon: Icon(Icons.phone_android),
                            labelText: 'เบอร์โทรศัพท์',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FormBuilderTextField(
                          name: "em_detail",
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            suffixIcon: Icon(Icons.description),
                            labelText: 'รายละเอียดเหตุการณ์',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ), //รายละเอียดเหตุการณ์
                  ),
                  SizedBox(height: 18),
                  Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 7,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 4),
                              blurRadius: 7.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('อัพโหลดรูปภาพ'),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ThemeBc.white,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                      boxShadow: []),
                                  width: 350,
                                  height: 240,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        selectedImage == null
                                            ? IconButton(
                                                icon: Icon(Icons.add_a_photo),
                                                tooltip: 'Show Snackbar',
                                                onPressed: getImage,
                                              )
                                            : Container(
                                                height: 200,
                                                child: ListView(
                                                  children: [
                                                    Container(
                                                        height: 100,
                                                        child: Image.file(
                                                            selectedImage!)),
                                                  ],
                                                ),
                                              ),
                                        // Text(resJson),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Container(
                      //   child: FormBuilderImagePicker(
                      //     name: 'emi_path_name',
                      //     iconColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //           20.0,
                      //         ),
                      //       ),
                      //       labelText: 'ภาพประกอบเหตุการ',
                      //       filled: true,
                      //     ),
                      //     maxImages: 1,
                      //   ),
                      // ),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(
                  //         20,
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             offset: Offset(2, 2),
                  //             blurRadius: 7,
                  //             spreadRadius: 1.0),
                  //         BoxShadow(
                  //             color: Colors.black.withOpacity(0.5),
                  //             offset: Offset(2, 4),
                  //             blurRadius: 7.0,
                  //             spreadRadius: 1.0),
                  //       ]),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       child: FormBuilderImagePicker(
                  //         name: 'emi_path_name',
                  //         iconColor: Colors.black,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(
                  //               20.0,
                  //             ),
                  //           ),
                  //           labelText: 'ภาพประกอบเหตุการ',
                  //           filled: true,
                  //         ),
                  //         maxImages: 1,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 18),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                          color: secondaryTextColor,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 7,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 4),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ]),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.only(
                        top: 0,
                      ),
                      height: 300.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: _getLocation(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              _handletap(LatLng tappedPoint) {
                                position = '$tappedPoint';
                                setState(() {
                                  myMarker = [];
                                  myMarker.add(Marker(
                                    markerId: MarkerId(tappedPoint.toString()),
                                    position: tappedPoint,
                                  ));
                                });
                                return position;
                              }

                              return Column(
                                children: [
                                  Container(
                                    height: 280,
                                    child: GoogleMap(
                                      markers: Set.from(myMarker),
                                      onTap: _handletap,
                                      mapType: MapType.normal,
                                      onMapCreated: _onMapCreated,
                                      myLocationEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(userLocation.latitude,
                                              userLocation.longitude),
                                          zoom: 15),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(3.0),
                                  //   child: Container(
                                  //     width: 400,
                                  //     decoration: BoxDecoration(
                                  //       color: ThemeBc.white,
                                  //       borderRadius: BorderRadius.circular(
                                  //         20,
                                  //       ),
                                  //     ),
                                  //     // child: Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Text(
                                  //         'ขยายหน้าจอ',
                                  //         style: TextStyle(
                                  //           fontSize: 15.0,
                                  //           fontWeight: FontWeight.bold,
                                  //           // backgroundColor: Colors.black45,
                                  //           color: ThemeBc.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: ThemeBc.black,
                                  //     borderRadius:
                                  //         BorderRadius.circular(
                                  //       20,
                                  //     ),
                                  //   ),
                                  //   child: IconButton(
                                  //       icon: Icon(
                                  //         Icons.map,
                                  //         color: ThemeBc.white,
                                  //         size: 30.0,
                                  //       ),
                                  //       // Image.asset(
                                  //       //   'assets/fi_home.png',
                                  //       //   scale: 1,
                                  //       // ),
                                  //       tooltip: 'Show Snackbar',
                                  //       onPressed: () {
                                  //         showDialog(
                                  //           context: context,
                                  //           builder: (context) {
                                  //             return AlertDialog(
                                  //               content: Text(
                                  //                   'ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} '),
                                  //             );
                                  //           },
                                  //         );
                                  //       }),
                                  // ),
                                  //   ],
                                  // ),
                                  //   ),
                                  // ),
                                ],
                              );
                            } else {
                              return Center(
                                  // child: Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     CircularProgressIndicator(),
                                  //   ],
                                  // ),
                                  );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                          color: secondaryTextColor,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 7,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 4),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ตำแหน่ง ! \nตำแหน่งที่คุณเลือก : $position',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                // backgroundColor: Colors.black45,
                                color: ThemeBc.black,
                              ),
                            ),
                          ),
                        ],
                      )),
                  ElevatedButton.icon(
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(userLocation.latitude, userLocation.longitude),
                          18));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'ตำแหน่งของคุณ !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} '),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.gps_fixed),
                    label: Text('ตำแหน่งของคุณ'),
                    style: ElevatedButton.styleFrom(
                      primary: ThemeBc.background,
                      onPrimary: Colors.white,
                      shadowColor: Colors.grey[700],
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    margin: EdgeInsets.only(top: 0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: 'แจ้งเหตุร้องเรียง',
                          onPressed: () {
                            if (_fbKey.currentState!.saveAndValidate()) {
                              //  print(_fbKey.currentState!.value);
                              compose_page(_fbKey.currentState!.value);
                            }
                          },
                          colorButton: ThemeBc.background,
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
        ),
      );
    }

    Widget composepagedetail() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        width: 1000,
        height: 500,
        child: ListView(
          children: [
            SizedBox(height: 5),
            Container(
              width: 1000,
              height: 500,
              child: FutureBuilder<Map<String, dynamic>>(
                future: getDataSlide(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!['data'].length,
                      itemBuilder: (context, index) {
                        var datanill = snapshot.data!['data'];
                        print(snapshot.data!['data'].length);
                        var em_detaail;
                        if (datanill == 'ไม่พบข้อมูล') {
                          em_detaail = 'ไม่พบข้อมูล';
                          return Text('');
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: secondaryTextColor,
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: Offset(2, 2),
                                        blurRadius: 7,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(2, 4),
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0),
                                  ]),
                              height: 80,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${snapshot.data!['data'][index]['em_type']}',
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontSize: 18,
                                                            fontWeight: medium),
                                                  ),
                                                ],
                                              ),
                                              trailing: Container(
                                                width: 80,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    children: [
                                                      //         .callNumber(number);},

                                                      SizedBox(width: 5),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: Container(
                                                          height: 40,
                                                          child: ElevatedButton
                                                              .icon(
                                                            onPressed: () =>
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/composedetail_page',
                                                                    arguments: {
                                                                  'em_owner': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_owner'],
                                                                  'em_detail': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_detail'],
                                                                  'em_images': snapshot.data!['data'][index]
                                                                              [
                                                                              'em_images'] !=
                                                                          null
                                                                      ? Global.domainImage +
                                                                          snapshot.data!['data'][index]['em_images'][0]
                                                                              [
                                                                              'emi_path_name']
                                                                      : 'https://boychawins.com/blogs/images/17641500_1623653406.jpeg',
                                                                  'em_phone': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_phone'],
                                                                  'em_lat': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_lat'],
                                                                  'em_lng': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_lng'],
                                                                  'em_location':
                                                                      snapshot.data!['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'em_location'],
                                                                  'em_type': snapshot
                                                                              .data!['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'em_type'],
                                                                }),
                                                            icon: Icon(
                                                              Icons
                                                                  .maps_home_work,
                                                              color:
                                                                  Colors.pink,
                                                              size: 30,
                                                            ),
                                                            label: Text(''),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  Colors.orange,
                                                              elevation: 10,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
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
        backgroundColor: ThemeBc.background,
        title: Center(child: const Text('ร้องเรียน')),
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
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          // indicator: PointTabIndicator(
          //   position: PointTabIndicatorPosition.bottom,
          //   color: white,
          //   insets: EdgeInsets.only(bottom: 6),
          // ),
          tabs: tabList.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: TabBarView(
          controller: _tabController,
          children: tabList.map((item) {
            if (item == 'ร้องเรียน') {
              return composepage();
            } else {
              return composepagedetail();
            }

            // print(item);
            // return Center(child: Text(item));
          }).toList(),
        ),
      ),
    );
  }
}

/* Widget imageSplash() {
      return Container();
      /* return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_box_outlined),
                  labelText: 'ชื่อผู้แจ้ง',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  labelText: 'เบอร์โทรสัพ',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(''),
            ),
            Material(
              elevation: 18,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.align_horizontal_left),
                  labelText: 'รายละเอียดเหตุการณ์',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      );*/
    }

    Widget textimport() {
      return FormBuilder(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Text(''),
                    ),
                  ],
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.account_box_outlined),
                      labelText: 'ชื่อผู้แจ้ง',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Text(''),
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      labelText: 'เบอร์โทรสัพ',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Text(''),
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.align_horizontal_left),
                      labelText: 'รายละเอียดเหตุการณ์',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget titleMenus() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: defaultMargin),
        child: Text(
          'เลือกประเภทการแจ้งเหตุ',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget balanceCard() {
      return FormBuilder(
        child: SafeArea(
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: defaultMargin),
                    MenusCustom(
                      iconMenus: 'assets/warn/01.png',
                      titleMenus: 'ผู้ป่วยฉุกเฉิน',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/02.png',
                      titleMenus: 'ไฟฟ้ารั่ว',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/03.png',
                      titleMenus: 'ไฟไหม้',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/04.png',
                      titleMenus: 'เหตุระเบิด',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/05.png',
                      titleMenus: 'อุบัติเหตุ',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                    SizedBox(width: 15),
                    MenusCustom(
                      iconMenus: 'assets/warn/06.png',
                      titleMenus: 'อาชญากรรม',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    SizedBox(width: defaultMargin),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        height: 80,
        margin: EdgeInsets.only(top: 20, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonmenu(
              title: 'แจ้งเหตุฉุกเฉิน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: buttonGreyColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
            SizedBox(width: 10),
            CustomButtonmenu(
              title: 'เหตุฉุกเฉินของท่าน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: primaryColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget buttonimagee() {
      return FormBuilder(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: defaultMargin),
                MenusCustom(
                  iconMenus: 'assets/warn/07.png',
                  titleMenus: '',
                  pathName: '/message',
                  titleMenus1: '',
                  titleMenus2: '',
                ),
                SizedBox(width: defaultMargin),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      );
    }

   /* Widget map() {
      Future<Position> _getLocation() async {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        userLocation = await Geolocator.getCurrentPosition();
        return userLocation;
      }

      LatLng latLng = LatLng(16.44544, 102.82839);
      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16.0,
      );
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: EdgeInsets.only(
          top: 0,
        ),
        height: 300.0,
        child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      );
    }

    Widget textphotoevent() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: defaultMargin),
        child: Text(
          'ภาพเหตุการณ์',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget textscene() {
      return FormBuilder(
        child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "เพิ่มเติม",
                      labelText: "จุดเกิดเหตุ",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  maxLength: 100,
                  maxLines: 2,
                ),
              ],
            )),
      );
    }

    Widget button1() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'แจ้งเหตุฉุกเฉิน',
              onPressed: () => Navigator.pushNamed(context, '/warn'),
              colorButton: buttonGreyColor,
              textStyle:
                  secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ],
        ),
      );
    }*/*/

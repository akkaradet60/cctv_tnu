import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'dart:io';
import 'package:cctv_tun/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class warn_page extends StatefulWidget {
  warn_page({Key? key}) : super(key: key);

  @override
  _warn1State createState() => _warn1State();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _warn1State extends State<warn_page> with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final tabList = [
    'แจ้งเหตุฉุกเฉิน',
    'เหตุฉุกเฉินของท่าน',
  ];

  late TabController _tabController;

  double? lat, lng;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  var selectedImage;
  var resJson = '1';
  var profilee;
  var newProfile;
  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newProfile = json.decode(prefs.getString('profile').toString());
    //call redux action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    //กลับไปที่หน้า Login
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }

  late Map<String, dynamic> imgSlide;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/emergency/restful/?em_user_id=${Global.user_id}&em_app_id=${Global.app_id}&em_category=1');
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

  var em_location = 'ยังไม่ได้เลือก';
  Future<void> addEmergecy(Map formValues) async {
    int index = 0;
    //formValues['name']
    // print(formValues);
    try {
      if (formValues['em_detail'] != null &&
          formValues['em_phone'] != null &&
          formValues['em_phone'] != null &&
          formValues['em_owner'] != null &&
          formValues['em_location'] != null &&
          formValues['em_type'] != null) {
        var url = Uri.parse(Global.urlWeb + 'api/app/emergency/restful/');
        var request = http.MultipartRequest('POST', url)
          ..fields['em_app_id'] = Global.app_id
          ..fields['em_user_id'] = Global.user_id ?? ''
          ..fields['em_detail'] = formValues['em_detail']
          ..fields['em_phone'] = formValues['em_phone']
          ..fields['em_owner'] = formValues['em_owner']
          ..fields['em_lat'] = '1'
          ..fields['em_lng'] = '1'
          ..fields['em_location'] = em_location
          ..fields['em_category'] = '1'
          ..fields['em_type'] = formValues['em_type'];

        Map<String, String> headers = {
          "Accept": "application/json",
          "Content-type": "multipart/form-data",
          "Authorization":
              'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
        };

        for (XFile item in formValues['emi_path_name'] ?? []) {
          request.files.add(
              await http.MultipartFile.fromPath('emi_path_name[]', item.path));
          index++;
        }

        request.headers.addAll(headers);
        var res = await request.send();
        http.Response response = await http.Response.fromStream(res);

        var feedback = jsonDecode(response.body);

        if (response.statusCode == 201) {
          Alert(
            context: context,
            // title: "แจ้งเตือน",
            type: AlertType.success,
            desc: '${profilee['data']}',
            buttons: [
              DialogButton(
                child: Text(
                  "ปิด",
                  style: TextStyle(color: ThemeBc.white, fontSize: 18),
                ),
                onPressed: () {},
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
            desc: '${profilee['data']}',
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
      } else {}
    } catch (e) {
      // print(e);
    }
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

  late Position userLocation;
  // late GoogleMapController mapController;
  late String position = 'ยังไม่ได้เลือก';

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // Future<Position> _getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   userLocation = await Geolocator.getCurrentPosition();
  //   return userLocation;
  // }

  // List<Marker> myMarker = [];
  @override
  Widget build(BuildContext context) {
    Widget warnpage() {
      return Container(
        height: 1000,
        width: 1000,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.white, ThemeBc.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                // 'em_detail': '',
                // 'em_phone': '',
                // 'em_type': '',
                // 'em_owner': '',
                // 'emi_path_name': '',
              },
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
                            // labelText: 'เลือกประเภทการแจ้งเหตุ',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          // initialValue: 'Male',
                          //allowClear: true,
                          hint: Text('เลือกประเภทการแจ้งเหตุ'),

                          initialValue: '1',
                          items: [
                            DropdownMenuItem(
                              value: '1',
                              child: Text('ผู้ป่วยฉุกเฉิน'),
                            ),
                            DropdownMenuItem(
                                value: '2', child: Text('ไฟฟ้ารั่ว')),
                            DropdownMenuItem(value: '3', child: Text('ไฟไหม้')),
                            DropdownMenuItem(
                                value: '4', child: Text('เหตุระเบิด')),
                            DropdownMenuItem(
                                value: '5', child: Text('อุบัติเหตุ')),
                            DropdownMenuItem(
                                value: '6', child: Text('อาชญากรรม')),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  // Material(
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
                            //   labelStyle: TextStyle(
                            //   color: Color(0xFF6200EE),
                            // ),
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
                  // Container(
                  //   width: 400,
                  //   height: 300,
                  //   decoration: BoxDecoration(
                  //       color: secondaryTextColor,
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
                  //     child: ListView(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(5.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text('อัพโหลดรูปภาพ'),
                  //             ],
                  //           ),
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     color: ThemeBc.white,
                  //                     borderRadius: BorderRadius.circular(
                  //                       20,
                  //                     ),
                  //                     boxShadow: []),
                  //                 width: 350,
                  //                 height: 240,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: <Widget>[
                  //                       selectedImage == null
                  //                           ? IconButton(
                  //                               icon: Icon(Icons.add_a_photo),
                  //                               tooltip: 'Show Snackbar',
                  //                               onPressed: getImage,
                  //                             )
                  //                           : Container(
                  //                               height: 200,
                  //                               child: ListView(
                  //                                 children: [
                  //                                   Container(
                  //                                       height: 100,
                  //                                       child: Image.file(
                  //                                           selectedImage!)),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                       // Text(resJson),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),

                  //     Container(
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
                  // //   ),
                  // ),
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
                      child: FormBuilderImagePicker(
                        name: 'emi_path_name',
                        displayCustomType: (obj) =>
                            obj is ApiImage ? obj.imageUrl : obj,
                        iconColor: Colors.black,
                        decoration: InputDecoration(
                          suffixIconColor: ThemeBc.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          labelText: 'ภาพ',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        maxImages: 5,
                        onSaved: (val) {
                          print(val);
                        },
                      ),
                    ),
                  ),
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
                        child: Container(
                          height: 500,
                          child: Column(
                            children: [
                              Flexible(
                                  child: FlutterMap(
                                options: MapOptions(
                                    center: LatLng(
                                        16.186348810730625, 103.30025897021274),
                                    zoom: 16),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'],
                                    attributionBuilder: (_) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("มหาสารคาม"),
                                      );
                                    },
                                  ),
                                  // MarkerLayerOptions(markers: [
                                  //   Marker(
                                  //     point: LatLng(16.186348810730625,
                                  //         103.30025897021274),
                                  //     builder: (ctx) =>
                                  //         const Icon(Icons.pin_drop),
                                  //   )
                                  // ]),
                                ],
                              ))
                            ],
                          ),
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
                  SizedBox(height: 10),

                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     // mapController.animateCamera(CameraUpdate.newLatLngZoom(
                  //     //     LatLng(userLocation.latitude, userLocation.longitude),
                  //     //     18));
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           content: Text(
                  //               'ตำแหน่ง !\nละติจูด : ${userLocation.latitude} ลองจิจูด : ${userLocation.longitude} ตำแหน่งที่คุณเลือก : $position'),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   icon: Icon(Icons.gps_fixed),
                  //   label: Text('ตำแหน่งของคุณ'),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: ThemeBc.background,
                  //     onPrimary: Colors.white,
                  //     elevation: 30,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(40))),
                  //   ),
                  // ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    margin: EdgeInsets.only(top: 0, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: 'แจ้งเหตุฉุกเฉิน',
                          onPressed: () {
                            if (_fbKey.currentState!.saveAndValidate()) {
                              print(_fbKey.currentState!.value);
                              addEmergecy(_fbKey.currentState!.value);
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

    Widget warndetaikpage() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeBc.white, ThemeBc.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        width: 1000,
        height: 1000,
        child: ListView(
          children: [
            SizedBox(height: 5),
            Container(
              width: 1000,
              height: 1000,
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
        title: Center(child: const Text('แจ้งเหตุฉุกเฉิน')),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              if (_fbKey.currentState!.saveAndValidate()) {
                // print(_fbKey.currentState.value);
                addEmergecy(_fbKey.currentState!.value);
              }
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
            if (item == 'แจ้งเหตุฉุกเฉิน') {
              return warnpage();
            } else {
              return warndetaikpage();
            }

            // print(item);
            // return Center(child: Text(item));
          }).toList(),
        ),
      ),
    );
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
                  fillCsEdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
  }
}

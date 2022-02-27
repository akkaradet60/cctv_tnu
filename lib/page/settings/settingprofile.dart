import 'dart:convert';
import 'dart:io';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:cctv_tun/widgets/text_FormBuilderField.dart';
import 'package:cctv_tun/widgets/warn_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

//upload image
import 'package:image_picker/image_picker.dart';

class settingprofile extends StatefulWidget {
  @override
  _settingprofile createState() => _settingprofile();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _settingprofile extends State<settingprofile>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _getProv();
  }

  var newProfile;
  // var oi = 'ssss';
  var profilee;

  @override
  Widget build(BuildContext context) {
    // print('=>  $selectedImage');
    Widget proFilePage() {
      final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

      var _data;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text('เลือกประเภทการแจ้งเหตุ',
              //     style: TextStyle(fontSize: 15)),
              // const Divider(),
              // const SizedBox(height: 40),
              FormBuilder(
                key: _fbKey,
                // initialValue: const {},
                // autovalidateMode: AutovalidateMode
                //     .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                child: Column(
                  children: <Widget>[
                    //   Text('${profilee['user_firstname']}'),
                    Center(
                      child: StoreConnector<AppState, Map<String, dynamic>>(
                        distinct: true,
                        converter: (store) => store.state.profileState.profile,
                        builder: (context, profile) {
                          var imageData;

                          if (profile['user_image'] != null &&
                              profile['user_image_check'] == '1') {
                            imageData = Global.urlFile2 + profile['user_image'];
                          } else if (profile['user_image'] != null &&
                              profile['user_image_check'] == '2') {
                            imageData = Global.networkImage;
                          }
                          print(profile['user_image']);
                          _prov = profile['user_prov'];
                          _dis = profile['user_dis'];
                          _sub = profile['user_sub'];

                          _adddess = profile['user_address'];
                          _zibcode = profile['user_zip_code'];
                          _lat = profile['user_lastname'];
                          _fir = profile['user_firstname'];
                          _email = profile['user_email'];

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    selectedImage == null
                                        ? Container(
                                            child: profile['user_image'] != null
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color: ThemeBc.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          20,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 7,
                                                              spreadRadius:
                                                                  1.0),
                                                        ]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                              imageData,
                                                              width: 200,
                                                              height: 200,
                                                              fit: BoxFit.fill),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Image.network(
                                                    selectedImage != null
                                                        ? Global.urlFile2 +
                                                            imageData
                                                        : Global.networkImage,
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.fill),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: ThemeBc.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      spreadRadius: 1.0),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.file(selectedImage!,
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: ThemeBc.black,
                                    size: 24.0,
                                  ),
                                  // Image.asset(
                                  //   'assets/fi_home.png',
                                  //   scale: 1,
                                  // ),
                                  tooltip: 'Show Snackbar',
                                  onPressed: getImage,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FormBuilderFieldText(
                                  name: 'user_firstname',
                                  labelText: 'ชื่อ',
                                  icon: Icons.description,
                                  initialValue: '${profile['user_firstname']}'),
                              SizedBox(height: 10),
                              FormBuilderFieldText(
                                  name: 'user_lastname',
                                  labelText: 'นามสกุล',
                                  icon: Icons.description,
                                  initialValue: '${profile['user_lastname']}'),
                              const SizedBox(height: 10),
                              FormBuilderFieldText(
                                  name: 'user_card_id',
                                  labelText: 'รหัสบัตรประจำประชาชน',
                                  icon: Icons.description,
                                  initialValue: '${profile['user_card_id']}'),
                              const SizedBox(height: 10),
                              FormBuilderFieldText(
                                  name: 'user_email',
                                  labelText: 'อีเมล',
                                  icon: Icons.description,
                                  initialValue: '${profile['user_email']}'),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderDropdown(
                                    name: 'user_prov',
                                    initialValue: _myState,
                                    // initialValue: _myState != null
                                    //     ? _myState
                                    //     : profile['user_prov'] != '0' &&
                                    //             profile['user_prov'] != null
                                    //         ? profile['user_prov']
                                    //         : _myState,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      labelText: 'เลือกจังหวัด',
                                    ),
                                    allowClear: true,
                                    hint: profile['user_prov'] != null
                                        ? Text(profile['prov'])
                                        : Text('เลือกจังหวัด'),
                                    onChanged: (value) {
                                      setState(() {
                                        _myState = value as String?;
                                        disList = [];
                                        _myDis = null;

                                        subList = [];
                                        _mySub = null;

                                        _getDis();
                                      });
                                    },
                                    items: statesList.map((item) {
                                      return new DropdownMenuItem(
                                        // value: '1', child: Text('ผู้ป่วยฉุกเฉิน')
                                        child: new Text(item['name_th']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderDropdown(
                                    name: 'user_dis',
                                    initialValue: _myDis,
                                    // = null
                                    //     ? _myDis
                                    //     : profile['user_dis'] != '0' &&
                                    //             profile['user_dis'] != null
                                    //         ? profile['user_dis'].toString()
                                    //         : _myDis,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      labelText: 'เลือกอำเภอ',
                                    ),
                                    allowClear: true,
                                    hint: profile['user_dis'] != null
                                        ? Text(profile['dis'])
                                        : Text('เลือกอำเภอ'),
                                    onChanged: (value) {
                                      setState(() {
                                        _myDis = value as String?;
                                        subList = [];
                                        _mySub = null;
                                        _getSub();
                                      });
                                    },
                                    items: disList.map((item) {
                                      return new DropdownMenuItem(
                                        // value: '1', child: Text('ผู้ป่วยฉุกเฉิน')
                                        child: new Text(item['name_th']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderDropdown(
                                    name: 'user_sub',
                                    initialValue: _mySub,
                                    // = null && _mySub == ''
                                    //     ? _mySub
                                    //     : profile['user_sub'] != '0' &&
                                    //             profile['user_sub'] != null
                                    //         ? profile['user_sub'].toString()
                                    //         : _mySub,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      labelText: 'เลือกตำบล',
                                    ),
                                    allowClear: true,
                                    hint: profile['user_sub'] != null
                                        ? Text(profile['sub'])
                                        : Text('เลือกตำบล'),
                                    onChanged: (value) {
                                      setState(() {
                                        _mySub = value as String?;
                                        zip_code = null;
                                        _getZipCode();
                                      });
                                    },
                                    items: subList.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name_th']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderFieldText(
                                  name: 'user_address',
                                  labelText: 'ที่อยู่',
                                  icon: Icons.description,
                                  initialValue: '${profile['user_address']}'),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: ThemeBc.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: FormBuilderTextField(
                                      initialValue: zip_code != null
                                          ? zip_code
                                          : profile['user_zip_code'] != '0' &&
                                                  profile['user_zip_code'] !=
                                                      null
                                              ? profile['user_zip_code']
                                                  .toString()
                                              : zip_code,
                                      name: "user_zip_code",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'รหัสไปรษณีย์',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),
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
                                        // print(_fbKey.currentState.value);
                                        updataUser(_fbKey.currentState!.value);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.description,
                                      color: ThemeBc.black,
                                    ),
                                    label: Text(
                                      'แก้ไขข้อมูล',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        // backgroundColor: Colors.black45,
                                        color: ThemeBc.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: ThemeBc.white,
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.grey[700],
                                      elevation: 30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      // drawer: manu(),
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Column(
          children: [
            Text('แก้ไขข้อมูลส่วนตัว'),
          ],
        ),
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
  var _prov;
  var _dis;
  var _sub;
  var _adddess;
  var _zibcode;
  var _lat;
  var _fir;
  var _email;

  Future<void> updataUser(Map formValues) async {
    try {
//=======  check data ==========

      var provData = formValues['user_prov'] ?? _prov;
      var disData = formValues['user_dis'] ?? _dis;
      var subData = formValues['user_sub'] ?? _sub;

      var addressData = formValues['user_address'] ?? _adddess;
      var zibCodeData = formValues['user_zip_code'] ?? _zibcode;
      var latData = formValues['user_lastname'] ?? _lat;
      var firData = formValues['user_firstname'] ?? _fir;
      var emailData = formValues['user_email'] ?? _email;

      var url = Uri.parse(Global.urlWeb +
          'api/profile/restful/?user_id=${Global.user_id}&user_app_id=${Global.app_id}');
      var request = http.MultipartRequest('POST', url)
        ..fields['user_app_id'] = Global.app_id
        ..fields['user_id'] = Global.user_id
        ..fields['user_prov'] = provData
        ..fields['user_dis'] = disData
        ..fields['user_sub'] = subData
        ..fields['user_address'] = addressData
        ..fields['user_zip_code'] = zibCodeData
        ..fields['user_lastname'] = latData
        ..fields['user_firstname'] = firData
        ..fields['user_status'] = '1'
        ..fields['user_email'] = emailData;

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-type": "multipart/form-data",
        "Authorization":
            'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
      };

      if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'user_image', selectedImage.path));
      }

      request.headers.addAll(headers);
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);

      var feedback = jsonDecode(response.body);

      if (feedback['data'] == "สำเร็จ") {
        getProfile();
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
              title: '${feedback['data']}',
            );
          },
        );
      }
    } catch (e) {
      // print(e);
    }
  }

  //====================== update upload image  ===============================
  var selectedImage;

  Future getImage() async {
    //var image = await ImagePicker().getImage(source: ImageSource.gallery);
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
      }
    });
  }

  //====================== update reduct  ===============================
  Future<void> getProfile() async {
    var profileUrl = Global.urlWeb +
        'api/profile/restful?user_id=${Global.user_id}&user_app_id=${Global.app_id}';
    var responseProfile = await http.get(Uri.parse(profileUrl),
        headers: {'Authorization': 'Bearer ${Global.token}'});
    var profile = json.decode(responseProfile.body);

//update reduct user
    var user = profile['data'][0];
    var newProfile = jsonDecode(jsonEncode(user));

//setString
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile', jsonEncode(user));

    //call redux action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
  }

  //================================== GET Api  Users =============================================

  List statesList = [
    {
      "id": "0",
      "code": "0",
      "name_th": "ไม่พบข้อมูล",
      "name_en": "Bangkok",
      "geography_id": "2",
      "active": ""
    },
  ];
  String? _myState;
  //================================== GET Api  province =============================================
  Future<void> _getProv() async {
    String stateInfoUrl =
        Global.urlWeb + 'api/country/province/restful/?app_id=${Global.app_id}';

    await http.get(Uri.parse(stateInfoUrl),
        headers: {'Authorization': 'Bearer ${Global.token}'}).then((response) {
      var data = json.decode(response.body);

      if (data['data'] != "ไม่พบข้อมูล") {
        setState(() {
          statesList = data['data'];
        });
      }
    });
  }

  //================================== GET Api  dis =============================================
  List disList = [];
  String? _myDis;

  Future<void> _getDis() async {
    String url = Global.urlWeb +
        'api/country/amphure/restful/?app_id=${Global.app_id}&province_id=${_myState}';

    await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${Global.token}'}).then((response) {
      var dataDis = json.decode(response.body);

      if (dataDis['data'] != "ไม่พบข้อมูล") {
        setState(() {
          disList = dataDis['data'];
        });
      }
    });
  }

  //================================== GET Api  sub =============================================
  List subList = [];
  String? _mySub;

  Future<void> _getSub() async {
    String url = Global.urlWeb +
        'api/country/district/restful/?app_id=${Global.app_id}&amphure_id=${_myDis}';

    await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${Global.token}'}).then((response) {
      var dataSub = json.decode(response.body);

      if (dataSub['data'] != "ไม่พบข้อมูล") {
        setState(() {
          subList = dataSub['data'];
        });
      }
    });
  }
  //================================== GET Api  zip_code =============================================

  String? zip_code;

  Future<void> _getZipCode() async {
    String url2 = Global.urlWeb +
        'api/country/district/restful/?app_id=${Global.app_id}&id=${_mySub}';

    await http.get(Uri.parse(url2),
        headers: {'Authorization': 'Bearer ${Global.token}'}).then((response) {
      var json_zip = json.decode(response.body);

      print(json_zip['data'][0]['zip_code']);
      if (json_zip['data'] != "ไม่พบข้อมูล") {
        setState(() {
          zip_code = json_zip['data'][0]['zip_code'];
        });
      }
    });
  }
}

import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/widgets/warn_api.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

class settingprofile extends StatefulWidget {
  @override
  _EmergecyPageState createState() => _EmergecyPageState();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _EmergecyPageState extends State<settingprofile>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    //  getProfile();
  }

  var newProfile;
  var oi = 'ssss';
  // // List<Data> data = [];
  // Future<void> getData() async {
  //   var url = Uri.parse('https://api.codingthailand.com/api/course');
  //   var response = await http.get(url);
  //   // print(json.decode(response.body));
  //   //นำ json ใส่ที่โมเมล product
  //   final product paroduct = product.fromJson(json.decode(response.body));
  //   // print(paroduct.data);
  //   setState(() {
  //     data = paroduct.data!;
  //   });
  //   @override
  //   void initState() {
  //     super.initState();
  //     getData();
  //   }
  // }
  var profilee;
  @override
  Widget build(BuildContext context) {
    Widget emergecyPage1() {
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
                initialValue: const {},
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
                          Future<void> compose_page(Map formValues) async {
                            //formValues['name']
                            // print(formValues);

                            try {
                              var url = Global.urlWeb +
                                  'api/profile/restful?user_id=${Global.user_id}&user_app_id=${Global.app_id}';
                              var response =
                                  await http.post(Uri.parse(url), headers: {
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
                                    "user_app_id": Global.app_id,
                                    "user_id": profile['user_id'],
                                    "user_prov": formValues['user_prov'],
                                    "user_dis": formValues['user_dis'],
                                    "user_sub": formValues['user_sub'],
                                    "user_address": formValues['user_address'],
                                    "user_zip_code":
                                        formValues['user_zip_code'],
                                    "user_lastname":
                                        formValues['user_lastname'],
                                    "user_firstname":
                                        formValues['user_firstname'],
                                    // "user_card_id": formValues['user_card_id'],
                                    "user_email": formValues['user_email'],
                                    "user_status": '1',

                                    // "emi_path_name[]": formValues['emi_path_name']
                                    // "user_app_id": Global.app_id,
                                    // "user_card_id": '1471200',
                                    // "user_firstname": formValues['firstname'],
                                    // "user_lastname": formValues['lastname'],
                                    // "user_email": formValues['email'],
                                    // "user_pass": formValues['password']
                                  });
                              Map<String, dynamic> profilee =
                                  json.decode(response.body);

                              if (response.statusCode == 201) {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return warn_api(
                                      title: '${profilee['data']}',
                                    );
                                  },
                                );
                              } else {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return warn_api(
                                      title: '${profilee['data']}',
                                    );
                                  },
                                );
                              }
                            } catch (e) {
                              // print(e);
                            }
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.dozzdiy.com/wp-content/uploads/2019/01/SDI0295_1170.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),

                              const SizedBox(height: 20),
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
                                    decoration: BoxDecoration(
                                        color: secondaryTextColor,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                        boxShadow: [
                                          // BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     offset: Offset(2, 2),
                                          //     blurRadius: 7,
                                          //     spreadRadius: 1.0),
                                          // BoxShadow(
                                          //     color: Colors.black.withOpacity(0.5),
                                          //     offset: Offset(2, 4),
                                          //     blurRadius: 7.0,
                                          //     spreadRadius: 1.0),
                                        ]),

                                    child: FormBuilderTextField(
                                      initialValue:
                                          '${profile['user_firstname']}',
                                      name: "user_firstname",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'ชื่อ',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ), //รายละเอียดเหตุการณ์
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),
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
                                      initialValue:
                                          '${profile['user_lastname']}',
                                      name: "user_lastname",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'นามสกุล',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue:
                                          '${profile['user_card_id']}',
                                      name: "user_card_id",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'รหัสบัตรประจำประชาชน',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue: '${profile['user_email']}',
                                      name: "user_email",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'อีเมล',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue: '${profile['user_prov']}',
                                      name: "user_prov",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'จังหวัด',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue: '${profile['user_dis']}',
                                      name: "user_dis",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'อำเภอ',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue: '${profile['user_sub']}',
                                      name: "user_sub",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'ตำบล',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue:
                                          '${profile['user_address']}',
                                      name: "user_address",
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.description),
                                        labelText: 'ที่อยู่',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ), //รายละเอียดเหตุการณ์
                              ),

                              const SizedBox(height: 10),
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
                                      initialValue:
                                          '${profile['user_zip_code']}',
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
                                    child: FormBuilderImagePicker(
                                      name: 'emi_path_name',
                                      iconColor: Colors.black,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        labelText: 'ภาพประกอบเหตุการ',
                                        filled: true,
                                      ),
                                      maxImages: 1,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),
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
                                        compose_page(
                                            _fbKey.currentState!.value);
                                        print(_fbKey.currentState!.value);
                                      }
                                    },
                                    icon: Icon(Icons.description),
                                    label: Text('แก้ไขข้อมูล'),
                                    style: ElevatedButton.styleFrom(
                                      primary: ThemeBc.black,
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

                              // Expanded(
                              //   child: ElevatedButton.icon(
                              //     label: const Text('บันทึก'),
                              //     icon: const Icon(Icons.save),
                              //     style: ElevatedButton.styleFrom(
                              //       primary: Colors.orange,
                              //       textStyle: const TextStyle(fontSize: 15),
                              //       padding: const EdgeInsets.all(15),
                              //       shape: const RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10))),
                              //     ),
                              //     onPressed: () {
                              //       if (_fbKey.currentState!
                              //           .saveAndValidate()) {
                              //         compose_page(_fbKey.currentState!.value);
                              //         print(_fbKey.currentState!.value);
                              //       }
                              //     },
                              //   ),
                              // ),
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
      // drawer: manu(),
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.black,
        title: Center(child: const Text('แก้ไขข้อมูลส่วนตัว')),
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
              colors: [ThemeBc.orange, ThemeBc.pinkAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              emergecyPage1(),
            ],
          ),
        ),
      ),
    );
  }
}

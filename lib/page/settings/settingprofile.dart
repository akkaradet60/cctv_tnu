import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:cctv_tun/page/profile/app_reducer.dart';
import 'package:cctv_tun/page/profile/profile_action.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

                                    "user_lastname":
                                        formValues['user_lastname'],
                                    "user_firstname":
                                        formValues['user_firstname'],
                                    "user_card_id": formValues['user_card_id'],
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
                                Alert(
                                  context: context,
                                  // title: "แจ้งเตือน",
                                  type: AlertType.success,
                                  desc: '${profilee['data']}',
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "ปิด",
                                        style: TextStyle(
                                            color: ThemeBc.white, fontSize: 18),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/login_page'),
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
                                        style: TextStyle(
                                            color: ThemeBc.white, fontSize: 18),
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
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '${profile['user_firstname']}',
                                  name: "user_firstname",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    helperText: 'ชื่อ',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '${profile['user_lastname']}',
                                  name: "user_lastname",
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    helperText: 'นามสกุล',

                                    // hintText: 'อีเมล',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '${profile['user_card_id']}',
                                  name: "user_card_id",
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    helperText: 'รหัสบัตรประจำประชาชน',

                                    // hintText: 'อีเมล',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '${profile['user_email']}',
                                  name: "user_email",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'อีเมล',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '',
                                  name: "province",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'จังหวัด',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '',
                                  name: "district",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'อำเภอ',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '',
                                  name: "district",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'ตำบล',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '',
                                  name: "address",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'ที่อยู่',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              NeumorphicButton(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  initialValue: '',
                                  name: "zipcode",
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperText: 'รหัสไปรษณีย์',

                                    // hintText: 'เบอร์โทรศัพท์',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 390,
                                height: 45,
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                color: Colors.transparent,
                                child: Container(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_fbKey.currentState!
                                          .saveAndValidate()) {
                                        // compose_page(
                                        //     _fbKey.currentState!.value);
                                        print(_fbKey.currentState!.value);
                                      }
                                    },
                                    icon: Icon(Icons.description),
                                    label: Text('ล็อกอินด้วย facebook'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.grey[700],
                                      elevation: 30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                    ),
                                  ),
                                ),
                              ), // Expanded(
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
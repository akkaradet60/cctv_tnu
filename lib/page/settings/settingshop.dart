import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:form_field_validator/form_field_validator.dart';

class settingshop extends StatefulWidget {
  @override
  _settingshopState createState() => _settingshopState();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _settingshopState extends State<settingshop>
    with SingleTickerProviderStateMixin {
  final tabList = ['แจ้งเหตุฉุกเฉิน', 'เหตุฉุกเฉินของท่าน'];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

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
                initialValue: const {
                  'firstname': '',
                  'phone': '',
                  'detailed': '',
                  'type': '',
                  'coordinateslat': '',
                  'coordinateslng': '',
                  'time1': '',
                  'time2': '',
                  'deliver': '',
                  'preparegoods': '',
                },
                // autovalidateMode: AutovalidateMode
                //     .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text('ข้อมูลร้านค้า', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "firstname",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          helperText: 'ชื่อร้าน',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนข้อมูลชื่อด้วย"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderDropdown(
                        name: "type",
                        decoration: InputDecoration(
                          labelText: 'เลือกประเภทร้าน',
                        ),
                        // initialValue: 'Male',
                        allowClear: true,
                        hint: Text('เลือกประเภทการแจ้งเหตุ'),
                        validator: RequiredValidator(
                            errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
                        initialValue: '1',
                        items: [
                          DropdownMenuItem(
                              value: '1', child: Text('เครื่องแต่งกาย')),
                          DropdownMenuItem(
                              value: '2', child: Text('เครื่องสำอาง')),
                          DropdownMenuItem(value: '3', child: Text('สมุนไพร')),
                          DropdownMenuItem(
                              value: '4', child: Text('เครื่องดื่ม')),
                          DropdownMenuItem(
                              value: '5', child: Text('เครื่องดนตรี')),
                          DropdownMenuItem(
                              value: '6',
                              child: Text('ของที่ระลึกและศิลประดิษฐ์')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "detailed",
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          helperText: 'รายละเอียด',

                          // hintText: 'อีเมล',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนข้อมูลอีเมลด้วย"),
                          // EmailValidator(errorText: "รูปแบบอีเมล์ไม่ถูกต้อง"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "phone",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'เบอร์ร้านค้า',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนเบอร์โทรศัพท์ด้วย"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('พิกัดร้านค้า', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "coordinateslat",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'lat',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนพิกัดร้านค้าด้วย"),
                        ]),
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
                        name: "coordinateslng",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'lng',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนพิกัดร้านค้าด้วย"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('เวลาทำการ', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "time1",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'เวลาเริ่มต้น',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนเวลาเริ่มต้น"),
                        ]),
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
                        name: "time2",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'เวลาสิ้นสุด',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนเวลาสิ้นสุด"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('การจัดส่ง', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        initialValue: '',
                        name: "preparegoods",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'ระยะเวลาเตรียมสินค้า',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "ป้อนระยะเวลาเตรียมสินค้า"),
                        ]),
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
                        name: "deliver",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          helperText: 'ค่าส่งต่อครั้ง',

                          // hintText: 'เบอร์โทรศัพท์',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนค่าส่งต่อครั้ง"),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('วันในการทำงาน', style: TextStyle(fontSize: 18)),

                    const SizedBox(height: 10),
                    // Container(
                    //   child: Card(
                    //     child: Column(
                    //       children: [
                    //         const SizedBox(height: 10),
                    //         const Text('วันที่ทำการ',
                    //             style: TextStyle(fontSize: 18)),
                    //         const SizedBox(height: 10),
                    //         FormBuilderCheckboxGroup(
                    //           name: "day1",
                    //           options: [
                    //             FormBuilderFieldOption(
                    //                 value: 'Test', child: Text('Test')),
                    //             FormBuilderFieldOption(
                    //                 value: 'Test 1', child: Text('Test 1')),
                    //             FormBuilderFieldOption(
                    //                 value: 'Test 2', child: Text('Test 2')),
                    //             FormBuilderFieldOption(
                    //                 value: 'Test 3', child: Text('Test 3')),
                    //             FormBuilderFieldOption(
                    //                 value: 'Test 4', child: Text('Test 4')),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Card(
                      child: FormBuilderCheckboxGroup(
                        name: 'filter_chip',
                        decoration: InputDecoration(),
                        options: [
                          FormBuilderFieldOption(
                              value: 'Monday', child: Text('จันทร์')),
                          FormBuilderFieldOption(
                              value: 'Tuesday', child: Text('อังคาร')),
                          FormBuilderFieldOption(
                              value: 'Wednesday', child: Text('พุธ')),
                          FormBuilderFieldOption(
                              value: 'Thursday', child: Text('พฤหัสบดี')),
                          FormBuilderFieldOption(
                              value: 'Friday', child: Text('ศุกร์')),
                          FormBuilderFieldOption(
                              value: 'Saturday', child: Text('วันเสาร์')),
                          FormBuilderFieldOption(
                              value: 'Sunday', child: Text('วันอาทิตย์')),
                        ],
                      ),
                    ),

                    /* FormBuilder(
                      child: Container(
                        child: Card(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text('วันที่ทำการ',
                                  style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 10),
                              FormBuilderCheckbox(
                                name: "day1",
                                initialValue: false,
                                title: const Text('จันทร์'),
                              ),
                              FormBuilderCheckbox(
                                name: "day2",
                                initialValue: false,
                                title: const Text('อังคาร'),
                              ),
                              FormBuilderCheckbox(
                                name: "day3",
                                initialValue: false,
                                title: const Text('พุธ'),
                              ),
                              FormBuilderCheckbox(
                                name: "day4",
                                initialValue: false,
                                title: const Text('พฦหัสบดี'),
                              ),
                              FormBuilderCheckbox(
                                name: "day5",
                                initialValue: false,
                                title: const Text('ศุกร์'),
                              ),
                              FormBuilderCheckbox(
                                name: "day6",
                                initialValue: false,
                                title: const Text('เสาร์'),
                              ),
                              FormBuilderCheckbox(
                                name: "day7",
                                initialValue: false,
                                title: const Text('อาทิตย์'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      label: const Text('บันทึก'),
                      icon: const Icon(Icons.save),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 15),
                        padding: const EdgeInsets.all(15),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          print(_fbKey.currentState!.value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      label: const Text('อีกที่'),
                      icon: const Icon(Icons.offline_bolt),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 15),
                        padding: const EdgeInsets.all(15),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settingpro'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(child: const Text('ร้านค้า')),
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
              colors: [ThemeBc.white, ThemeBc.white],
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

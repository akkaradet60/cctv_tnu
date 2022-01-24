import 'package:cctv_tun/page/manu/manu.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
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
  // List<Data> data = [];
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
                        initialValue: '',
                        name: "firstname",
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
                        initialValue: '',
                        name: "surname",
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
                        initialValue: '',
                        name: "cardcode",
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
                        initialValue: '',
                        name: "email",
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
                        primary: Colors.orange,
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
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // drawer: manu(),
      // drawer: Icon(Icons.ac_unit, color: white),
      appBar: AppBar(
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
              colors: [Colors.pinkAccent, Colors.orangeAccent],
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

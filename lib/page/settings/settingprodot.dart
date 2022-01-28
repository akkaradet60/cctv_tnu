import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';

class settingprodot extends StatefulWidget {
  settingprodot({Key? key}) : super(key: key);

  @override
  _warn1State createState() => _warn1State();
}

class _warn1State extends State<settingprodot> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Widget im1() {
      return Container();
    }

    Widget icon() {
      return Column();
    }

    Widget title() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _fbKey,
                initialValue: const {},
                // autovalidateMode: AutovalidateMode
                //     .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Column(
                          children: [
                            FormBuilderImagePicker(
                              name: 'photos',
                              decoration: const InputDecoration(labelText: ''),
                              maxImages: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Column(
                        children: [
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: Colors.white,
                            ),
                            child: FormBuilderTextField(
                              initialValue: '',
                              name: "name",
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                helperText: 'ชื่อสินค้า',

                                // hintText: 'เบอร์โทรศัพท์',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "ป้อนชื่อสินค้า"),
                              ]),
                            ),
                          ),
                          SizedBox(height: 5),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: Colors.white,
                            ),
                            child: FormBuilderDropdown(
                              name: "type",
                              decoration: InputDecoration(
                                labelText: 'เลือกประเภทสินค้า',
                              ),
                              // initialValue: 'Male',
                              allowClear: true,
                              hint: Text('เลือกประเภทสินค้า'),

                              initialValue: '1',
                              items: [
                                DropdownMenuItem(
                                    value: '1', child: Text('อาหาร')),
                                DropdownMenuItem(
                                    value: '2', child: Text('อาหารคลีน')),
                                DropdownMenuItem(
                                    value: '3', child: Text('มือถือ')),
                                DropdownMenuItem(
                                    value: '4', child: Text('ขนมไทย')),
                                DropdownMenuItem(
                                    value: '5', child: Text('เครื่องใช้ไฟฟ้า')),
                                DropdownMenuItem(
                                    value: '6',
                                    child: Text('อุปกรณ์สัตว์เลี้ยง')),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          NeumorphicButton(
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: Colors.white,
                            ),
                            child: FormBuilderTextField(
                              initialValue: '',
                              name: "detailed",
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                helperText: 'รายละเอียดร้านค้า',

                                // hintText: 'เบอร์โทรศัพท์',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "ป้อนรายละเอียดร้านค้า"),
                              ]),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(height: 5),
                          Card(
                            child: Container(
                                child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text('การจัดส่ง',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 10),
                                NeumorphicButton(
                                  style: const NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    color: Colors.white,
                                  ),
                                  child: FormBuilderTextField(
                                    initialValue: '',
                                    name: "price",
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      helperText: 'ราคา',
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                                FormBuilderCheckboxGroup(
                                  name: 'filter_chip',
                                  decoration: InputDecoration(),
                                  options: [
                                    FormBuilderFieldOption(
                                        value: 'no', child: Text('ไม่มี')),
                                  ],
                                ),
                              ],
                            )),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  onPressed: () {
                                    if (_fbKey.currentState!
                                        .saveAndValidate()) {
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
                  ],
                ),
              ),
            ],
          ),
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
        backgroundColor: ThemeBc.black,
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
              icon(),
              title(),
            ],
          ),
        ),
      ),
    );
  }
}

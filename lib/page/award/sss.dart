import 'dart:convert';
import 'dart:io';

import 'package:cctv_tun/page/global/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    //Uri uri = Uri.parse('http://localhost/nt/cctv_web_api/test/index.php');
    // http.MultipartRequest request = http.MultipartRequest('POST', uri);

    // request.files.add(
    //   http.MultipartFile(
    //     'files',
    //     selectedImage!.readAsBytes().asStream(),
    //     selectedImage!.lengthSync(),
    //     filename: selectedImage!.path.split('/').last,
    //   ),
    // );

    // http.StreamedResponse response = await request.send();
    // var responseBytes = await response.stream.toBytes();
    // var responseString = utf8.decode(responseBytes);

    // print('\n\n');
    // print('RESPONSE WITH HTTP');
    // print(responseString);
    // print('\n\n');
    // return responseString;

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
                ? Text(
                    'Please Pick a image to Upload',
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

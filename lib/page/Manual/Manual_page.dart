import 'dart:convert';

import 'package:cctv_tun/models/Manual/Manual.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class manual_page extends StatefulWidget {
  manual_page({Key? key}) : super(key: key);

  @override
  _help_pageState createState() => _help_pageState();
}

class _help_pageState extends State<manual_page> {
  List<Data> data = [];
  bool isLoading = true;
  Future<void> getData() async {
    var url =
        'https://www.bc-official.com/api/app_nt/api/app/manual/restful/?manual_app_id=${Global.app_id}';
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${Global.token}'});
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      //นำ json ใส่ที่โมเมล product
      final Manuals paroduct = Manuals.fromJson(json.decode(response.body));
      print(paroduct.data);
      setState(() {
        data = paroduct.data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('error 400');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image:
                                  NetworkImage('${data[index].manualPathName}'),
                              fit: BoxFit.fill)),
                    ),
                    /* leading: Image.network(
                '${data[index].picture}',
                width: 80,
                height: 80,
                
              ),*/
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.length),
      ),
    );
  }
}

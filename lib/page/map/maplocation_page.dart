import 'dart:async';

import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class maplocation_page extends StatefulWidget {
  maplocation_page({Key? key}) : super(key: key);

  @override
  _maplocation_page createState() => _maplocation_page();
}

class _maplocation_page extends State<maplocation_page> {
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

  var hotlinee;

  late Position userLocation;

  @override
  Widget build(BuildContext context) {
    hotlinee = ModalRoute.of(context)!.settings.arguments;
    var app_lat = double.parse(hotlinee['travelLat'] ?? "102.83473877038512");
    var app_lng = double.parse(hotlinee['travelLng'] ?? "102.83473877038512");

    // CameraPosition cameraPosition = CameraPosition(
    //   target: LatLng(app_lat, app_lng),
    //   zoom: 14,
    // );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Container(
          height: 50,
          width: 300,
          child: Column(
            // scrollDirection: Axis.horizontal,
            children: [
              SizedBox(height: 10),
              Center(
                  child: Text(
                '${hotlinee['travelName']}',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.textwhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: const Text('แจ้งเหตุฉุกเฉิน')));
            },
          ),
        ],
      ),
      body: Container(
        height: 1000,
        child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 500,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            height: 400,
                            child: Column(
                              children: [
                                Flexible(
                                    child: FlutterMap(
                                  options: MapOptions(
                                      center: LatLng(app_lat, app_lng),
                                      zoom: 13),
                                  layers: [
                                    TileLayerOptions(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c'],
                                      attributionBuilder: (_) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "เทศบาลมหาสารคาม",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.textblack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    MarkerLayerOptions(markers: [
                                      Marker(
                                        point: LatLng(app_lat, app_lng),
                                        builder: (ctx) => const Icon(
                                          Icons.where_to_vote,
                                          size: 15,
                                        ),
                                      )
                                    ]),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Text(
                                'ชื่อสถานที่ : ${hotlinee['travelName']}',
                                style: GoogleFonts.sarabun(
                                  textStyle: TextStyle(
                                    color: ThemeBc.textblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  height: 220,
                                  child: ListView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${hotlinee['detail']}',
                                          style: GoogleFonts.sarabun(
                                            textStyle: TextStyle(
                                              color: ThemeBc.textblack,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '  ${hotlinee['travelDetail']}',
                                          style: GoogleFonts.sarabun(
                                            textStyle: TextStyle(
                                              color: ThemeBc.textblack,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
              );
            } else {
              return Center(
                child: Column(

                    // mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     CircularProgressIndicator(),
                    //    ],
                    ),
              );
            }
          },
        ),
      ),
    );
  }
}

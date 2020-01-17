import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nobetcieczane/models/eczane.dart';
import 'package:nobetcieczane/services/database.dart';
import 'package:nobetcieczane/views/home.dart';
import 'package:nobetcieczane/views/splashscreen.dart';
import 'package:device_info/device_info.dart';

void main() => runApp(EczaneApp());

class EczaneApp extends StatefulWidget {
  @override
  _EczaneAppState createState() => _EczaneAppState();
}

class _EczaneAppState extends State<EczaneApp> {
  Widget currPage = SplashScreen();

  void loadData() async {
    String url = 'https://api.collectapi.com/health/dutyPharmacy?il=Edirne';
    await http.get(url, headers: {
      'Authorization': 'apikey 2JzEKfeq6JnRHWwFjp7UWT:6z6uuDbO1UwJjtToz41YV5'
    }).then((response) {
      var body = json.decode(response.body);
      if (body['success'] == true) {
        Iterable list = body['result'];
        List<Eczane> eczaneler = list.map((e) => Eczane.fromJson(e)).toList();
        setState(() {
          currPage = HomePage(eczaneList: eczaneler);
        });
      } else {
        print(body['result']);
      }
    });
  }

  void deviceUserRegister() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    DatabaseService databaseService = new DatabaseService();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      databaseService.addRegister(iosInfo.identifierForVendor, iosInfo.utsname.machine, iosInfo.model);
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      databaseService.addRegister(androidInfo.androidId, androidInfo.model, androidInfo.device);
    }
  }

  @override
  void initState() {
    deviceUserRegister();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edirne Nöbetçi Eczaneler',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: currPage,
      debugShowCheckedModeBanner: false,
    );
  }
}

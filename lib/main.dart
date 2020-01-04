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
  List<Eczane> _eczaneler = [];
  bool isLoadData = false;

  void loadData() async {
    String url =
        'https://api.collectapi.com/health/dutyPharmacy?il=Edirne&ilce=Merkez';
    await http.get(url, headers: {
      'Authorization': 'apikey 5TkZjC8DHEeMRfcUMECd8M:1Omp01sESJDfJncCYqbTkS'
    }).then((response) {
      var body = json.decode(response.body);
      if (body['success']) {
        Iterable list = body['result'];
        _eczaneler = list.map((e) => Eczane.fromJson(e)).toList();
      } else {
        _showDialog(Text('Dikkat !'), Text(body['result']));
        _eczaneler = [];
      }
      setState(() {
        isLoadData = true;
      });
    }).catchError((onError) {
      _showDialog(Text('Beklenmedik Hata'), Text(onError.toString()));
      print(onError);
      setState(() {
        _eczaneler = [];
        isLoadData = true;
      });
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
    this.loadData();
    super.initState();
  }

  void _showDialog(Widget title, Widget content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edirne Nöbetçi Eczaneler',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: isLoadData ? HomePage(eczaneler: _eczaneler) : SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

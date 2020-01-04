import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetcieczane/models/eczane.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  const Detail({Key key, this.eczane}) : super(key: key);

  final Eczane eczane;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex;
  static CameraPosition _kLake;
  static List<Marker> _markers = [];

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.eczane.enlem),
          double.parse(widget.eczane.boylam)),
      zoom: 14,
    );
    _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(double.parse(widget.eczane.enlem),
          double.parse(widget.eczane.boylam)),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
    _markers.add(
      new Marker(
        markerId: MarkerId("value"),
        position: LatLng(double.parse(widget.eczane.enlem),
            double.parse(widget.eczane.boylam)),
        draggable: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eczane.adi),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              _goToTheLake();
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              _callPhone('tel:' + widget.eczane.tel);
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SelectableText(
              widget.eczane.ilce,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SelectableText(widget.eczane.acikAdres),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _callPhone(String telNo) async {
    // arama yap
    if (await canLaunch(telNo)) {
      await launch(telNo);
    } else {
      throw 'Başlatılamadı: $telNo';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 20.0, height: 100.0),
            Text(
              "Edirne Eczaneler",
              style: TextStyle(fontSize: 27.0, color: Colors.white70),
            ),
            SizedBox(width: 20.0, height: 30.0),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 20.0, height: 30.0),
            FadeAnimatedTextKit(
              text: ["Eczaneler Yükleniyor..."],
              textStyle: TextStyle(
                  fontSize: 40.0, fontFamily: "Horizon", color: Colors.white),
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.center, // or Alignment.topLeft
            ),
          ],
        ),
      ),
    );
  }
}

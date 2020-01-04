import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/eczane.dart';
import 'package:nobetcieczane/views/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.eczaneler}) : super(key: key);

  final List<Eczane> eczaneler;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nöbetçi Eczaneler'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: ListView.builder(
          itemCount: widget.eczaneler.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              leading: Image(
                image: AssetImage('assets/images/eczane-icon.png'),
              ),
              title: Text(widget.eczaneler[i].adi),
              subtitle: Text(widget.eczaneler[i].ilce),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      eczane: widget.eczaneler[i],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

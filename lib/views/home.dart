import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/eczane.dart';
import 'package:nobetcieczane/views/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.eczaneList}) : super(key: key);

  final List<Eczane> eczaneList;

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
          itemCount: widget.eczaneList.length,
          itemBuilder: (BuildContext context, int i) {
            if(widget.eczaneList[i].enlem == '' && widget.eczaneList[i].boylam == ''){
              return SizedBox(height: 0,);
            }
            return ListTile(
              leading: Image(
                image: AssetImage('assets/images/eczane-icon.png'),
              ),
              title: Text(widget.eczaneList[i].adi),
              subtitle: Text(widget.eczaneList[i].ilce),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      eczane: widget.eczaneList[i],
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

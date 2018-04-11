import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var results = [];

  _getIPAddress() async {
    var url = 'https://raw.githubusercontent.com/HackersAtivistas/lavajato/master/lista_lavajato.json';
    var httpClient = new HttpClient();

    List<dynamic> resultData;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonString = await response.transform(utf8.decoder).join();
        resultData = json.decode(jsonString);
      }
    } catch (exception) {
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;
    setState(() {
      results = resultData;
    });
  }

  List<Column> buildCards (List<dynamic> arr) {
    List<Column> out = arr.map((el) {
      return new Column(
          children: <Widget>[
              new Image.network(el['foto']),
              new Text(el['nome']),
            ],
          );
        }
      ).toList();
    return out;
  }

  @override
  Widget build(BuildContext context) {
    _getIPAddress();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lava Jato')
      ),
      body: new Center(
        child: new GridView.count(
            childAspectRatio: .6,
            primary: false,
            padding: new EdgeInsets.all(8.0),
            crossAxisSpacing: 10.0,
            // mainAxisSpacing: 40.0,
            crossAxisCount: 3,
            children: buildCards(this.results)
          ),
        ),
      );
  }
}
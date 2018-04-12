import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'details.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => MyHomePage(),
      '/home': (BuildContext context) => MyHomePage(),
      '/details': (BuildContext context) => DetailsPage(MyHomePage.selected)
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  static dynamic selected;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchBar searchBar;
  String filter = '';
  var results = [];
  var filtred = [];

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('My Home Page'),
        actions: [searchBar.getSearchAction(context)]);
  }

  _MyHomePageState() {
    searchBar = new SearchBar(
        inBar: true,
        setState: setState,
        closeOnSubmit: false,
        clearOnSubmit: false,
        onSubmitted: search,
        buildDefaultAppBar: buildAppBar);
  }

  _loadPoliticians() async {
    var url =
        'https://raw.githubusercontent.com/HackersAtivistas/lavajato/master/lista_lavajato.json';
    var httpClient = new HttpClient();

    List<dynamic> resultData;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonString = await response.transform(utf8.decoder).join();
        resultData = json.decode(jsonString);
      }
    } catch (exception) {}

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;
    if (resultData == null) return;
    setState(() {
      results = resultData;
      filtred = resultData
          .where((e) => e['nome']
              .toString()
              .toLowerCase()
              .contains(this.filter.toString().toLowerCase()))
          .toList();
    });
  }

  List<Column> buildCards(List<dynamic> arr) {
    List<Column> out = arr.map((el) {
      return new Column(
        children: <Widget>[
          new Image.network(el['foto']),
          new Text(el['nome']),
          new FlatButton(
            onPressed: () => {
                  MyHomePage.selected = el:
                      Navigator.of(context).pushNamed('/details')
                },
            child: Text('Ver Mais'),
          )
        ],
      );
    }).toList();
    return out;
  }

  search(filter) {
    setState(() {
      this.filter = filter;
      filtred = results
          .where((e) => e['nome']
              .toString()
              .toLowerCase()
              .contains(filter.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadPoliticians();
    return new Scaffold(
      appBar: searchBar.build(context),
      body: new Center(
        child: new GridView.count(
            childAspectRatio: .4,
            primary: false,
            padding: new EdgeInsets.all(2.0),
            crossAxisSpacing: 10.0,
            // mainAxisSpacing: 40.0,
            crossAxisCount: 3,
            children: buildCards(this.filtred)),
      ),
    );
  }
}

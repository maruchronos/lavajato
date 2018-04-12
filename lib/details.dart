import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  // DetailsPage({Key key, Object selected}) : super(key: key);
  DetailsPage(this.politician);
  final dynamic politician;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Detalhes')),
      body: new Center(
          child: new Card(
              elevation: 5.0,
              child: new Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new Image.network(politician['foto']),
                    new Text(politician['nome']),
                    new Text(politician['partido']),
                    new Text(politician['cargo']),
                    new Text(politician['acusacao']),
                    new Text('Apelido: ' + politician['apelido']),
                  ],
                ),
              ))),
    );
  }
}
